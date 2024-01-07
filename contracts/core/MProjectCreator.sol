// SPDX-License-Identifier: APACHE 2.0
pragma solidity ^0.8.23;

import "../interfaces/IMVersion.sol";
import "../interfaces/IMRegister.sol";
import "../interfaces/IMProjectFactory.sol";

import {ProjectAllocation} from "../interfaces/IMStructs.sol";

import "https://github.com/allo-protocol/allo-v2/blob/main/contracts/core/interfaces/IRegistry.sol";
import "https://github.com/allo-protocol/allo-v2/blob/main/contracts/core/Allo.sol";

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract MProjectCreator is IMVersion {

    modifier adminOnly {
        require(msg.sender == register.getAddress(M_ADMIN_CA), " admin only ");
        _;
    }

    string constant name = "MARGARI_PROJECT_CREATOR";
    uint256 constant version  = 7; 
    
    string constant MARGARI_ALLO_STRATEGY_CA = "RESERVED_M_A_DELIVERY_STRATEGY";
    string constant ALLO_CA                  = "RESERVED_ALLO_CORE";
    string constant ALLO_PROFILE_REGISTER_CA = "RESERVED_ALLO_PROFILE_REGISTER";
    string constant PROJECT_FACTORY_CA       = "RESERVED_PROJECT_FACTORY";
    string constant M_ADMIN_CA = "RESERVED_M_ADMIN";


    address constant NATIVE = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;


    IMRegister register;
    IRegistry alloRegistry; 
    Allo allo;
    IMProjectFactory projectFactory; 

    address immutable self; 

    string [] orgNames; 
    mapping(string=>bool) knownOrgName; 
    mapping(string=>bool) hasProfileByOrgName; 
    mapping(string=>bytes32) profileIdByOrgName; 
    mapping(string=>uint256[]) poolIdsByOrgName; 
    mapping(string=>address[]) projectsByOrgName; 

    constructor(address _register) {
        register = IMRegister(_register);
        allo = IAllo(register.getAddress(ALLO_CA));
        alloRegistry = IRegistry(register.getAddress(ALLO_PROFILE_REGISTER_CA)); 
        projectFactory = IMProjectFactory(register.getAddress(PROJECT_FACTORY_CA));
        self = address(this);
    }

    function getOrgs() view external returns (string [] memory _orgs) {
        return orgNames; 
    }

    function getPoolIdsByOrgName(string memory _orgName) view external returns (uint256 [] memory _poolIds) {
        return poolIdsByOrgName[_orgName];
    }

    function getProfileId(string memory _orgName) view external returns (bytes32 _profileId) {
        return profileIdByOrgName[_orgName];
    }

    function getProjectsByOrgName(string memory _orgName) view external returns (address [] memory _projects) {
        return projectsByOrgName[_orgName];
    }

    function createFunderOrgProfile(string memory _orgName, string memory _metadataIpfsHash, address [] memory _adminAddresses) external returns (bytes32 _profileId){
        require(!knownOrgName[_orgName], "org already created");
        knownOrgName[_orgName] = true; 
        orgNames.push(_orgName);
        /*
        address [] memory withProjectCreator_ = new address[](_adminAddresses.length+1);
        withProjectCreator_[_adminAddresses.length] = self; // add project creator to profile admins
        for(uint x = 0; x < _adminAddresses.length;x++ ) {
            withProjectCreator_[x] = _adminAddresses[x];
        }*/
        //_profileId = alloRegistry.createProfile(getNonce(), _orgName, getMetadata(_metadataIpfsHash), msg.sender, withProjectCreator_); 
        _profileId = alloRegistry.createProfile(getNonce(), _orgName, getMetadata(_metadataIpfsHash), msg.sender, _adminAddresses); 

        profileIdByOrgName[_orgName] = _profileId; 
        return _profileId; 
    }

    function addExternalProfile(bytes32 _profileId, string memory _profileName)  external returns (bool _added) {
         require(!knownOrgName[_profileName], "org already created");
        knownOrgName[_profileName] = true;
        orgNames.push(_profileName);
        hasProfileByOrgName[_profileName] = true; 

        profileIdByOrgName[_profileName] = _profileId; 
        return true; 
    }

    function createFundingPool(string memory _orgName, address _token, uint256 _poolSize,  uint256 _initialFundingAmount, string memory _metadataIpfsHash, address [] memory _poolAdmins) external payable returns (uint256 _poolId){
        require(hasProfileByOrgName[_orgName], "unknown org");
        require(_poolSize >= _initialFundingAmount, " pool size must be greater or equal to amount ");

        if(_token == NATIVE) {
            require(msg.value>= _initialFundingAmount, "insufficient initial amount transmitted to fund pool");
        }
        else {
            IERC20(_token).transferFrom(msg.sender, self, _initialFundingAmount);
        }
        bytes32 profileId_ = profileIdByOrgName[_orgName];
        bytes memory zeroData_ = abi.encode("0");
        _poolId = allo.createPoolWithCustomStrategy(profileId_, register.getAddress(MARGARI_ALLO_STRATEGY_CA), zeroData_, _token, _poolSize, getMetadata(_metadataIpfsHash), _poolAdmins); 
        poolIdsByOrgName[_orgName].push(_poolId);
        if(_token == NATIVE) {
            allo.fundPool{value : _initialFundingAmount}(_poolId, _initialFundingAmount);
        }
        else {
            IERC20(_token).approve(address(allo), _initialFundingAmount);
            allo.fundPool(_poolId, _initialFundingAmount);
        }
        return _poolId; 
    }   

    function createProject(string memory _orgName, uint256 _alloPoolId, string memory _projectName, uint256 _budget)  external returns (address _project) {
        _project = projectFactory.createProject(profileIdByOrgName[_orgName], _alloPoolId, _projectName, _budget);
        bytes memory data_  = abi.encode(_project);
        allo.registerRecipient(_alloPoolId,  data_);
        ProjectAllocation memory allocation_ = ProjectAllocation({
             project : _project,  
            newAllocation : _budget 
        });
        bytes memory adata_ = abi.encode(allocation_);
        allo.allocate(_alloPoolId, adata_);

        return _project; 
    }

    function notifyChangeOfAddress() external adminOnly returns (bool _acknowledged) {
        allo = IAllo(register.getAddress(ALLO_CA));
        alloRegistry = IRegistry(register.getAddress(ALLO_PROFILE_REGISTER_CA)); 
        projectFactory = IMProjectFactory(register.getAddress(PROJECT_FACTORY_CA));
        return true; 
    }


    function getName() pure external returns (string memory _name) {
        return name;
    }

    function getVersion() pure external returns (uint256 _version) {
        return version; 
    }

    //====================================== INTENRAL ===============================================================

    function getMetadata(string memory _metadataIpfsHash) pure internal returns (Metadata memory _metadata) {
        return Metadata({
            protocol : 1, 
            pointer : _metadataIpfsHash
        });
    }

    function getNonce() view internal returns (uint256 _nonce) {
        return block.timestamp; 
    }

}