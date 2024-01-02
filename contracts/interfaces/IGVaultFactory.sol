// SPDX-License-Identifier: APACHE 2.0
pragma solidity ^0.8.23;

import {Gilt} from "./IMStructs.sol";

interface IGVaultFactory { 

    function createVault(Gilt memory _gilt) external returns (address _vault);

}