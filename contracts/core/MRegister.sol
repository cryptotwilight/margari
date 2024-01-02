// SPDX-License-Identifier: APACHE 2.0
pragma solidity ^0.8.23;

import "../interfaces/IMRegister.sol";
import "../interfaces/IMVersion.sol";

struct RegistryEntry { 
    string name; 
    address vaddress;
    uint256 version; 
}

contract MRegister is IMRegister, IMVersion { 

    modifier adminOnly {
        require(msg.sender == admin, "admin only");
        _;
    }

    string constant name = "RESERVED_M_REGISTER";
    uint256 constant version = 2; 

    string constant M_ADMIN_CA = "RESERVED_M_ADMIN";


    IMRegister register; 

    address admin;
    uint256 immutable chainId;
    address immutable self;   

    string [] names; 
    mapping(string=>bool) knownName; 
    mapping(string=>address) addressByName; 
    mapping(address=>string) nameByAddress; 
    mapping(address=>uint256) versionByAddress;
    mapping(uint256=>DestinationConfig) destinationConfigByChainId;

    constructor(address _admin, uint256 _chainId)  {
        admin = _admin; 
        chainId = _chainId; 
        self = address(this);
        addAddressInternal(name, self, version);
        addAddressInternal(M_ADMIN_CA, _admin, 0);
    }

    function getName() pure external returns (string memory _name) {
        return name; 
    }

    function getVersion() pure external returns (uint256 _version) {
        return version; 
    }

    function getAddress(string memory _name) view external returns (address _address){
        return addressByName[_name];
    }

    function getName(address _address) view external returns (string memory _name){
        return nameByAddress[_address];
    }

    function getChainId() view external returns (uint256 _chainId) {
        return chainId; 
    }

    function getNames() view external returns (string [] memory _names) {
        return names; 
    }

    function getConfig() view external returns (RegistryEntry [] memory _entries) {
        _entries = new RegistryEntry[](names.length);
        for(uint256 x = 0; x < _entries.length; x++) {
            _entries[x] = RegistryEntry({
                                            name : names[x],
                                            vaddress : addressByName[names[x]],
                                            version : versionByAddress[addressByName[names[x]]]
                                        });
        }
        return _entries; 
    }

    function getDestinationConfig(uint256 _chainId) view external returns (DestinationConfig memory _dConfig){
        return destinationConfigByChainId[_chainId];
    }

    function addDestinationConfig(DestinationConfig memory _destinationConfig) external adminOnly returns (bool _added) {
        destinationConfigByChainId[_destinationConfig.chainId] = _destinationConfig; 
        return true; 
    }

    function addAddress(string memory _name, address _address, uint256 _version ) external adminOnly returns (bool _added) {
        return addAddressInternal(_name, _address, _version); 
    }

    function addMVersionAddress(address _address)  external adminOnly returns (bool _added) {
        IMVersion v_ = IMVersion(_address);
        addAddressInternal(v_.getName(), _address, v_.getVersion());
        return true; 
    }

    //======================================= INTERNAL =============================================================
    function addAddressInternal(string memory _name, address _address, uint256 _version) internal returns (bool _added) {
        if(!knownName[_name]){
            knownName[_name] = true; 
            names.push(_name);
        }
        addressByName[_name] = _address; 
        nameByAddress[_address] = _name; 
        versionByAddress[_address] = _version; 
        return true; 
    }


}