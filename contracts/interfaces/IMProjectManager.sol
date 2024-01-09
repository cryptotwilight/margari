// SPDX-License-Identifier: APACHE 2.0
pragma solidity ^0.8.23;

import  "https://github.com/allo-protocol/allo-v2/blob/main/contracts/core/interfaces/IAllo.sol";

interface IMProjectManager { 

    function getOrgs() view external returns (string [] memory _orgs) ;

    function getOrgName(bytes32 _profileId) view external returns (string memory _orgName);

    function getPoolIdsByOrgName(string memory _orgName) view external returns (uint256 [] memory _poolIds) ;

    function getProfileId(string memory _orgName) view external returns (bytes32 _profileId);

    function getProjectsByOrgName(string memory _orgName) view external returns (address [] memory _projects) ;

    function getPoolIds(string memory _orgName)  view external returns (uint256 [] memory _poolIds);

    function createFunderOrgProfile(string memory _orgName, string memory _metadataIpfsHash, address [] memory _adminAddresses) external returns (bytes32 _profileId);

    function importExternalProfile(bytes32 _profileId)  external returns (bool _added) ;

    function importExternalPool(bytes32 _profileId, uint256 _poolId) external returns (IAllo.Pool memory __pool);

    function createFundingPool(string memory _orgName, address _token, uint256 _poolSize,  uint256 _initialFundingAmount, string memory _metadataIpfsHash, address [] memory _poolAdmins) external payable returns (uint256 _poolId);

    function createProject(string memory _orgName, uint256 _alloPoolId, string memory _projectName, uint256 _budget)  external returns (address _project);


}