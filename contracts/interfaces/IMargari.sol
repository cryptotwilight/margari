// SPDX-License-Identifier: APACHE 2.0
pragma solidity ^0.8.23;

import {Gilt, GiltClaim} from "./IMStructs.sol";

interface IMargari {

    // send a gilt to a destination chain 
    function sendGilt(Gilt memory _gilt, bytes32 _alloProfileId, uint256 _projectId, uint256 _destinationChainId) external returns (uint256 _sendId);

    // this function sends from the given project Id to the funds to the given remote recipient on the given chain
    function sendFunds(uint256 _chainId, address _erc20, uint256 _amount, address _remoteRecipient, bytes32 _alloProfileId, uint256 _projectId) external payable returns (uint256 _sendId);

    // this function enables the recipient to claim their gilts 
    function claimGilts() external returns (GiltClaim [] memory _giltClaims);

}