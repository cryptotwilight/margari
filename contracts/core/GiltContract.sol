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
        require(msg.sender == register.getAddress(RECIEVER_CA), "reciever only");
        _;
    }

    modifier adminOnly { 
        require(msg.sender == register.getAddress(M_ADMIN_CA), "admin only" );
        _;
    }

    string constant nme = "RESERVED_GILT_CONTRACT";
    uint256 constant version = 10; 

    address constant NATIVE = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

    string constant SENDER_CA        = "RESERVED_M_SENDER";
    string constant RECIEVER_CA      = "RESERVED_M_RECIEVER";
    string constant VAULT_FACTORY_CA = "RESERVED_G_VAULT_FACTORY";
    string constant M_ADMIN_CA       = "RESERVED_M_ADMIN";

    address immutable self; 

    IMRegister register;
    IGVaultFactory factory;

    mapping(uint256=>bool) knownGilt; 
    mapping(uint256=>Gilt) giltById; 
    mapping(uint256=>bool) isLockedByGiltId; 
    mapping(uint256=>bool) isLocalBondedByGiltId;
    mapping(uint256=>address) vaultByGiltId;  
    mapping(uint256=>TransmittedGilt) transmittedGiltByLocalId; 

    constructor(address _register, string memory _name, string memory _symbol) ERC721(_name, _symbol){
        register = IMRegister(_register);
        factory = IGVaultFactory(register.getAddress(VAULT_FACTORY_CA));
        self = address(this);
    }

    function getName() pure external returns (string memory _name) {
        return nme; 
    }

    function getSelf() view external returns (address _self) {
        return self; 
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
        knownGilt[giltId_] = true; 
        IERC20 erc20_ = IERC20(_erc20);
        if(_erc20 == NATIVE) {
            require(msg.value >= _amount, "insufficient value transmitted");
        }
        else {
            erc20_.transferFrom(msg.sender, self, _amount);
        }
        _gilt = giltById[giltId_] = Gilt({
                                            erc20        : _erc20,
                                            amount       : _amount,  
                                            creationDate : block.timestamp, 
                                            chainId      : register.getChainId(),  
                                            giltContract : self,
                                            id           : giltId_
                                        });
             
        IGVault vault_ = IGVault(factory.createVault(_gilt));
        if(_erc20 == NATIVE){
            vault_.storeFunds{value : _amount}();
        }
        else {
            erc20_.approve(address(vault_), _amount); 
            vault_.storeFunds();
        }
        vaultByGiltId[giltId_] = address(vault_);
        
        isLocalBondedByGiltId[giltId_] = true; 

        _mint(msg.sender, giltId_);
        return _gilt; 
    }

    function unBondFunds(uint256 _giltId) external returns (address _erc20, uint256 _amount, address _to){
        require(knownGilt[_giltId], " unknown gilt");
        require(ownerOf(_giltId) == msg.sender, " owner mismatch ");
        require(isLocalBondedByGiltId[_giltId], " gilt not locally bonded ");
        require(!isLockedByGiltId[_giltId], " gilt locked ");

        transferFrom(msg.sender, self, _giltId);

        isLocalBondedByGiltId[_giltId] = false;
        Gilt memory gilt_ = giltById[_giltId];
        _burn(gilt_.id);

        IGVault vault_ = IGVault(vaultByGiltId[gilt_.id]);
        vault_.releaseFunds(); 

        _erc20 = gilt_.erc20; 
        _amount = gilt_.amount;
        _to = msg.sender;
        if(gilt_.erc20 == NATIVE) {
            payable(_to).transfer(gilt_.amount);
        }
        else {
            IERC20 erc20_ = IERC20(_erc20);
            erc20_.transferFrom(address(vault_), self, _amount);
            erc20_.transfer(_to, _amount);
        }
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

    function notifyChangeofAddress() external adminOnly returns (bool _acknowledged) {
        factory = IGVaultFactory(register.getAddress(VAULT_FACTORY_CA));
        return true; 
    }

    //============================== INTERNAL =========================================================

    uint256 index = 0; 

    function getIndex() internal returns (uint256 _index){
        _index = index++;
        return _index; 
    }
 }