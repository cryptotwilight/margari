// SPDX-License-Identifier: APACHE 2.0
pragma solidity ^0.8.23;

import {Gilt, GiltClaim} from "./IMStructs.sol";

interface IMReciever {

    function claimGilts(address _claimant) external returns (GiltClaim [] memory giltClaims);

}