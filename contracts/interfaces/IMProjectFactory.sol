// SPDX-License-Identifier: APACHE 2.0
pragma solidity ^0.8.23;

interface IMProjectFactory {

    function getProject(uint256 _alloPoolId, string memory _name) view external returns (address _project);

    function createProject(bytes32 _alloProfileId, uint256 _alloPoolId, string memory _name, uint256 _budget) external returns (address _project);

}