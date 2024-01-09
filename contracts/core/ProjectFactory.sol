// SPDX-License-Identifier: APACHE 2.0
pragma solidity ^0.8.23;

import "../interfaces/IMVersion.sol";
import "../interfaces/IMProjectFactory.sol";
import "../interfaces/IMRegister.sol";

import "./MProject.sol";

import {IAllo} from "https://github.com/allo-protocol/allo-v2/blob/main/contracts/core/interfaces/IAllo.sol";
import {IRegistry} from "https://github.com/allo-protocol/allo-v2/blob/main/contracts/core/interfaces/IRegistry.sol";

contract ProjectFactory is IMProjectFactory, IMVersion { 

    modifier poolManagerOrProfileOwnerOnly (bytes32 _alloProfileId, uint256 _alloPoolId) {
        require(isPoolManagerOrProfileOwnerOnly(_alloProfileId, _alloPoolId, msg.sender), "Profile Manager or Owner only");
        _;
    }

    modifier adminOnly { 
        require(msg.sender == register.getAddress(M_ADMIN_CA), "admin only");
        _;
    }

    string constant name = "RESERVED_PROJECT_FACTORY";
    uint256 constant version = 2; 

    string constant ALLO_CA = "RESERVED_ALLO_CORE";
    string constant M_ADMIN_CA = "RESERVED_M_ADMIN";

    IMRegister register;

    address [] projects; 
    mapping(address=>bool) isKnownProjectByAddress; 
    mapping(uint256=>mapping(string=>address)) projectByNameByPoolId; 

    constructor(address _registry){
        register = IMRegister(_registry);
    }

    function getName() pure external returns (string memory _name) {
        return name; 
    }

    function getVersion() pure external returns (uint256 _version) {
        return version; 
    }

    function isKnownProject(address _project) view external returns (bool _isKnown) {
        return isKnownProjectByAddress[_project];
    }

    function getProjects() view external adminOnly returns (address [] memory _projects) {
        return projects; 
    }

    function getProject(uint256 _poolId, string memory _name) view external returns (address _project) {
        return projectByNameByPoolId[_poolId][_name];
    }

    function createProject(bytes32 _alloProfileId, uint256 _alloPoolId, string memory _name, uint256 _budget) external poolManagerOrProfileOwnerOnly(_alloProfileId, _alloPoolId) returns (address _project) {
        
        _project = address(new MProject(address(register), _alloPoolId, _alloProfileId, getIndex(), _name, _budget, IAllo(register.getAddress(ALLO_CA)).getPool(_alloPoolId).token));
        projects.push(_project);
        projectByNameByPoolId[_alloPoolId][_name];
        isKnownProjectByAddress[_project] = true; 
        
        return _project; 
    }

    //==================================== INTERNAL =========================================================
    uint256 index;

    function getIndex() internal returns (uint256 _index) {
        _index = index++;
        return _index; 
    }

    function isPoolManagerOrProfileOwnerOnly( bytes32 _profileId, uint256 _poolId, address _address) view internal returns (bool _isProfileManagerOrOwnerOnly) {
        IAllo allo = IAllo(register.getAddress(ALLO_CA));
        IRegistry alloRegistry = allo.getRegistry(); 
        if(allo.isPoolManager(_poolId, _address) 
            || allo.isPoolAdmin(_poolId, _address) 
            || alloRegistry.isOwnerOrMemberOfProfile(_profileId, _address)){
            return true; 
        }
        return false; 
    }

}