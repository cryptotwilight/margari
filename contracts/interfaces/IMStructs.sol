// SPDX-License-Identifier: APACHE 2.0
pragma solidity ^0.8.23;

import {Metadata} from "https://github.com/allo-protocol/allo-v2/blob/main/contracts/core/libraries/Metadata.sol";

struct Gilt {
    address erc20; 
    uint256 amount; 
    uint256 creationDate; 
    uint256 chainId; 
    address giltContract; 
    uint256 id; 
}

struct TransmittedGilt { 
    Gilt gilt; 
    bytes32 alloProfileId;
    uint256 projectId;
    address owner; 
}

struct GiltClaim { 
    uint256 projectId; 
    uint256 giltId; 
    uint256 chainId; 
}

struct DestinationConfig {
    uint256 chainId; 
    uint64 ccipChainSelector; 
    address routerAddress; 
    address [] feeTokens; 
    address giltReciever; 
}

struct SendStatement { 
    uint256 sendId;
    uint256 fees; 
    address token; 
    uint256 sendDate;
    bytes32 ccipMesssageId;
}

enum DeliverableStatus {PROPOSED, AGREED, DELIVERED, SUSPENDED, CANCELLED}

enum PayoutStatus {AGREED, PENDING, PAID, SUSPENDED, CANCELLED}

struct ContributorAssignment { 
    address project; 
    Contributor contributor; 
    uint256 [] initialAssignments; 

}

// Internal Libraries
struct Contributor {
    uint256 id; 
    uint256 homeChain; 
    address wallet;
    Metadata metadata;
}

struct Project { 
    uint256 projectId; 
    string name; 
    uint256 alloPoolId; 
    address payoutCurrency; 
    uint256 [] deliverableIds; 
    address [] contributors; 
}

struct ProjectAllocation {
    address project; 
    uint256 newAllocation; 
}

struct PayoutDirective{
    uint256 id; 
    Contributor contributor; 
    uint256 projectId; 
    uint256 deliverableId; 
    uint256 amount; 
}

struct Deliverable {
    uint256 id; 
    uint256 projectId; 
    uint256 payoutAmount;
    string name; 
    Metadata metadata;
    DeliverableStatus deliverableStatus;
    PayoutStatus payoutStatus; 
}
