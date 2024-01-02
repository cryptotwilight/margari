// SPDX-License-Identifier: APACHE 2.0
pragma solidity ^0.8.23;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import "../interfaces/IMVersion.sol";
import "../interfaces/IGiltContract.sol";
import "../interfaces/IMRegister.sol";
import "../interfaces/IGVaultFactory.sol";
import "../interfaces/IGVault.sol";


contract GiltContract is ERC721, IMVersion, IGiltContract {

    modifier senderOnly { 
        require(msg.sender == register.getAddress(SENDER_CA), "sender only");
        _;
    }

    modifier recieverOnly { 
        require(msg.sender == register.getAddress(RECIEVER_CA), "sender only");
        _;
    }

    string constant nme = "RESERVED_GILT_CONTRACT";
    uint256 constant version = 1; 

    string constant SENDER_CA = "RESERVED_M_SENDER";
    string constant RECIEVER_CA = "RESERVED_M_RECIEVER";
    string constant VAULT_FACTORY_CA = "RESERVED_G_VAULT_FACTORY";

    address immutable self; 

    IMRegister register;

    mapping(uint256=>Gilt) giltById; 
    mapping(uint256=>bool) isLockedByGiltId; 
    mapping(uint256=>bool) isLocalBondedByGiltId;
    mapping(uint256=>address) vaultByGiltId;  
    mapping(uint256=>TransmittedGilt) transmittedGiltByLocalId; 


    constructor(address _register, string memory _name, string memory _symbol) ERC721(_name, _symbol){
        register = IMRegister(_register);
        self = address(this);
    }

    function getName() pure external returns (string memory _name) {
        return nme; 
    }

    function getVersion() pure external returns (uint256 _version) {
        return version; 
    }

    function getGilt(uint256 _giltId) view external returns (Gilt memory _gilt) {
        return giltById[_giltId];
    }

    // only local gilts are bonded locally
    function isLocalBonded(uint256 _giltId) view external returns (bool _isLocalBonded){
        return isLocalBondedByGiltId[_giltId];
    }

    function bondFunds(address _erc20, uint256 _amount) external payable returns (Gilt memory _gilt){
        uint256 giltId_ = getIndex();
        IERC20 erc20_ = IERC20(_erc20);

        erc20_.transferFrom(msg.sender, self, _amount);
      
        _gilt = giltById[giltId_] = Gilt({
                                            erc20 : _erc20,
                                            amount : _amount,  
                                            creationDate : block.timestamp, 
                                            chainId : register.getChainId(),  
                                            giltContract : self,
                                            id : giltId_
                                        });
        
        IGVault vault_ = IGVault(IGVaultFactory(register.getAddress(VAULT_FACTORY_CA)).createVault(_gilt));
        erc20_.approve(address(vault_), _amount); 
        vault_.storeFunds();

        vaultByGiltId[giltId_] = address(vault_);
        isLocalBondedByGiltId[giltId_] = true; 

        _mint(msg.sender, giltId_);
        return _gilt; 
    }

    function unBondFunds(Gilt memory _gilt) external returns (address _erc20, uint256 _amount, address _to){
        require(ownerOf(_gilt.id) == msg.sender, " owner mismatch ");
        require(isLocalBondedByGiltId[_gilt.id], " gilt not locally bonded ");
        require(!isLockedByGiltId[_gilt.id], " gilt locked ");

        isLocalBondedByGiltId[_gilt.id] = false;

        _burn(_gilt.id);

        IGVault vault_ = IGVault(vaultByGiltId[_gilt.id]);
        vault_.releaseFunds(); 
        _erc20 = _gilt.erc20; 
        _amount = _gilt.amount; 
        IERC20 erc20_ = IERC20(_erc20);
        _to = msg.sender; 

        erc20_.transferFrom(address(vault_), self, _amount);
        erc20_.transfer(_to, _amount);

        return (_erc20, _amount, _to);
    }
   
    // Transmitted Gilts are minted to the local Gilt Contract (they cannot be unbonded locally) 
    function mintLocalisedGilt(TransmittedGilt memory _tGilt, address _to) external recieverOnly returns (Gilt memory _gilt){
    
        uint256 giltId_ = getIndex(); 
        transmittedGiltByLocalId[giltId_] = _tGilt;

        _gilt = giltById[giltId_] = Gilt({
                                            erc20 : _tGilt.gilt.erc20,
                                            amount : _tGilt.gilt.amount,  
                                            creationDate : block.timestamp, 
                                            chainId : _tGilt.gilt.chainId,  
                                            giltContract : self,
                                            id : giltId_
                                        });
        _mint(_to, giltId_);
        return _gilt; 
    }

    function burnLocalisedGilt(Gilt memory _gilt) external senderOnly returns (TransmittedGilt memory _tGilt){
        require(ownerOf(_gilt.id) == msg.sender, " owner mis-match ");
        require(!isLocalBondedByGiltId[_gilt.id], " locally bonded gilt ");
        
        _tGilt = transmittedGiltByLocalId[_gilt.id];
        _burn(_gilt.id);

        return _tGilt; 
    }

    // Bonded Gilts are locked on the local chain in preparation for transit
    function isLocked(uint256 _giltId) view external returns (bool _isLocked){
        return isLockedByGiltId[_giltId];
    }

    function lockGilt(uint256 _giltId) external senderOnly returns (Gilt memory _gilt){
        require(ownerOf(_giltId) == msg.sender, " owner mismatch ");
        require(!isLockedByGiltId[_giltId], " gilt locked ");
        isLockedByGiltId[_giltId] = true; 
        return giltById[_giltId];
    }

    function unlockGilt(uint256 _giltId) external recieverOnly returns (Gilt memory _gilt){
        require(isLockedByGiltId[_giltId], " gilt not locked ");
        isLockedByGiltId[_giltId] = false; 
        return giltById[_giltId];
    }

    //============================== INTERNAL =========================================================

    uint256 index; 

    function getIndex() internal returns (uint256 _index){
        _index = index++;
        return _index; 
    }
 }