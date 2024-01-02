// SPDX-License-Identifier: APACHE 2.0
pragma solidity ^0.8.23;

import "../interfaces/IMRegister.sol";
import "../interfaces/IMVersion.sol";
import "../interfaces/IMSender.sol";
import "../interfaces/IGiltContract.sol";

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

import {Gilt, SendStatement} from "../interfaces/IMStructs.sol";

import {IRouterClient} from "@chainlink/contracts-ccip/src/v0.8/ccip/interfaces/IRouterClient.sol";
import "@chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol";



contract MSender is IMSender, IMVersion {

    modifier margariOnly {
        require(msg.sender == register.getAddress(MARGARI_CA), "margari only");
        _;
    }

    modifier adminOnly { 
        require(msg.sender == register.getAddress(M_ADMIN_CA), " admin only ");
        _;
    }

    string constant name = "RESERVED_M_SENDER";
    uint256 constant version = 1;

    address constant NATIVE = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

    string constant REGISTER_CA = "RESERVED_M_REGISTER";
    string constant MARGARI_CA = "RESERVED_MARGARI_CORE";
    string constant ROUTER_CLIENT_CA = "CHAINLINK_ROUTER_CLIENT";
    string constant M_ADMIN_CA = "RESERVED_M_ADMIN";


    address immutable self; 

    IMRegister register; 
    IRouterClient router; 

    uint256 [] sendIds; 
    mapping(uint256=>TransmittedGilt) transmittedGiltBySendId; 
    mapping(uint256=>bytes32) ccipMessageIdBySendId; 
    mapping(uint256=>SendStatement) sendStatementBySendId; 

    constructor(address _register) {
        register = IMRegister(_register);
        router = IRouterClient(register.getAddress(ROUTER_CLIENT_CA));
        self = address(this);
    }

    function getName() pure external returns (string memory _name) {
        return name; 
    }

    function getVersion() pure external returns (uint256 _version) {
        return version; 
    }

    function getSendIds() view external adminOnly returns (uint256 [] memory _sendIds) {
        return sendIds; 
    }

    function getSendStatement(uint256 _sendId) view external returns (SendStatement memory _sendStatement) {
        return sendStatementBySendId[_sendId];
    }

    function getTransmittedGilt(uint256 _sendId) view external
         returns (TransmittedGilt memory _gilt){
        return transmittedGiltBySendId[_sendId];
    }

    function sendGilt(uint256 _destinationChainId, Gilt memory _gilt, address _owner, bytes32 _alloProfileId, uint256 _projectId) external returns (uint256 _sendId){
        _sendId = getIndex(); 
        sendIds.push(_sendId);
        IERC721 gErc721 = IERC721(_gilt.giltContract);
        gErc721.transferFrom(msg.sender, self, _gilt.id);
        
        IGiltContract giltContract_ = IGiltContract(_gilt.giltContract);
        if(!giltContract_.isLocalBonded(_gilt.id)){
            giltContract_.burnLocalisedGilt(_gilt); // burn if we brought in from elsewhere
        }
        else {
            giltContract_.lockGilt(_gilt.id); // lock if this local leaving
        }

        TransmittedGilt memory tGilt_ = TransmittedGilt({
                                                            gilt : _gilt, 
                                                            alloProfileId : _alloProfileId, 
                                                            projectId  : _projectId, 
                                                            owner : _owner
                                                        });

        DestinationConfig memory destinationConfig_ = register.getDestinationConfig(_destinationChainId);

        Client.EVM2AnyMessage memory evm2AnyMessage_ = Client.EVM2AnyMessage({
                                                                                receiver: abi.encode(destinationConfig_.giltReciever), // ABI-encoded receiver address
                                                                                data: abi.encode(tGilt_), // ABI-encoded string message
                                                                                tokenAmounts: new Client.EVMTokenAmount[](0), // Empty array indicating no tokens are being sent
                                                                                extraArgs: Client._argsToBytes(
                                                                                    Client.EVMExtraArgsV1({gasLimit: 400_000}) // Additional arguments, setting gas limit and non-strict sequency mode
                                                                                ),
                                                                                feeToken: address(0) // Setting feeToken to zero address, indicating native asset will be used for fees
                                                                            });

        // Get the fee required to send the message
        uint256 fees_ = router.getFee(destinationConfig_.ccipChainSelector, evm2AnyMessage_);

        // Send the message through the router and store the returned message ID
        bytes32 messageId_ = router.ccipSend{value: fees_}(destinationConfig_.ccipChainSelector, evm2AnyMessage_);

        ccipMessageIdBySendId[_sendId] = messageId_;

        sendStatementBySendId[_sendId] = SendStatement({
                                                            sendId : _sendId,
                                                            fees : fees_, 
                                                            token : NATIVE,  
                                                            sendDate : block.timestamp,
                                                            ccipMesssageId : messageId_
                                                        });
        sendIds.push(_sendId);
        // Return the message ID
        return _sendId;
    }


    function notifyChangeOfAddress() external returns (bool _acknowledged) {
        register = IMRegister(register.getAddress(REGISTER_CA));
        router = IRouterClient(register.getAddress(ROUTER_CLIENT_CA));
        return true; 
    }

    //========================================== INTERNAL ========================================================================

    uint256 index; 

    function getIndex() internal returns (uint256 _index){
        _index = index++;
        return _index; 
    }

}