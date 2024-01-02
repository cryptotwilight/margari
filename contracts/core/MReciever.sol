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

    string constant name = "RESERVED_M_RECIEVER";
    uint256 constant version = 1; 

    IMRegister register; 
    IERC721 gcIerc721; 
    IGiltContract giltContract; 

    uint256 [] tGiltIds; 
    mapping(address=>uint256[]) tGiltIdsByOwner; 
    mapping(address=>uint256[]) claimedTGiltIdsByOwner; 
    mapping(uint256=>TransmittedGilt) tGiltById; 

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
        tGiltById[_tGilt.gilt.id] = _tGilt; 
        tGiltIdsByOwner[_tGilt.owner].push(_tGilt.gilt.id);
        tGiltIds.push(_tGilt.gilt.id);
    }

    function getTGiltIds() view external returns (uint256 [] memory _tGiltIds) {
        return tGiltIds; 
    }

    function getTransmittedGilt(uint256 _tGiltId) view external returns (TransmittedGilt memory tGilt) {
        return tGiltById[_tGiltId];
    }

    function claimGilts(address _claimant) external returns (GiltClaim [] memory _giltClaims){
        uint256 [] memory unclaimedGilts = tGiltIdsByOwner[_claimant];
        delete tGiltIdsByOwner[_claimant]; // clear claims

        _giltClaims = new GiltClaim[](unclaimedGilts.length);
        for(uint256 x = 0; x < unclaimedGilts.length; x++) {    
            TransmittedGilt memory tGilt_ = tGiltById[unclaimedGilts[x]];
            
            giltContract.mintLocalisedGilt(tGilt_, _claimant);
            
            claimedTGiltIdsByOwner[_claimant].push(tGilt_.gilt.id);
            
            _giltClaims[x] = GiltClaim({
                                            projectId : tGilt_.projectId, 
                                            giltId : tGilt_.gilt.id, 
                                            chainId : tGilt_.gilt.chainId
                                        });
        }
        return _giltClaims; 
    }


    // ========================== INTERNAL =============================================================

    
}


