// SPDX-License-Identifier: APACHE 2.0
pragma solidity ^0.8.23;

import "../interfaces/IMRegister.sol";
import "../interfaces/IMargari.sol";
import "../interfaces/IMVersion.sol";
import "../interfaces/IMReciever.sol";
import "../interfaces/IMSender.sol";

import "../interfaces/IGiltContract.sol";

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Margari is IMargari, IMVersion { 

    string constant name = "RESERVED_MARGARI_CORE";
    uint256 constant version = 1; 

    string constant RECIEVER_CA = "RESERVED_M_RECIEVER";
    string constant SENDER_CA = "RESERVED_M_SENDER";
    string constant GILT_CONTRACT_CA = "GILT_CONTRACT_CA"; 
    
    address immutable self; 

    IMRegister register;

    constructor(address _register) { 
        register = IMRegister(_register);
        self = address(this);   
    }

    function getName() pure external returns (string memory _name) {
        return name; 
    }

    function getVersion() pure external returns (uint256 _version) {
        return version; 
    }

    // send a gilt to a destination chain 
    function sendGilt(Gilt memory _gilt, bytes32 _alloProfileId, uint256 _projectId, uint256 _destinationChainId) external returns (uint256 _sendId){
        return sendGiltInternal(_destinationChainId, _gilt, msg.sender, _alloProfileId, _projectId);
    }

    // this function sends from the given project Id to the funds to the given remote recipient on the given chain
    function sendFunds(uint256 _chainId, address _erc20, uint256 _amount, address _remoteRecipient, bytes32 _alloProfileId, uint256 _projectId) external payable returns (uint256 _sendId){
        // bond funds 
        IGiltContract giltContract = IGiltContract(register.getAddress(GILT_CONTRACT_CA));
        IERC20 erc20_ = IERC20(_erc20);
        erc20_.transferFrom(msg.sender, self, _amount);
        erc20_.approve(address(giltContract), _amount);
        Gilt memory gilt_ = giltContract.bondFunds(_erc20, _amount);
        // send gilt internal
        return sendGiltInternal(_chainId, gilt_, _remoteRecipient, _alloProfileId, _projectId);
    }

    // this function enables the recipient to claim their gilts 
    function claimGilts() external returns (GiltClaim [] memory _claims){
        IMReciever reciever = IMReciever(register.getAddress(RECIEVER_CA));
        _claims = reciever.claimGilts(msg.sender);
        return _claims; 
    }

    // ============================================= INTERNAL ==========================================

    function sendGiltInternal(uint256 _destinationChainId, Gilt memory gilt, address _owner, bytes32 _alloProjectId, uint256 _projectId ) internal returns (uint256 _sendId) {
        IMSender sender = IMSender(register.getAddress(SENDER_CA));
        return sender.sendGilt(_destinationChainId, gilt, _owner, _alloProjectId, _projectId );
    }
}