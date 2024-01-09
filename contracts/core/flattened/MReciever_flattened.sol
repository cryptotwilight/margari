
// File: @chainlink/contracts-ccip/src/v0.8/vendor/openzeppelin-solidity/v4.8.0/contracts/utils/introspection/IERC165.sol


// OpenZeppelin Contracts v4.4.1 (utils/introspection/IERC165.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC165 standard, as defined in the
 * https://eips.ethereum.org/EIPS/eip-165[EIP].
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others ({ERC165Checker}).
 *
 * For an implementation, see {ERC165}.
 */
interface IERC165 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}
// File: @chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol


pragma solidity ^0.8.0;

// End consumer library.
library Client {
  /// @dev RMN depends on this struct, if changing, please notify the RMN maintainers.
  struct EVMTokenAmount {
    address token; // token address on the local chain.
    uint256 amount; // Amount of tokens.
  }

  struct Any2EVMMessage {
    bytes32 messageId; // MessageId corresponding to ccipSend on source.
    uint64 sourceChainSelector; // Source chain selector.
    bytes sender; // abi.decode(sender) if coming from an EVM chain.
    bytes data; // payload sent in original message.
    EVMTokenAmount[] destTokenAmounts; // Tokens and their amounts in their destination chain representation.
  }

  // If extraArgs is empty bytes, the default is 200k gas limit.
  struct EVM2AnyMessage {
    bytes receiver; // abi.encode(receiver address) for dest EVM chains
    bytes data; // Data payload
    EVMTokenAmount[] tokenAmounts; // Token transfers
    address feeToken; // Address of feeToken. address(0) means you will send msg.value.
    bytes extraArgs; // Populate this with _argsToBytes(EVMExtraArgsV1)
  }

  // bytes4(keccak256("CCIP EVMExtraArgsV1"));
  bytes4 public constant EVM_EXTRA_ARGS_V1_TAG = 0x97a657c9;
  struct EVMExtraArgsV1 {
    uint256 gasLimit;
  }

  function _argsToBytes(EVMExtraArgsV1 memory extraArgs) internal pure returns (bytes memory bts) {
    return abi.encodeWithSelector(EVM_EXTRA_ARGS_V1_TAG, extraArgs);
  }
}

// File: @chainlink/contracts-ccip/src/v0.8/ccip/interfaces/IAny2EVMMessageReceiver.sol


pragma solidity ^0.8.0;


/// @notice Application contracts that intend to receive messages from
/// the router should implement this interface.
interface IAny2EVMMessageReceiver {
  /// @notice Called by the Router to deliver a message.
  /// If this reverts, any token transfers also revert. The message
  /// will move to a FAILED state and become available for manual execution.
  /// @param message CCIP Message
  /// @dev Note ensure you check the msg.sender is the OffRampRouter
  function ccipReceive(Client.Any2EVMMessage calldata message) external;
}

// File: @chainlink/contracts-ccip/src/v0.8/ccip/applications/CCIPReceiver.sol


pragma solidity ^0.8.0;




/// @title CCIPReceiver - Base contract for CCIP applications that can receive messages.
abstract contract CCIPReceiver is IAny2EVMMessageReceiver, IERC165 {
  address internal immutable i_router;

  constructor(address router) {
    if (router == address(0)) revert InvalidRouter(address(0));
    i_router = router;
  }

  /// @notice IERC165 supports an interfaceId
  /// @param interfaceId The interfaceId to check
  /// @return true if the interfaceId is supported
  /// @dev Should indicate whether the contract implements IAny2EVMMessageReceiver
  /// e.g. return interfaceId == type(IAny2EVMMessageReceiver).interfaceId || interfaceId == type(IERC165).interfaceId
  /// This allows CCIP to check if ccipReceive is available before calling it.
  /// If this returns false or reverts, only tokens are transferred to the receiver.
  /// If this returns true, tokens are transferred and ccipReceive is called atomically.
  /// Additionally, if the receiver address does not have code associated with
  /// it at the time of execution (EXTCODESIZE returns 0), only tokens will be transferred.
  function supportsInterface(bytes4 interfaceId) public pure virtual override returns (bool) {
    return interfaceId == type(IAny2EVMMessageReceiver).interfaceId || interfaceId == type(IERC165).interfaceId;
  }

  /// @inheritdoc IAny2EVMMessageReceiver
  function ccipReceive(Client.Any2EVMMessage calldata message) external virtual override onlyRouter {
    _ccipReceive(message);
  }

  /// @notice Override this function in your implementation.
  /// @param message Any2EVMMessage
  function _ccipReceive(Client.Any2EVMMessage memory message) internal virtual;

  /////////////////////////////////////////////////////////////////////
  // Plumbing
  /////////////////////////////////////////////////////////////////////

  /// @notice Return the current router
  /// @return i_router address
  function getRouter() public view returns (address) {
    return address(i_router);
  }

  error InvalidRouter(address router);

  /// @dev only calls from the set router are accepted.
  modifier onlyRouter() {
    if (msg.sender != address(i_router)) revert InvalidRouter(msg.sender);
    _;
  }
}

// File: @openzeppelin/contracts/utils/introspection/IERC165.sol


// OpenZeppelin Contracts (last updated v5.0.0) (utils/introspection/IERC165.sol)

pragma solidity ^0.8.20;

/**
 * @dev Interface of the ERC165 standard, as defined in the
 * https://eips.ethereum.org/EIPS/eip-165[EIP].
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others ({ERC165Checker}).
 *
 * For an implementation, see {ERC165}.
 */
interface IERC165 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

// File: @openzeppelin/contracts/token/ERC721/IERC721.sol


// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC721/IERC721.sol)

pragma solidity ^0.8.20;


/**
 * @dev Required interface of an ERC721 compliant contract.
 */
interface IERC721 is IERC165 {
    /**
     * @dev Emitted when `tokenId` token is transferred from `from` to `to`.
     */
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    /**
     * @dev Emitted when `owner` enables `approved` to manage the `tokenId` token.
     */
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);

    /**
     * @dev Emitted when `owner` enables or disables (`approved`) `operator` to manage all of its assets.
     */
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    /**
     * @dev Returns the number of tokens in ``owner``'s account.
     */
    function balanceOf(address owner) external view returns (uint256 balance);

    /**
     * @dev Returns the owner of the `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function ownerOf(uint256 tokenId) external view returns (address owner);

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon
     *   a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external;

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`, checking first that contract recipients
     * are aware of the ERC721 protocol to prevent tokens from being forever locked.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If the caller is not `from`, it must have been allowed to move this token by either {approve} or
     *   {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon
     *   a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeTransferFrom(address from, address to, uint256 tokenId) external;

    /**
     * @dev Transfers `tokenId` token from `from` to `to`.
     *
     * WARNING: Note that the caller is responsible to confirm that the recipient is capable of receiving ERC721
     * or else they may be permanently lost. Usage of {safeTransferFrom} prevents loss, though the caller must
     * understand this adds an external call which potentially creates a reentrancy vulnerability.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must be owned by `from`.
     * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 tokenId) external;

    /**
     * @dev Gives permission to `to` to transfer `tokenId` token to another account.
     * The approval is cleared when the token is transferred.
     *
     * Only a single account can be approved at a time, so approving the zero address clears previous approvals.
     *
     * Requirements:
     *
     * - The caller must own the token or be an approved operator.
     * - `tokenId` must exist.
     *
     * Emits an {Approval} event.
     */
    function approve(address to, uint256 tokenId) external;

    /**
     * @dev Approve or remove `operator` as an operator for the caller.
     * Operators can call {transferFrom} or {safeTransferFrom} for any token owned by the caller.
     *
     * Requirements:
     *
     * - The `operator` cannot be the address zero.
     *
     * Emits an {ApprovalForAll} event.
     */
    function setApprovalForAll(address operator, bool approved) external;

    /**
     * @dev Returns the account approved for `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function getApproved(uint256 tokenId) external view returns (address operator);

    /**
     * @dev Returns if the `operator` is allowed to manage all of the assets of `owner`.
     *
     * See {setApprovalForAll}
     */
    function isApprovedForAll(address owner, address operator) external view returns (bool);
}

// File: contracts/interfaces/IMStructs.sol


pragma solidity ^0.8.23;

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

enum PaymentDirectiveStatus {IN_FLIGHT, COMPLETED, CANCELLED}

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
    string  metadata;
}

struct Project { 
    uint256 projectId; 
    string name; 
    uint256 alloPoolId;
    bytes32 alloProfileId;  
    address payoutCurrency; 
    uint256 budget;
    uint256 spent; 
    uint256 [] deliverableIds; 
    address [] contributors; 
}

struct ProjectAllocation {
    address project; 
    uint256 newAllocation; 
}

struct PaymentDirective {
    uint256 id; 
    Contributor contributor; 
    uint256 projectId; 
    bytes32 alloProfileId; 
    uint256 deliverableId; 
    uint256 amount; 
    address erc20;
    PaymentDirectiveStatus status; 
}

struct Deliverable {
    uint256 id; 
    uint256 projectId; 
    uint256 payoutAmount;
    string name; 
    string metadata;
    DeliverableStatus deliverableStatus;
    PayoutStatus payoutStatus; 
}

// File: contracts/interfaces/IGiltContract.sol


pragma solidity ^0.8.23;


interface IGiltContract { 

    function getGilt(uint256 _giltId) view external returns (Gilt memory _gilt);


    // only local gilts are bonded locally
    function isLocalBonded(uint256 _giltId) view external returns (bool _isLocalBonded);

    function bondFunds(address _erc20, uint256 _amount) external payable returns (Gilt memory _gilt);

    function unBondFunds(uint256 _giltId) external returns (address _erc20, uint256 _amount, address _to);
   
    // Transmitted Gilts are minted to the local Gilt Contract (they cannot be unbonded locally) 
    function mintLocalisedGilt(TransmittedGilt memory _tGilt, address _to) external returns (Gilt memory _gilt);

    function burnLocalisedGilt(Gilt memory _gilt) external returns (TransmittedGilt memory _tGilt);

    // Bonded Gilts are locked on the local chain in preparation for transit
    function isLocked(uint256 _giltId) view external returns (bool _isLocked);

    function lockGilt(uint256 _giltId) external returns (Gilt memory _gilt);

    function unlockGilt(uint256 _giltId) external returns (Gilt memory _gilt);

}
// File: contracts/interfaces/IMRegister.sol


pragma solidity ^0.8.23;



interface IMRegister {

    function getChainId() view external returns (uint256 _chainId);

    function getAddress(string memory _name) view external returns (address _address);

    function getName(address _address) view external returns (string memory _name);

    function getDestinationConfig(uint256 _chainId) view external returns (DestinationConfig memory _dConfig);

}
// File: contracts/interfaces/IMReciever.sol


pragma solidity ^0.8.23;


interface IMReciever {

    function claimGilts(address _claimant) external returns (GiltClaim [] memory giltClaims);

}
// File: contracts/interfaces/IMVersion.sol


pragma solidity ^0.8.23;

interface IMVersion { 

    function getName() view external returns (string memory _name);

    function getVersion() view external returns (uint256 _version);
}
// File: contracts/core/MReciever.sol


pragma solidity ^0.8.23;










contract MReciever is CCIPReceiver, IMReciever, IMVersion {

    

    event GILT_RECIEVED(address owner, uint256 amount, uint256 foreignId, uint256 srcChain);

    event GILT_CLAIMED(address owner, uint256 amount, bytes32 tGiltId, uint256 srcChain, uint256 localGiltId);

    modifier margariOnly {
        require(msg.sender == register.getAddress(MARGARI_CA), "margari only");
        _;
    }

    string constant name = "RESERVED_M_RECIEVER";
    uint256 constant version = 2; 

    string constant MARGARI_CA = "RESERVED_MARGARI_CORE";

    IMRegister register; 
    IERC721 gcIerc721; 
    IGiltContract giltContract; 

    bytes32 [] tGiltIds; 
    mapping(bytes32=>TransmittedGilt) tGiltById; 
    mapping(address=>bytes32[]) tGiltIdsByOwner; 
    mapping(address=>bytes32[]) claimedTGiltIdsByOwner; 
    mapping(bytes32=>bool) isClaimedByGiltId; 

    constructor(address _register, address _router) CCIPReceiver(_router) {
        register = IMRegister(_register);
    }

    function getName() pure external returns (string memory _name) {
        return name; 
    }

    function getVersion() pure external returns (uint256 _version) {
        return version; 
    }

    function _ccipReceive(Client.Any2EVMMessage memory _message) internal override {
        TransmittedGilt memory _tGilt = abi.decode(_message.data, (TransmittedGilt));
        bytes32 _localId = keccak256(_message.data);
        tGiltById[_localId] = _tGilt; 

        tGiltIdsByOwner[_tGilt.owner].push(_localId);
        tGiltIds.push(_localId);

        emit GILT_RECIEVED(_tGilt.owner, _tGilt.gilt.amount, _tGilt.gilt.id, _tGilt.gilt.chainId);
    }

    function getTGiltIds() view external returns (bytes32 [] memory _tGiltIds) {
        return tGiltIds; 
    }

    function getTransmittedGilt(bytes32 _tGiltId) view external returns (TransmittedGilt memory tGilt) {
        return tGiltById[_tGiltId];
    }

    function viewAvailableGiltClaims(address _claimant)  view external returns (Gilt [] memory _gilts) {
        bytes32 [] memory unclaimedGilts_ = tGiltIdsByOwner[_claimant];
        _gilts = new Gilt[](unclaimedGilts_.length);
        for(uint256 x = 0; x < unclaimedGilts_.length; x++) {   
            bytes32 tGiltId_ = unclaimedGilts_[x]; 
            TransmittedGilt memory tGilt_ = tGiltById[tGiltId_];
            _gilts[x] = tGilt_.gilt; 
        }
        return _gilts;
    }

    function claimGilts(address _claimant) external margariOnly returns (GiltClaim [] memory _giltClaims){
        bytes32 [] memory unclaimedGilts = tGiltIdsByOwner[_claimant];
        delete tGiltIdsByOwner[_claimant]; // clear claims

        _giltClaims = new GiltClaim[](unclaimedGilts.length);
        for(uint256 x = 0; x < unclaimedGilts.length; x++) {    
            bytes32 tGiltId_ = unclaimedGilts[x];
            TransmittedGilt memory tGilt_ = tGiltById[tGiltId_];
            
            Gilt memory localGilt_ = giltContract.mintLocalisedGilt(tGilt_, _claimant);
            
            claimedTGiltIdsByOwner[_claimant].push(tGiltId_);
            
            _giltClaims[x] = GiltClaim({
                                            projectId : tGilt_.projectId, 
                                            giltId : tGilt_.gilt.id, 
                                            chainId : tGilt_.gilt.chainId
                                        });
            emit GILT_CLAIMED(_claimant, tGilt_.gilt.amount, tGiltId_, tGilt_.gilt.chainId, localGilt_.id);
        }
        return _giltClaims; 
    }


    // ========================== INTERNAL =============================================================

    
}


