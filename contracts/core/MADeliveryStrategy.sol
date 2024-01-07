// SPDX-License-Identifier: APACHE 2.0
pragma solidity ^0.8.23;

import "../interfaces/IMVersion.sol";
import "../interfaces/IMRegister.sol";
import "../interfaces/IMargariAlloStrategy.sol";
import "../interfaces/IMStructs.sol";
import "../interfaces/IMProject.sol";
import "../interfaces/IMargari.sol";

import "./MBaseStrategy.sol";

// Interfaces
import {IAllo} from "https://github.com/allo-protocol/allo-v2/blob/main/contracts/core/interfaces/IAllo.sol";
import {IRegistry} from "https://github.com/allo-protocol/allo-v2/blob/main/contracts/core/interfaces/IRegistry.sol";

import {Metadata} from "https://github.com/allo-protocol/allo-v2/blob/main/contracts/core/libraries/Metadata.sol";

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MADeliveryStrategy is IMargariAlloStrategy, IMVersion, MBaseStrategy { 

    string constant name = "RESERVED_M_A_DELIVERY_STRATEGY";
    uint256 constant version = 3; 

    string constant ALLO_CA = "RESERVED_ALLO_CORE";
    string constant ALLO_PROFILE_REGISTER_CA = "RESERVED_ALLO_PROFILE_REGISTER";
    string constant MARGARI_CA = "RESERVED_MARGARI_CORE";

    address immutable self; 

    IMRegister register; 
    address [] projects;

    mapping(address=>uint256) allocationByProject;
    mapping(address=>uint256) remainingAllocationByProject;
    mapping(address=>uint256) totalPaidoutByProject; 
    mapping(address=>bool) isValidAllocatorByAddress; 
    mapping(uint256=>PaymentDirective) paymentDirectiveBySendId; 
    mapping(address=>uint256[]) sendIdsByRecipient; 
    mapping(address=>uint256) totalPaidByRecipient; 

    constructor(address _register, address _allo, string memory _name) MBaseStrategy(_allo, _name){
        register = IMRegister(_register);
        
        self = address(this);
    }

    function initialize(uint256 _poolId, bytes memory _data) external{
        poolId = _poolId; 
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
    function _isValidAllocator(address _allocator) internal pure override returns (bool){
        return true; 
    }

    function addAllocator(address _allocator ) external returns (bool _added) {
        isValidAllocatorByAddress[_allocator] = true; 
        return true; 
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
        address projectAddress_ = abi.decode(_data, (address)); 
        IMProject project_ = IMProject(projectAddress_);
        Project memory descriptor_ = project_.getProjectDescriptor(); 
        require(onlyAdmin(_sender, descriptor_.alloPoolId, descriptor_.alloProfileId), " org admin only ");
        projects.push(projectAddress_);
        return projectAddress_;
    }

    /// @notice This will allocate to a recipient.
    /// @dev The encoded '_data' will be determined by the strategy implementation.
    /// @param _data The data to use to allocate to the recipient
    /// @param _sender The address of the sender
    function _allocate(bytes memory _data, address _sender) internal override{
        
        ProjectAllocation memory allocation_ = abi.decode(_data, (ProjectAllocation));
        IMProject project_ = IMProject(allocation_.project);
        Project memory descriptor_ = project_.getProjectDescriptor();

        require(onlyAdmin(_sender, descriptor_.alloPoolId, descriptor_.alloProfileId), " org admin only ");
        allocationByProject[allocation_.project] = allocation_.newAllocation; 
        remainingAllocationByProject[allocation_.project] = allocationByProject[allocation_.project] - totalPaidoutByProject[allocation_.project];
    }

    /// @notice This will distribute funds (tokens) to recipients.
    /// @dev most strategies will track a TOTAL amount per recipient, and a PAID amount, and pay the difference
    /// this contract will need to track the amount paid already, so that it doesn't double pay.
    /// @param _recipientIds The ids of the recipients to distribute to
    /// @param _data Data required will depend on the strategy implementation
    /// @param _sender The address of the sender
    function _distribute(address[] memory _recipientIds, bytes memory _data, address _sender) internal override {
        
        for(uint256 x = 0; x < _recipientIds.length; x++){
            address projectAddress_ = _recipientIds[x];
            IMProject project_ = IMProject(projectAddress_); 
            Project memory descriptor_ = project_.getProjectDescriptor();
            require(onlyAdmin(_sender, descriptor_.alloPoolId, descriptor_.alloProfileId), "recipient <> sender mis-match");

            IERC20 erc20_ = IERC20(descriptor_.payoutCurrency);
            require(remainingAllocationByProject[_recipientIds[x]] >= descriptor_.budget, "budget <> remaining allocation mis-match");

            remainingAllocationByProject[_recipientIds[x]] -= descriptor_.budget;

            if(address(erc20_) == NATIVE){
                require(self.balance >= descriptor_.budget, "insufficient native token funds in pool ");
            }
            else {
                require(erc20_.balanceOf(self) >= descriptor_.budget, "insufficient funds in pool");
                erc20_.approve(register.getAddress(MARGARI_CA), descriptor_.budget);
            }

            PaymentDirective [] memory paymentDirectives_ = project_.getPaymentDirectives(); 
            (uint256 [] memory sendIds_, uint256 totalPaid_) = payoutDirectives(paymentDirectives_, projectAddress_);
            
            totalPaidByRecipient[projectAddress_] += totalPaid_;

        }
    }

    function payoutDirectives(PaymentDirective [] memory paymentDirectives_, address _projectAddress) internal returns (uint256 [] memory _sendIds, uint256 _totalPaid){
         IMargari margari = IMargari(register.getAddress(MARGARI_CA));
         IMProject project_ = IMProject(_projectAddress);

        _sendIds = new uint256[](paymentDirectives_.length);
        for(uint256 y = 0; y < paymentDirectives_.length; y++){
            PaymentDirective memory paymentDirective_ = paymentDirectives_[y];
            _totalPaid += paymentDirective_.amount; 
            if(paymentDirective_.contributor.homeChain != register.getChainId()){
                if(paymentDirective_.erc20 == NATIVE){
                    _sendIds[y] = margari.sendFunds{value : paymentDirective_.amount}(paymentDirective_.contributor.homeChain, paymentDirective_.erc20, paymentDirective_.amount ,paymentDirective_.contributor.wallet,paymentDirective_.alloProfileId,paymentDirective_.projectId );
                }
                else {
                    _sendIds[y] = margari.sendFunds(paymentDirective_.contributor.homeChain, paymentDirective_.erc20, paymentDirective_.amount ,paymentDirective_.contributor.wallet,paymentDirective_.alloProfileId,paymentDirective_.projectId );
                }
            }
            else {
                if(paymentDirective_.erc20 == NATIVE){
                    payable(paymentDirective_.contributor.wallet).transfer(paymentDirective_.amount);
                }
                else {
                    IERC20(paymentDirective_.erc20).transfer(paymentDirective_.contributor.wallet,paymentDirective_.amount );
                }
                _sendIds[y] = getIndex();
            } 
            project_.updatePayoutStatus(paymentDirective_.deliverableId, PayoutStatus.PAID);

            paymentDirectiveBySendId[_sendIds[y]] = paymentDirective_;
            sendIdsByRecipient[_projectAddress].push(_sendIds[y]);
        }
        return (_sendIds, _totalPaid); 
    }

    uint256 index = 1000; 

    function getIndex() internal returns (uint256 _index) {
        _index = index; 
        index++;
        return _index; 
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

            return PayoutSummary ({
                recipientAddress : _recipientId, 
                amount : totalPaidByRecipient[_recipientId]
            });

    }

    /// @notice This will get the status of a recipient.
    /// @param _recipientId The ID of the recipient
    /// @return The status of the recipient
    function _getRecipientStatus(address _recipientId) internal view override returns (Status){

    }

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