// SPDX-License-Identifier: APACHE 2.0
pragma solidity ^0.8.23;

import {Project, Contributor, Deliverable, PaymentDirective, PayoutStatus} from "../interfaces/IMStructs.sol";

interface IMProject { 

    function getProjectDescriptor() view external returns (Project memory _project);

    function getPaymentDirectives() view external returns (PaymentDirective [] memory _directives);

    function submitDeliverable(uint256 _deliverableId) external returns (bool _submitted);


    function getContributorIds() view external returns (uint256 [] memory _contributorIds);

    function getContributorById(uint256 _contributorId ) view external returns (Contributor memory _contributor);

    function getContributorByAddress(address _contributorWallet) view external returns (Contributor memory _contributor);

    function getDeliverableById(uint256 _deliverableId) view external returns (Deliverable memory _deliverable);

    function updatePayoutStatus(uint256 _deliverableId, PayoutStatus _status) external returns (bool _updated);

    function reAssignDeliverable(uint256 _deliverableId, uint256 _newContributorId) external  returns (bool _updated);

    function amendBudget(uint256 _newBudget) external returns (int256 _amendmentAmount);
}