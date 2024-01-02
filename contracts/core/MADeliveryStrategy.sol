// SPDX-License-Identifier: APACHE 2.0
pragma solidity ^0.8.23;

import "../interfaces/IMRegistry.sol";
import "../interfaces/IMADeliveryStrategy.sol";

import {ReentrancyGuard} from "@openzeppelin/contracts/security/ReentrancyGuard.sol";

// Interfaces
import {IAllo} from "https://github.com/allo-protocol/allo-v2/blob/main/contracts/core/interfaces/IAllo.sol";
import {IRegistry} from "https://github.com/allo-protocol/allo-v2/blob/main/contracts/core/interfaces/IRegistry.sol";

// Core Contracts
import {BaseStrategy} from "https://github.com/allo-protocol/allo-v2/blob/main/contracts/strategies/BaseStrategy.sol";

import {Metadata} from "https://github.com/allo-protocol/allo-v2/blob/main/contracts/core/libraries/Metadata.sol";

contract MADeliveryStrategy is IMADeliveryStrategy, IMVersion, BaseStrategy, ReentrancyGuard { 

    string constant name = "RESERVED_M_A_DELIVERY_STRATEGY";
    uint256 constant version = 1; 

    string constant ALLO_PROFILE_REGISTER = "RESERVED_ALLO_PROFILE_REGISTER";

    IMRegister register; 
    address [] projects;
    mapping(address=>uint256) allocationByProject;
    mapping(address=>uint256) remainingAllocationByProject;
    mapping(address=>uint256) totalPaidoutByProject; 
    mapping(address=>bool) isValidAllocatorByAddress; 

    constructor(address _register, address _allo, string memory _name) BaseStrategy(_allo, _name){
        register = IMRegister(_register);
    }

    function getName() pure external returns (string memory _name) {
        return name; 
    }

    function getVersion() pure external returns (uint256 _version) {
        return version; 
    }

    function getProjects() view external returns (address [] memory _projects) {
        return projects; 
    }

     /// @notice Checks if the allocator is valid
    /// @param _allocator The allocator address
    /// @return 'true' if the allocator is valid, otherwise 'false'
    function _isValidAllocator(address _allocator) internal view override returns (bool){
        return true; 
    }

    function addAllocator(address _allocator ) external returns (bool _added) {
        isValidAllocatorByAddress[_allocator] = true; 
        return true; 
    }
    /// @notice Checks if the allocator is valid
    /// @param _allocator The allocator address
    /// @return 'true' if the allocator is valid, otherwise 'false'
    function _isValidAllocator(address _allocator) internal view override returns (bool){

    }

    /// @notice This will register a recipient, set their status (and any other strategy specific values), and
    ///         return the ID of the recipient.
    /// @dev Able to change status all the way up to Accepted, or to Pending and if there are more steps, additional
    ///      functions should be added to allow the owner to check this. The owner could also check attestations directly
    ///      and then Accept for instance.
    /// @param _data The data to use to register the recipient
    /// @param _sender The address of the sender
    /// @return The ID of the recipient
    function _registerRecipient(bytes memory _data, address _sender) internal override returns (address){
        require(onlyAdmin(_sender, project_.poolId, project_.alloProfileId), " org admin only ");
        address project_ = abi.decode(_data, (address)); 
        projects.push(project_);
        return project_;
    }

    /// @notice This will allocate to a recipient.
    /// @dev The encoded '_data' will be determined by the strategy implementation.
    /// @param _data The data to use to allocate to the recipient
    /// @param _sender The address of the sender
    function _allocate(bytes memory _data, address _sender) internal override{
        require(onlyAdmin(_sender), " org admin only ");
        ProjectAllocation allocation_ = abi.decode(_data, (ProjectAllocation));
        allocationByProject[allocation_.project] = allocation_.newAlloction; 
        remainingAllocationByProject[allocation_.project] = allocationByProject[allocation_.project] - totalPaidoutByProject[allocation_.project];
    }

    /// @notice This will distribute funds (tokens) to recipients.
    /// @dev most strategies will track a TOTAL amount per recipient, and a PAID amount, and pay the difference
    /// this contract will need to track the amount paid already, so that it doesn't double pay.
    /// @param _recipientIds The ids of the recipients to distribute to
    /// @param _data Data required will depend on the strategy implementation
    /// @param _sender The address of the sender
    function _distribute(address[] memory _recipientIds, bytes memory _data, address _sender) internal override {
        
        require(onlyAdmin(_sender), " org admin only ");
        for(uint256 x = 0; x < _recipientIds.length; x++){
            address projectAddress_ = _recipientIds[x];
            IMProject project_ = IMProject(projectAddress_); 
            PaymentDirective [] memory paymentDirectives_ = gproject_.getPaymentDirectives(); 
            payoutDirectives(paymentDirectives_);
        }
    }

    function payoutDirectives(PaymentDirective [] memory paymentDirectives_) internal {
        for(uint256 y = 0; y < paymentDirectives_.length; y++){
            PaymountDirective memory paymentDirective_ = paymentDirectives_[y];
            uint256 _chainId, address _erc20, uint256 _amount, address _remoteRecipient, bytes32 _alloProfileId, uint256 _projectId
            margari.sendFunds(paymentDirective_.contributor.homeChain, ,paymentDirective_.contributor.wallet,,paymentDirective_.projectId );

        }
    }

    /// @notice This will get the payout summary for a recipient.
    /// @dev The encoded '_data' will be determined by the strategy implementation.
    /// @param _recipientId The ID of the recipient
    /// @param _data The data to use to get the payout summary for the recipient
    /// @return The payout summary for the recipient
    function _getPayout(address _recipientId, bytes memory _data)
        internal
        view
        override
        returns (PayoutSummary memory){

    }

    /// @notice This will get the status of a recipient.
    /// @param _recipientId The ID of the recipient
    /// @return The status of the recipient
    function _getRecipientStatus(address _recipientId) internal view override returns (Status){

    }

    /// ===================================
    /// ============== Hooks ==============
    /// ===================================

    /// @notice Hook called before increasing the pool amount.
    /// @param _amount The amount to increase the pool by
    function _beforeIncreasePoolAmount(uint256 _amount) internal override {}

    /// @notice Hook called after increasing the pool amount.
    /// @param _amount The amount to increase the pool by
    function _afterIncreasePoolAmount(uint256 _amount) internal override {}

    /// @notice Hook called before registering a recipient.
    /// @param _data The data to use to register the recipient
    /// @param _sender The address of the sender
    function _beforeRegisterRecipient(bytes memory _data, address _sender) internal override {}

    /// @notice Hook called after registering a recipient.
    /// @param _data The data to use to register the recipient
    /// @param _sender The address of the sender
    function _afterRegisterRecipient(bytes memory _data, address _sender) internal override {}

    /// @notice Hook called before allocating to a recipient.
    /// @param _data The data to use to allocate to the recipient
    /// @param _sender The address of the sender
    function _beforeAllocate(bytes memory _data, address _sender) internal override {}

    /// @notice Hook called after allocating to a recipient.
    /// @param _data The data to use to allocate to the recipient
    /// @param _sender The address of the sender
    function _afterAllocate(bytes memory _data, address _sender) internal override {}

    /// @notice Hook called before distributing funds (tokens) to recipients.
    /// @param _recipientIds The IDs of the recipients
    /// @param _data The data to use to distribute to the recipients
    /// @param _sender The address of the sender
    function _beforeDistribute(address[] memory _recipientIds, bytes memory _data, address _sender) internal override {}

    /// @notice Hook called after distributing funds (tokens) to recipients.
    /// @param _recipientIds The IDs of the recipients
    /// @param _data The data to use to distribute to the recipients
    /// @param _sender The address of the sender
    function _afterDistribute(address[] memory _recipientIds, bytes memory _data, address _sender) internal override {}


    function onlyAdmin(address _sender, uint256 _poolId, bytes32 _alloProfileId) view internal returns (bool _isAdmin) {
        IAllo allo = IAllo(register.getAddress(ALLO_CA));
        IRegistry alloRegistry = allo.getRegistry(); 
        if(allo.isPoolManager(_poolId, _sender) 
            || allo.isPoolAdmin(_poolId, _sender) 
            || alloRegistry.isOwnerOfProfile(_alloProfileId, _sender)){
            return true; 
        }
        return false; 

    }

}