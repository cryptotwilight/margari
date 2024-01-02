// SPDX-License-Identifier: APACHE 2.0
pragma solidity ^0.8.23;

import {Project, Contributor, Deliverable} from "../interfaces/IMStructs.sol";

interface IMProject { 

    function getProjectDescriptor() view external returns (Project memory _project);

    function getContributorById(uint256 _contributorId ) view external returns (Contributor memory _contributor);

    function getContributorByAddress(address _contributorWallet) view external returns (Contributor memory _contributor);

    function getDeliverableById(uint256 _deliverableId) view external returns (Deliverable memory _deliverable);

}