// SPDX-License-Identifier: APACHE 2.0
pragma solidity ^0.8.23;

import "../interfaces/IMRegister.sol";
import "../interfaces/IGVaultFactory.sol";

import "./GVault.sol";

contract GVaultFactory is IGVaultFactory, IMVersion { 

    modifier giltContractOnly { 
        require(msg.sender == register.getAddress(GILT_CONTRACT_CA), "gilt contract only");
        _;
    }

    modifier adminOnly {
        require(msg.sender == register.getAddress(M_ADMIN_CA), "admin only");
        _;
    }

    string constant name = "RESERVED_G_VAULT_FACTORY";
    uint256 constant version = 1; 

    string constant GILT_CONTRACT_CA = "RESERVED_GILT_CONTRACT";
    string constant M_ADMIN_CA = "RESERVED_M_ADMIN";

    IMRegister register; 

    address [] vaults; 
    mapping(address=>bool) isKnownV;

    constructor(address _register) {
        register = IMRegister(_register);
    }

    function getName() pure external returns (string memory _name) {
        return name; 
    }

    function getVersion() pure external returns (uint256 _version) {
        return version; 
    }

    function getVaults() view external adminOnly returns (address [] memory _vaults) {
        return vaults; 
    }

    function isKnownVault(address _vault) view external returns (bool _isKnown) {
        return isKnownV[_vault];
    }

    function createVault(Gilt memory _gilt) external giltContractOnly returns (address _vault){
        address vault_ = address(new GVault(address(register), _gilt));
        vaults.push(vault_);
        isKnownV[vault_] = true; 
        return _vault; 
    }


}