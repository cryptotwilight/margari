// SPDX-License-Identifier: APACHE 2.0
pragma solidity ^0.8.23;

import {DestinationConfig} from "./IMStructs.sol";


interface IMRegister {

    function getChainId() view external returns (uint256 _chainId);

    function getAddress(string memory _name) view external returns (address _address);

    function getName(address _address) view external returns (string memory _name);

    function getDestinationConfig(uint256 _chainId) view external returns (DestinationConfig memory _dConfig);

}