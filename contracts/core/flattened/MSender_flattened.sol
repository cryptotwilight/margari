
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

// File: @chainlink/contracts-ccip/src/v0.8/ccip/interfaces/IRouterClient.sol


pragma solidity ^0.8.0;


interface IRouterClient {
  error UnsupportedDestinationChain(uint64 destChainSelector);
  error InsufficientFeeTokenAmount();
  error InvalidMsgValue();

  /// @notice Checks if the given chain ID is supported for sending/receiving.
  /// @param chainSelector The chain to check.
  /// @return supported is true if it is supported, false if not.
  function isChainSupported(uint64 chainSelector) external view returns (bool supported);

  /// @notice Gets a list of all supported tokens which can be sent or received
  /// to/from a given chain id.
  /// @param chainSelector The chainSelector.
  /// @return tokens The addresses of all tokens that are supported.
  function getSupportedTokens(uint64 chainSelector) external view returns (address[] memory tokens);

  /// @param destinationChainSelector The destination chainSelector
  /// @param message The cross-chain CCIP message including data and/or tokens
  /// @return fee returns execution fee for the message
  /// delivery to destination chain, denominated in the feeToken specified in the message.
  /// @dev Reverts with appropriate reason upon invalid message.
  function getFee(
    uint64 destinationChainSelector,
    Client.EVM2AnyMessage memory message
  ) external view returns (uint256 fee);

  /// @notice Request a message to be sent to the destination chain
  /// @param destinationChainSelector The destination chain ID
  /// @param message The cross-chain CCIP message including data and/or tokens
  /// @return messageId The message ID
  /// @dev Note if msg.value is larger than the required fee (from getFee) we accept
  /// the overpayment with no refund.
  /// @dev Reverts with appropriate reason upon invalid message.
  function ccipSend(
    uint64 destinationChainSelector,
    Client.EVM2AnyMessage calldata message
  ) external payable returns (bytes32);
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

// File: contracts/interfaces/IMVersion.sol


pragma solidity ^0.8.23;

interface IMVersion { 

    function getName() view external returns (string memory _name);

    function getVersion() view external returns (uint256 _version);
}
// File: https://github.com/allo-protocol/allo-v2/blob/main/contracts/core/libraries/Metadata.sol


pragma solidity >0.8.19;

// ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣗⠀⠀⠀⢸⣿⣿⣿⡯⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
// ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣗⠀⠀⠀⢸⣿⣿⣿⡯⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
// ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⣿⢿⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣗⠀⠀⠀⢸⣿⣿⣿⡯⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
// ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⣿⡟⠘⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣗⠀⠀⠀⢸⣿⣿⣿⡯⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
// ⠀⠀⠀⠀⠀⠀⠀⠀⣀⣴⣾⣿⣿⣿⣿⣾⠻⣿⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⡿⠀⠀⠸⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣗⠀⠀⠀⢸⣿⣿⣿⡯⠀⠀⠀⠀⠀⠀⢀⣠⣴⣴⣶⣶⣶⣦⣦⣀⡀⠀⠀⠀⠀⠀⠀
// ⠀⠀⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⡿⠃⠀⠙⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⠁⠀⠀⠀⢻⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣗⠀⠀⠀⢸⣿⣿⣿⡯⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⡀⠀⠀⠀⠀
// ⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⡿⠁⠀⠀⠀⠘⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⠃⠀⠀⠀⠀⠈⢿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣗⠀⠀⠀⢸⣿⣿⣿⡯⠀⠀⠀⣰⣿⣿⣿⡿⠋⠁⠀⠀⠈⠘⠹⣿⣿⣿⣿⣆⠀⠀⠀
// ⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⣿⠏⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⢸⣿⣿⣿⣗⠀⠀⠀⢸⣿⣿⣿⡯⠀⠀⢰⣿⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⡀⠀⠀
// ⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⣟⠀⡀⢀⠀⡀⢀⠀⡀⢈⢿⡟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⢸⣿⣿⣿⣗⠀⠀⠀⢸⣿⣿⣿⡯⠀⠀⢸⣿⣿⣿⣗⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⡇⠀⠀
// ⠀⠀⣠⣿⣿⣿⣿⣿⣿⡿⠋⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⣿⡿⢿⠿⠿⠿⠿⠿⠿⠿⠿⠿⢿⣿⣿⣿⣷⡀⠀⠀⠀⢸⣿⣿⣿⣗⠀⠀⠀⢸⣿⣿⣿⡯⠀⠀⠸⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⠂⠀⠀
// ⠀⠀⠙⠛⠿⠻⠻⠛⠉⠀⠀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣿⣿⣿⣧⠀⠀⠀⢸⣿⣿⣿⣗⠀⠀⠀⢸⣿⣿⣿⡯⠀⠀⠀⢻⣿⣿⣿⣷⣀⢀⠀⠀⠀⡀⣰⣾⣿⣿⣿⠏⠀⠀⠀
// ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣧⠀⠀⢸⣿⣿⣿⣗⠀⠀⠀⢸⣿⣿⣿⡯⠀⠀⠀⠀⠹⢿⣿⣿⣿⣿⣾⣾⣷⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀
// ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠙⠋⠛⠙⠋⠛⠙⠋⠛⠙⠋⠃⠀⠀⠀⠀⠀⠀⠀⠀⠠⠿⠻⠟⠿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⠟⠿⠟⠿⠆⠀⠸⠿⠿⠟⠯⠀⠀⠀⠸⠿⠿⠿⠏⠀⠀⠀⠀⠀⠈⠉⠻⠻⡿⣿⢿⡿⡿⠿⠛⠁⠀⠀⠀⠀⠀⠀
//                    allo.gitcoin.co

/// @title Metadata
/// @author @thelostone-mc <aditya@gitcoin.co>, @0xKurt <kurt@gitcoin.co>, @codenamejason <jason@gitcoin.co>, @0xZakk <zakk@gitcoin.co>, @nfrgosselin <nate@gitcoin.co>
/// @notice Metadata is used to define the metadata for the protocol that is used throughout the system.
struct Metadata {
    /// @notice Protocol ID corresponding to a specific protocol (currently using IPFS = 1)
    uint256 protocol;
    /// @notice Pointer (hash) to fetch metadata for the specified protocol
    string pointer;
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
    bytes32 alloProfileId;  
    address payoutCurrency; 
    uint256 budget;
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
// File: contracts/interfaces/IMSender.sol


pragma solidity ^0.8.23;


interface IMSender {

    function getTransmittedGilt(uint256 _sendId) view external returns (TransmittedGilt memory _gilt);

    function sendGilt(uint256 _destinationChainId, Gilt memory _gilt, address _owner, bytes32 _alloProfileId, uint256 _projectId) external returns (uint256 _sendId);

}
// File: contracts/interfaces/IMRegister.sol


pragma solidity ^0.8.23;



interface IMRegister {

    function getChainId() view external returns (uint256 _chainId);

    function getAddress(string memory _name) view external returns (address _address);

    function getName(address _address) view external returns (string memory _name);

    function getDestinationConfig(uint256 _chainId) view external returns (DestinationConfig memory _dConfig);

}
// File: contracts/core/MSender.sol


pragma solidity ^0.8.23;











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
    string constant ROUTER_CLIENT_CA = "RESERVED_CHAINLINK_ROUTER_CLIENT";
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

    function getTransmittedGilt(uint256 _sendId) view external returns (TransmittedGilt memory _gilt){
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