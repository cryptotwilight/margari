// SPDX-License-Identifier: APACHE 2.0
pragma solidity ^0.8.23;

import "../interfaces/IMVersion.sol";
import "../interfaces/IMReciever.sol";
import "../interfaces/IMRegister.sol";

import "../interfaces/IGiltContract.sol";

import {TransmittedGilt} from "../interfaces/IMStructs.sol";

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

import {CCIPReceiver} from "@chainlink/contracts-ccip/src/v0.8/ccip/applications/CCIPReceiver.sol";
import "@chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol";


contract MReciever is CCIPReceiver, IMReciever, IMVersion {

    

    event GILT_RECIEVED(address owner, uint256 amount, uint256 foreignId, uint256 srcChain);

    event GILT_CLAIMED(address owner, uint256 amount, bytes32 tGiltId, uint256 srcChain, uint256 localGiltId);

    modifier margariOnly {
        require(msg.sender == register.getAddress(MARGARI_CA), "margari only");
        _;
    }

    string constant name = "RESERVED_M_RECIEVER";
    uint256 constant version = 2; 

    string constant MARGARI_CA = "RESERVED_MARGARI_CORE";

    IMRegister register; 
    IERC721 gcIerc721; 
    IGiltContract giltContract; 

    bytes32 [] tGiltIds; 
    mapping(bytes32=>TransmittedGilt) tGiltById; 
    mapping(address=>bytes32[]) tGiltIdsByOwner; 
    mapping(address=>bytes32[]) claimedTGiltIdsByOwner; 
    mapping(bytes32=>bool) isClaimedByGiltId; 

    constructor(address _register, address _router) CCIPReceiver(_router) {
        register = IMRegister(_register);
    }

    function getName() pure external returns (string memory _name) {
        return name; 
    }

    function getVersion() pure external returns (uint256 _version) {
        return version; 
    }

    function _ccipReceive(Client.Any2EVMMessage memory _message) internal override {
        TransmittedGilt memory _tGilt = abi.decode(_message.data, (TransmittedGilt));
        bytes32 _localId = keccak256(_message.data);
        tGiltById[_localId] = _tGilt; 

        tGiltIdsByOwner[_tGilt.owner].push(_localId);
        tGiltIds.push(_localId);

        emit GILT_RECIEVED(_tGilt.owner, _tGilt.gilt.amount, _tGilt.gilt.id, _tGilt.gilt.chainId);
    }

    function getTGiltIds() view external returns (bytes32 [] memory _tGiltIds) {
        return tGiltIds; 
    }

    function getTransmittedGilt(bytes32 _tGiltId) view external returns (TransmittedGilt memory tGilt) {
        return tGiltById[_tGiltId];
    }

    function viewAvailableGiltClaims(address _claimant)  view external returns (Gilt [] memory _gilts) {
        bytes32 [] memory unclaimedGilts_ = tGiltIdsByOwner[_claimant];
        _gilts = new Gilt[](unclaimedGilts_.length);
        for(uint256 x = 0; x < unclaimedGilts_.length; x++) {   
            bytes32 tGiltId_ = unclaimedGilts_[x]; 
            TransmittedGilt memory tGilt_ = tGiltById[tGiltId_];
            _gilts[x] = tGilt_.gilt; 
        }
        return _gilts;
    }

    function claimGilts(address _claimant) external margariOnly returns (GiltClaim [] memory _giltClaims){
        bytes32 [] memory unclaimedGilts = tGiltIdsByOwner[_claimant];
        delete tGiltIdsByOwner[_claimant]; // clear claims

        _giltClaims = new GiltClaim[](unclaimedGilts.length);
        for(uint256 x = 0; x < unclaimedGilts.length; x++) {    
            bytes32 tGiltId_ = unclaimedGilts[x];
            TransmittedGilt memory tGilt_ = tGiltById[tGiltId_];
            
            Gilt memory localGilt_ = giltContract.mintLocalisedGilt(tGilt_, _claimant);
            
            claimedTGiltIdsByOwner[_claimant].push(tGiltId_);
            
            _giltClaims[x] = GiltClaim({
                                            projectId : tGilt_.projectId, 
                                            giltId : tGilt_.gilt.id, 
                                            chainId : tGilt_.gilt.chainId
                                        });
            emit GILT_CLAIMED(_claimant, tGilt_.gilt.amount, tGiltId_, tGilt_.gilt.chainId, localGilt_.id);
        }
        return _giltClaims; 
    }


    // ========================== INTERNAL =============================================================

    
}


