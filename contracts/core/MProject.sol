// SPDX-License-Identifier: APACHE 2.0
pragma solidity ^0.8.23;

import "../interfaces/IMRegister.sol";
import "../interfaces/IMProject.sol";
import "../interfaces/IMVersion.sol";

import {IAllo} from "https://github.com/allo-protocol/allo-v2/blob/main/contracts/core/interfaces/IAllo.sol";
import {IRegistry} from "https://github.com/allo-protocol/allo-v2/blob/main/contracts/core/interfaces/IRegistry.sol";

import {Project, Contributor, Deliverable, DeliverableStatus, PayoutStatus, PaymentDirective, PaymentDirectiveStatus} from "../interfaces/IMStructs.sol";

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MProject is IMProject, IMVersion { 

    modifier projectAdminOnly { 
        require(isProjectAdminInternal(msg.sender), " project admin only ");
        _;
    }

    modifier deliverableAssigneeOnly (uint256 _deliverableId) {
        require(contributorById[contributorIdByDeliverableId[_deliverableId]].wallet == msg.sender, " deliverable assignee only ");
        _;
    }

    modifier payoutStrategyOnly {
        require(msg.sender == register.getAddress(PAYOUT_STRATEGY_CA), "payout strategy only");
        _;
    }

    string constant name = "PROJECT"; 
    uint256 constant version = 3; 

    string constant ALLO_CA = "RESERVED_ALLO_CORE";
    string constant PAYOUT_STRATEGY_CA = "RESERVED_M_A_DELIVERY_STRATEGY";

    uint256 immutable id; 
    string projectName; 
    uint256 budget; 
    uint256 spent; 

    IMRegister register;
    uint256 alloPoolId; 
    bytes32 alloProfileId;
    address payoutErc20;  
    
    uint256 [] contributorIds; 
    address [] contributorAddresses; 
    uint256 [] paymentDirectiveIds; 

    mapping(address=>bool) isKnownContributorAddress; 
    mapping(uint256=>bool) isKnownContributor; 
    mapping(uint256=>Contributor) contributorById; 
    mapping(address=>uint256) contributorIdByAddress;
    mapping(uint256=>uint256[]) deliverableIdsByContributorId;
    mapping(uint256=>uint256) contributorIdByDeliverableId;  

    uint256 [] deliverableIds; 

    mapping(uint256=>bool) isKnownDeliverable; 
    mapping(uint256=>Deliverable) deliverableById; 
    mapping(uint256=>bool) isAssignedByDeliverableId; 
    mapping(DeliverableStatus=>uint256[]) deliverableIdsByStatus; 
    mapping(uint256=>uint256) paymentDirectiveIdByDeliverableId; 

    mapping(uint256=>uint256) outstandingContributorBalanceByContributorId; 

    mapping(uint256=>PaymentDirective) paymentDirectiveById; 

    constructor(address _register, uint256 _alloPoolId, bytes32 _alloProfileId, uint256 _projectId, string memory _projectName, uint256 _budget, address _payoutToken) {
        register        = IMRegister(_register);
        alloPoolId      = _alloPoolId; 
        alloProfileId   = _alloProfileId; 
        id              = _projectId; 
        projectName     = _projectName;
        budget          = _budget; 
        payoutErc20     = _payoutToken; 
    }

    function getName() pure external returns (string memory _name) {
        return name; 
    }

    function getVersion() pure external returns (uint256 _version) {
        return version; 
    }

    function getProjectDescriptor() view external returns (Project memory _project){
        return Project({
                            projectId : id,
                            name  : name, 
                            alloPoolId : alloPoolId, 
                            alloProfileId : alloProfileId,
                            payoutCurrency : payoutErc20,
                            budget : budget, 
                            spent : spent, 
                            deliverableIds : deliverableIds,  
                            contributors : contributorAddresses
                        }); 
    }

    function getDeliverableIds(uint256 _contributorId) view external returns (uint256[] memory _deliverableIds){
        return deliverableIdsByContributorId[_contributorId];
    }


    function getPaymentDirectives() view external returns (PaymentDirective [] memory _paymentDirectives) {
        _paymentDirectives = new PaymentDirective[](paymentDirectiveIds.length);
        for(uint256 x = 0; x < _paymentDirectives.length; x++ ){
            _paymentDirectives[x] = paymentDirectiveById[paymentDirectiveIds[x]];
        }
        return _paymentDirectives;
    }

    function getContributorIds() view external returns (uint256 [] memory _contributorIds) {
        return contributorIds; 
    }

    function isContributor(address _address) view external returns (bool _isKnownContributor) {
        return isKnownContributorAddress[_address];
    }

    function getContributorById(uint256 _contributorId ) view external returns (Contributor memory _contributor){
        return contributorById[_contributorId];
    }

    function getContributorByAddress(address _contributorWallet) view external returns (Contributor memory _contributor){
        return contributorById[contributorIdByAddress[_contributorWallet]];
    }

    function getDeliverableById(uint256 _deliverableId) view external returns (Deliverable memory _deliverable){
        return deliverableById[_deliverableId];
    }

    function getDeliverableIdsByStatus(DeliverableStatus _status) view external returns (uint256 [] memory _deliverableIds) {
        return deliverableIdsByStatus[_status];
    }

    function addContributor(Contributor memory _contributor) external returns (uint256 _contributorId) {
        uint256 contributorId_ = getIndex();
        contributorIds.push(contributorId_);
        contributorById[contributorId_] = Contributor({
                                                        id : contributorId_,
                                                        homeChain : _contributor.homeChain,
                                                        wallet : _contributor.wallet, 
                                                        metadata : _contributor.metadata
                                                    });
        contributorAddresses.push(_contributor.wallet);
        isKnownContributorAddress[_contributor.wallet] = true;
        return _contributorId; 
    }

    function addDeliverable(Deliverable memory _deliverable, uint256 _contributorId) external projectAdminOnly returns (uint256 deliverableCount){
        require(isKnownContributor[_contributorId], " unknown contributor ");
        uint256 deliverableId_ = getIndex(); 
        isKnownDeliverable[deliverableId_] = true;
        deliverableIds.push(deliverableId_);

        deliverableById[deliverableId_] = Deliverable({
                                                        id : deliverableId_,
                                                        projectId : id,  
                                                        payoutAmount : _deliverable.payoutAmount, 
                                                        name : _deliverable.name, 
                                                        metadata : _deliverable.metadata, 
                                                        deliverableStatus : _deliverable.deliverableStatus,
                                                        payoutStatus : _deliverable.payoutStatus 
                                                    });
        deliverableIdsByContributorId[_contributorId].push(deliverableId_);
        contributorIdByDeliverableId[deliverableId_] = _contributorId; 
        overwriteDeliverable(deliverableId_, _deliverable);

        checkSum();
        
        return deliverableIds.length;
    }

    function cancelPaymentDirective(uint256 _paymentDirectiveId) external projectAdminOnly returns (PaymentDirective memory _directive) {
        paymentDirectiveById[_paymentDirectiveId].status = PaymentDirectiveStatus.CANCELLED;
        return paymentDirectiveById[_paymentDirectiveId];
    }

    function submitDeliverable(uint256 _deliverableId) external deliverableAssigneeOnly(_deliverableId) returns (bool _submitted) {
        require(isKnownDeliverable[_deliverableId], " unkknown deliverable ");
        DeliverableStatus status_ = deliverableById[_deliverableId].deliverableStatus;
        require( status_ != DeliverableStatus.CANCELLED || status_ != DeliverableStatus.SUSPENDED 
                                                        || status_ != DeliverableStatus.DELIVERED, "Deliverable suspended or cancelled" );
        deliverableById[_deliverableId].deliverableStatus = DeliverableStatus.DELIVERED; 
        
        deliverableIdsByStatus[DeliverableStatus.DELIVERED].push(_deliverableId);

        deliverableById[_deliverableId].payoutStatus = PayoutStatus.PENDING; 
        uint256 paymentDirectiveId_ = getIndex(); 
        paymentDirectiveById[paymentDirectiveId_] = PaymentDirective({
                                                                        id : paymentDirectiveId_,
                                                                        contributor : contributorById[contributorIdByDeliverableId[_deliverableId]],
                                                                        projectId : id,
                                                                        alloProfileId : alloProfileId, 
                                                                        deliverableId : _deliverableId, 
                                                                        amount : deliverableById[_deliverableId].payoutAmount,
                                                                        erc20 : payoutErc20,
                                                                        status : PaymentDirectiveStatus.IN_FLIGHT
                                                                    });
                                                                    paymentDirectiveIdByDeliverableId[_deliverableId] = paymentDirectiveId_;
        paymentDirectiveIds.push(paymentDirectiveId_);

        return true; 
    }

    function updatePayoutStatus(uint256 _deliverableId, PayoutStatus _status) external payoutStrategyOnly returns (bool _updated) {
        require(isKnownDeliverable[_deliverableId], " unkknown deliverable ");
        deliverableById[_deliverableId].payoutStatus = _status;
        if(PayoutStatus.PAID == _status){
            spent += deliverableById[_deliverableId].payoutAmount; 
            paymentDirectiveById[paymentDirectiveIdByDeliverableId[_deliverableId]].status = PaymentDirectiveStatus.COMPLETED;
        }
        return true; 
    }

    function updateDeliverable(Deliverable memory _deliverable) external projectAdminOnly returns (bool _updated) {
        require(isKnownDeliverable[_deliverable.id], " unkknown deliverable ");
        require(deliverableById[_deliverable.id].payoutStatus != PayoutStatus.PAID, " deliverable already paid ");
        _updated = overwriteDeliverable(_deliverable.id, _deliverable);
        checkSum(); 
        return _updated; 
    }

    function reAssignDeliverable(uint256 _deliverableId, uint256 _newContributorId) external projectAdminOnly returns (bool _updated) {
        uint256 oldContributor_ = contributorIdByDeliverableId[_deliverableId];
        contributorIdByDeliverableId[_deliverableId] = _newContributorId;
        deliverableIdsByContributorId[_newContributorId].push(_deliverableId);
        
        uint256 [] memory dIds_ = deliverableIdsByContributorId[oldContributor_]; 
        if(dIds_.length > 1) {
            uint256 [] memory nDIds_ = new uint256[](dIds_.length);
            uint256 y = 0; 
            for(uint256 x = 0; x < dIds_.length; x++) {
                if(dIds_[x] != _deliverableId){
                    nDIds_[y] = dIds_[x];
                    y++;
                }
            }
            deliverableIdsByContributorId[oldContributor_] = nDIds_; 
        }
        else { 
            deliverableIdsByContributorId[oldContributor_] = new uint256[](0);
        }
        return true; 
    }

    function amendBudget(uint256 _newBudget) external projectAdminOnly returns (int256 _amendmentAmount) {
        _amendmentAmount = int256(_newBudget) - int256(budget);
        budget = _newBudget; 
        return _amendmentAmount; 
    }

    // ===================================== INTERNAL ===================================================================

    uint256 index; 

    function getIndex() internal returns (uint256 _index) {
        _index = index; 
        index++;
        return _index; 
    }

    function checkSum() view internal returns (uint256 _sum) {
        _sum = resum();
        require(budget >= _sum, " in sufficient budget ");

        IAllo allo_ = IAllo(register.getAddress(ALLO_CA));
        require(IERC20(allo_.getPool(alloPoolId).token).balanceOf(address(allo_)) >= _sum, " insufficient funds available in pool " );
        return _sum; 
    }

    function resum() view internal returns (uint256 _deliverableAmountSum) {
        for(uint256 x = 0; x < deliverableIds.length; x++){
            Deliverable memory deliverable_ = deliverableById[deliverableIds[x]];
            if(deliverable_.deliverableStatus != DeliverableStatus.CANCELLED && 
                deliverable_.payoutStatus != PayoutStatus.PAID  ){
               _deliverableAmountSum += deliverable_.payoutAmount;
            }
        }
        return _deliverableAmountSum; 
    }

    function overwriteDeliverable(uint256 _deliverableId, Deliverable memory _deliverable) internal returns (bool) {  
        deliverableById[_deliverableId] = Deliverable({
                                                        id : _deliverableId, 
                                                        projectId       : id,
                                                        payoutAmount    : _deliverable.payoutAmount, 
                                                        name            : _deliverable.name,
                                                        metadata        : _deliverable.metadata, 
                                                        deliverableStatus : _deliverable.deliverableStatus, 
                                                        payoutStatus    : _deliverable.payoutStatus
                                                    });
        return true; 
    }

    function isProjectAdminInternal(address _address) view internal returns (bool _isProjectAdmin) {
        IAllo allo = IAllo(register.getAddress(ALLO_CA));
        IRegistry alloRegistry = allo.getRegistry(); 
        if(allo.isPoolManager(alloPoolId, _address) 
            || allo.isPoolAdmin(alloPoolId, _address) 
            || alloRegistry.isOwnerOfProfile(alloProfileId, _address)){
            return true; 
        }
        return false; 
    }

}