// SPDX-License-Identifier: APACHE 2.0
pragma solidity ^0.8.23;

import {Gilt, TransmittedGilt} from "./IMStructs.sol";

interface IMSender {

    function getTransmittedGilt(uint256 _sendId) view external returns (TransmittedGilt memory _gilt);

    function sendGilt(uint256 _destinationChainId, Gilt memory _gilt, address _owner, bytes32 _alloProfileId, uint256 _projectId) external returns (uint256 _sendId);

}