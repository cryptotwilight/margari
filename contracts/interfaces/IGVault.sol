// SPDX-License-Identifier: APACHE 2.0
pragma solidity ^0.8.23;

import {Gilt} from "./IMStructs.sol";

interface IGVault { 

    function getGilt() view external returns (Gilt memory _gilt);

    function getErc20() view external returns (address _erc20);

    function getAmountStored() view external returns (uint256 _amount);

    function storeFunds() external payable returns (bool _stored);

    function releaseFunds() external returns(bool _empty); 

    function isExpended() view external returns (bool _isExpended);
}