
// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.20;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Returns the value of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the value of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves a `value` amount of tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 value) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets a `value` amount of tokens as the allowance of `spender` over the
     * caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 value) external returns (bool);

    /**
     * @dev Moves a `value` amount of tokens from `from` to `to` using the
     * allowance mechanism. `value` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 value) external returns (bool);
}

pragma solidity ^0.8.19;

// Interfaces

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

/// @title IStrategy Interface
/// @author @thelostone-mc <aditya@gitcoin.co>, @0xKurt <kurt@gitcoin.co>, @codenamejason <jason@gitcoin.co>, @0xZakk <zakk@gitcoin.co>, @nfrgosselin <nate@gitcoin.co> @0xZakk <zakk@gitcoin.co>, @nfrgosselin <nate@gitcoin.co>
/// @notice BaseStrategy is the base contract that all strategies should inherit from and uses this interface.

interface IStrategy {
    /// ======================
    /// ======= Storage ======
    /// ======================

    /// @notice The Status enum that all recipients are based from
    enum Status {
        None,
        Pending,
        Accepted,
        Rejected,
        Appealed,
        InReview,
        Canceled
    }

    /// @notice Payout summary struct to hold the payout data
    struct PayoutSummary {
        address recipientAddress;
        uint256 amount;
    }

    /// ======================
    /// ======= Events =======
    /// ======================

    /// @notice Emitted when strategy is initialized.
    /// @param poolId The ID of the pool
    /// @param data The data passed to the 'initialize' function
    event Initialized(uint256 poolId, bytes data);

    /// @notice Emitted when a recipient is registered.
    /// @param recipientId The ID of the recipient
    /// @param data The data passed to the 'registerRecipient' function
    /// @param sender The sender
    event Registered(address indexed recipientId, bytes data, address sender);

    /// @notice Emitted when a recipient is allocated to.
    /// @param recipientId The ID of the recipient
    /// @param amount The amount allocated
    /// @param token The token allocated
    event Allocated(address indexed recipientId, uint256 amount, address token, address sender);

    /// @notice Emitted when tokens are distributed.
    /// @param recipientId The ID of the recipient
    /// @param recipientAddress The recipient
    /// @param amount The amount distributed
    /// @param sender The sender
    event Distributed(address indexed recipientId, address recipientAddress, uint256 amount, address sender);

    /// @notice Emitted when pool is set to active status.
    /// @param active The status of the pool
    event PoolActive(bool active);

    /// ======================
    /// ======= Views ========
    /// ======================

    /// @notice Getter for the address of the Allo contract.
    /// @return The 'Allo' contract
    function getAllo() external view returns (IAllo);

    /// @notice Getter for the 'poolId' for this strategy.
    /// @return The ID of the pool
    function getPoolId() external view returns (uint256);

    /// @notice Getter for the 'id' of the strategy.
    /// @return The ID of the strategy
    function getStrategyId() external view returns (bytes32);

    /// @notice Checks whether a allocator is valid or not, will usually be true for all strategies
    ///      and will depend on the strategy implementation.
    /// @param _allocator The allocator to check
    /// @return Whether the allocator is valid or not
    function isValidAllocator(address _allocator) external view returns (bool);

    /// @notice whether pool is active.
    /// @return Whether the pool is active or not
    function isPoolActive() external returns (bool);

    /// @notice Checks the amount of tokens in the pool.
    /// @return The balance of the pool
    function getPoolAmount() external view returns (uint256);

    /// @notice Increases the balance of the pool.
    /// @param _amount The amount to increase the pool by
    function increasePoolAmount(uint256 _amount) external;

    /// @notice Checks the status of a recipient probably tracked in a mapping, but will depend on the implementation
    ///      for example, the OpenSelfRegistration only maps users to bool, and then assumes Accepted for those
    ///      since there is no need for Pending or Rejected.
    /// @param _recipientId The ID of the recipient
    /// @return The status of the recipient
    function getRecipientStatus(address _recipientId) external view returns (Status);

    /// @notice Checks the amount allocated to a recipient for distribution.
    /// @dev Input the values you would send to distribute(), get the amounts each recipient in the array would receive.
    ///      The encoded '_data' will be determined by the strategy, and will be used to determine the payout.
    /// @param _recipientIds The IDs of the recipients
    /// @param _data The encoded data
    function getPayouts(address[] memory _recipientIds, bytes[] memory _data)
        external
        view
        returns (PayoutSummary[] memory);

    /// ======================
    /// ===== Functions ======
    /// ======================

    /// @notice
    /// @dev The default BaseStrategy version will not use the data  if a strategy wants to use it, they will overwrite it,
    ///      use it, and then call super.initialize().
    /// @param _poolId The ID of the pool
    /// @param _data The encoded data
    function initialize(uint256 _poolId, bytes memory _data) external;

    /// @notice This will register a recipient, set their status (and any other strategy specific values), and
    ///         return the ID of the recipient.
    /// @dev Able to change status all the way up to 'Accepted', or to 'Pending' and if there are more steps, additional
    ///      functions should be added to allow the owner to check this. The owner could also check attestations directly
    ///      and then accept for instance. The '_data' will be determined by the strategy implementation.
    /// @param _data The data to use to register the recipient
    /// @param _sender The address of the sender
    /// @return The ID of the recipient
    function registerRecipient(bytes memory _data, address _sender) external payable returns (address);

    /// @notice This will allocate to a recipient.
    /// @dev The encoded '_data' will be determined by the strategy implementation.
    /// @param _data The data to use to allocate to the recipient
    /// @param _sender The address of the sender
    function allocate(bytes memory _data, address _sender) external payable;

    /// @notice This will distribute funds (tokens) to recipients.
    /// @dev most strategies will track a TOTAL amount per recipient, and a PAID amount, and pay the difference
    /// this contract will need to track the amount paid already, so that it doesn't double pay.
    function distribute(address[] memory _recipientIds, bytes memory _data, address _sender) external;
}

pragma solidity ^0.8.19;

// Internal Libraries
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

/// @title IRegistry Interface
/// @author @thelostone-mc <aditya@gitcoin.co>, @0xKurt <kurt@gitcoin.co>, @codenamejason <jason@gitcoin.co>, @0xZakk <zakk@gitcoin.co>, @nfrgosselin <nate@gitcoin.co>
/// @notice Interface for the Registry contract and exposes all functions needed to use the Registry
///         within the Allo protocol.
/// @dev The Registry Interface is used to interact with the Allo protocol and create profiles
///      that can be used to interact with the Allo protocol. The Registry is the main contract
///      that all other contracts interact with to get the 'Profile' information needed to
///      interact with the Allo protocol. The Registry is also used to create new profiles
///      and update existing profiles. The Registry is also used to add and remove members
///      from a profile. The Registry will not always be used in a strategy and will depend on
///      the strategy being used.
interface IRegistry {
    /// ======================
    /// ======= Structs ======
    /// ======================

    /// @dev The Profile struct that all profiles are based from
    struct Profile {
        bytes32 id;
        uint256 nonce;
        string name;
        Metadata metadata;
        address owner;
        address anchor;
    }

    /// ======================
    /// ======= Events =======
    /// ======================

    /// @dev Emitted when a profile is created. This will return your anchor address.
    event ProfileCreated(
        bytes32 indexed profileId, uint256 nonce, string name, Metadata metadata, address owner, address anchor
    );

    /// @dev Emitted when a profile name is updated. This will update the anchor when the name is updated and return it.
    event ProfileNameUpdated(bytes32 indexed profileId, string name, address anchor);

    /// @dev Emitted when a profile's metadata is updated.
    event ProfileMetadataUpdated(bytes32 indexed profileId, Metadata metadata);

    /// @dev Emitted when a profile owner is updated.
    event ProfileOwnerUpdated(bytes32 indexed profileId, address owner);

    /// @dev Emitted when a profile pending owner is updated.
    event ProfilePendingOwnerUpdated(bytes32 indexed profileId, address pendingOwner);

    /// =========================
    /// ==== View Functions =====
    /// =========================

    /// @dev Returns the 'Profile' for a '_profileId' passed
    /// @param _profileId The 'profileId' to return the 'Profile' for
    /// @return profile The 'Profile' for the '_profileId' passed
    function getProfileById(bytes32 _profileId) external view returns (Profile memory profile);

    /// @dev Returns the 'Profile' for an '_anchor' passed
    /// @param _anchor The 'anchor' to return the 'Profile' for
    /// @return profile The 'Profile' for the '_anchor' passed
    function getProfileByAnchor(address _anchor) external view returns (Profile memory profile);

    /// @dev Returns a boolean if the '_account' is a member or owner of the '_profileId' passed in
    /// @param _profileId The 'profileId' to check if the '_account' is a member or owner of
    /// @param _account The 'account' to check if they are a member or owner of the '_profileId' passed in
    /// @return isOwnerOrMemberOfProfile A boolean if the '_account' is a member or owner of the '_profileId' passed in
    function isOwnerOrMemberOfProfile(bytes32 _profileId, address _account)
        external
        view
        returns (bool isOwnerOrMemberOfProfile);

    /// @dev Returns a boolean if the '_account' is an owner of the '_profileId' passed in
    /// @param _profileId The 'profileId' to check if the '_account' is an owner of
    /// @param _owner The 'owner' to check if they are an owner of the '_profileId' passed in
    /// @return isOwnerOfProfile A boolean if the '_account' is an owner of the '_profileId' passed in
    function isOwnerOfProfile(bytes32 _profileId, address _owner) external view returns (bool isOwnerOfProfile);

    /// @dev Returns a boolean if the '_account' is a member of the '_profileId' passed in
    /// @param _profileId The 'profileId' to check if the '_account' is a member of
    /// @param _member The 'member' to check if they are a member of the '_profileId' passed in
    /// @return isMemberOfProfile A boolean if the '_account' is a member of the '_profileId' passed in
    function isMemberOfProfile(bytes32 _profileId, address _member) external view returns (bool isMemberOfProfile);

    /// ====================================
    /// ==== External/Public Functions =====
    /// ====================================

    /// @dev Creates a new 'Profile' and returns the 'profileId' of the new profile
    ///
    /// Note: The 'name' and 'nonce' are used to generate the 'anchor' address
    ///
    /// Requirements: None, anyone can create a new profile
    ///
    /// @param _nonce The nonce to use to generate the 'anchor' address
    /// @param _name The name to use to generate the 'anchor' address
    /// @param _metadata The 'Metadata' to use to generate the 'anchor' address
    /// @param _owner The 'owner' to use to generate the 'anchor' address
    /// @param _members The 'members' to use to generate the 'anchor' address
    /// @return profileId The 'profileId' of the new profile
    function createProfile(
        uint256 _nonce,
        string memory _name,
        Metadata memory _metadata,
        address _owner,
        address[] memory _members
    ) external returns (bytes32 profileId);

    /// @dev Updates the 'name' of the '_profileId' passed in and returns the new 'anchor' address
    ///
    /// Requirements: Only the 'Profile' owner can update the name
    ///
    /// Note: The 'name' and 'nonce' are used to generate the 'anchor' address and this will update the 'anchor'
    ///       so please use caution. You can always recreate your 'anchor' address by updating the name back
    ///       to the original name used to create the profile.
    ///
    /// @param _profileId The 'profileId' to update the name for
    /// @param _name The new 'name' value
    /// @return anchor The new 'anchor' address
    function updateProfileName(bytes32 _profileId, string memory _name) external returns (address anchor);

    /// @dev Updates the 'Metadata' of the '_profileId' passed in
    ///
    /// Requirements: Only the 'Profile' owner can update the metadata
    ///
    /// @param _profileId The 'profileId' to update the metadata for
    /// @param _metadata The new 'Metadata' value
    function updateProfileMetadata(bytes32 _profileId, Metadata memory _metadata) external;

    /// @dev Updates the pending 'owner' of the '_profileId' passed in
    ///
    /// Requirements: Only the 'Profile' owner can update the pending owner
    ///
    /// @param _profileId The 'profileId' to update the pending owner for
    /// @param _pendingOwner The new pending 'owner' value
    function updateProfilePendingOwner(bytes32 _profileId, address _pendingOwner) external;

    /// @dev Accepts the pending 'owner' of the '_profileId' passed in
    ///
    /// Requirements: Only the pending owner can accept the ownership
    ///
    /// @param _profileId The 'profileId' to accept the ownership for
    function acceptProfileOwnership(bytes32 _profileId) external;

    /// @dev Adds members to the '_profileId' passed in
    ///
    /// Requirements: Only the 'Profile' owner can add members
    ///
    /// @param _profileId The 'profileId' to add members to
    /// @param _members The members to add to the '_profileId' passed in
    function addMembers(bytes32 _profileId, address[] memory _members) external;

    /// @dev Removes members from the '_profileId' passed in
    ///
    /// Requirements: Only the 'Profile' owner can remove members
    ///
    /// @param _profileId The 'profileId' to remove members from
    /// @param _members The members to remove from the '_profileId' passed in
    function removeMembers(bytes32 _profileId, address[] memory _members) external;

    /// @dev Recovers funds from the contract
    ///
    /// Requirements: Must be the Allo owner
    ///
    /// @param _token The token you want to use to recover funds
    /// @param _recipient The recipient of the recovered funds
    function recoverFunds(address _token, address _recipient) external;
}

pragma solidity ^0.8.19;

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
pragma solidity ^0.8.19;

// Interfaces
// Internal Libraries

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

/// @title Allo Interface
/// @author @thelostone-mc <aditya@gitcoin.co>, @0xKurt <kurt@gitcoin.co>, @codenamejason <jason@gitcoin.co>, @0xZakk <zakk@gitcoin.co>, @nfrgosselin <nate@gitcoin.co>
/// @notice Interface for the Allo contract. It exposes all functions needed to use the Allo protocol.
interface IAllo {
    /// ======================
    /// ======= Structs ======
    /// ======================

    /// @notice the Pool struct that all strategy pools are based from
    struct Pool {
        bytes32 profileId;
        IStrategy strategy;
        address token;
        Metadata metadata;
        bytes32 managerRole;
        bytes32 adminRole;
    }

    /// ======================
    /// ======= Events =======
    /// ======================

    /// @notice Event emitted when a new pool is created
    /// @param poolId ID of the pool created
    /// @param profileId ID of the profile the pool is associated with
    /// @param strategy Address of the strategy contract
    /// @param token Address of the token pool was funded with when created
    /// @param amount Amount pool was funded with when created
    /// @param metadata Pool metadata
    event PoolCreated(
        uint256 indexed poolId,
        bytes32 indexed profileId,
        IStrategy strategy,
        address token,
        uint256 amount,
        Metadata metadata
    );

    /// @notice Emitted when a pools metadata is updated
    /// @param poolId ID of the pool updated
    /// @param metadata Pool metadata that was updated
    event PoolMetadataUpdated(uint256 indexed poolId, Metadata metadata);

    /// @notice Emitted when a pool is funded
    /// @param poolId ID of the pool funded
    /// @param amount Amount funded to the pool
    /// @param fee Amount of the fee paid to the treasury
    event PoolFunded(uint256 indexed poolId, uint256 amount, uint256 fee);

    /// @notice Emitted when the base fee is paid
    /// @param poolId ID of the pool the base fee was paid for
    /// @param amount Amount of the base fee paid
    event BaseFeePaid(uint256 indexed poolId, uint256 amount);

    /// @notice Emitted when the treasury address is updated
    /// @param treasury Address of the new treasury
    event TreasuryUpdated(address treasury);

    /// @notice Emitted when the percent fee is updated
    /// @param percentFee New percentage for the fee
    event PercentFeeUpdated(uint256 percentFee);

    /// @notice Emitted when the base fee is updated
    /// @param baseFee New base fee amount
    event BaseFeeUpdated(uint256 baseFee);

    /// @notice Emitted when the registry address is updated
    /// @param registry Address of the new registry
    event RegistryUpdated(address registry);

    /// @notice Emitted when a strategy is approved and added to the cloneable strategies
    /// @param strategy Address of the strategy approved
    event StrategyApproved(address strategy);

    /// @notice Emitted when a strategy is removed from the cloneable strategies
    /// @param strategy Address of the strategy removed
    event StrategyRemoved(address strategy);

    /// ====================================
    /// ==== External/Public Functions =====
    /// ====================================

    /// @notice Initialize the Allo contract
    /// @param _owner Address of the owner
    /// @param _registry Address of the registry contract
    /// @param _treasury Address of the treasury
    /// @param _percentFee Percentage for the fee
    /// @param _baseFee Base fee amount
    function initialize(
        address _owner,
        address _registry,
        address payable _treasury,
        uint256 _percentFee,
        uint256 _baseFee
    ) external;

    /// @notice Creates a new pool (with a custom strategy)
    /// @dev 'msg.sender' must be a member or owner of a profile to create a pool with or without a custom strategy, The encoded data
    ///      will be specific to a given strategy requirements, reference the strategy implementation of 'initialize()'. The strategy
    ///      address passed must not be a cloneable strategy. The strategy address passed must not be the zero address. 'msg.sender' must
    ///      be a member or owner of the profile id passed as '_profileId'.
    /// @param _profileId The 'profileId' of the registry profile, used to check if 'msg.sender' is a member or owner of the profile
    /// @param _strategy The address of the deployed custom strategy
    /// @param _initStrategyData The data to initialize the strategy
    /// @param _token The address of the token you want to use in your pool
    /// @param _amount The amount of the token you want to deposit into the pool on initialization
    /// @param _metadata The 'Metadata' of the pool, this uses our 'Meatdata.sol' struct (consistent throughout the protocol)
    /// @param _managers The managers of the pool, and can be added/removed later by the pool admin
    /// @return poolId The ID of the pool
    function createPoolWithCustomStrategy(
        bytes32 _profileId,
        address _strategy,
        bytes memory _initStrategyData,
        address _token,
        uint256 _amount,
        Metadata memory _metadata,
        address[] memory _managers
    ) external payable returns (uint256 poolId);

    /// @notice Creates a new pool (by cloning a cloneable strategies).
    /// @dev 'msg.sender' must be owner or member of the profile id passed as '_profileId'.
    /// @param _profileId The ID of the registry profile, used to check if 'msg.sender' is a member or owner of the profile
    /// @param _strategy The address of the strategy contract the pool will use.
    /// @param _initStrategyData The data to initialize the strategy
    /// @param _token The address of the token
    /// @param _amount The amount of the token
    /// @param _metadata The metadata of the pool
    /// @param _managers The managers of the pool
    /// @custom:initstrategydata The encoded data will be specific to a given strategy requirements,
    ///    reference the strategy implementation of 'initialize()'
    function createPool(
        bytes32 _profileId,
        address _strategy,
        bytes memory _initStrategyData,
        address _token,
        uint256 _amount,
        Metadata memory _metadata,
        address[] memory _managers
    ) external payable returns (uint256 poolId);

    /// @notice Updates a pools metadata.
    /// @dev 'msg.sender' must be a pool admin.
    /// @param _poolId The ID of the pool to update
    /// @param _metadata The new metadata to set
    function updatePoolMetadata(uint256 _poolId, Metadata memory _metadata) external;

    /// @notice Update the registry address.
    /// @dev 'msg.sender' must be the Allo contract owner.
    /// @param _registry The new registry address
    function updateRegistry(address _registry) external;

    /// @notice Updates the treasury address.
    /// @dev 'msg.sender' must be the Allo contract owner.
    /// @param _treasury The new treasury address
    function updateTreasury(address payable _treasury) external;

    /// @notice Updates the percentage for the fee.
    /// @dev 'msg.sender' must be the Allo contract owner.
    /// @param _percentFee The new percentage for the fee
    function updatePercentFee(uint256 _percentFee) external;

    /// @notice Updates the base fee.
    /// @dev 'msg.sender' must be the Allo contract owner.
    /// @param _baseFee The new base fee
    function updateBaseFee(uint256 _baseFee) external;

    /// @notice Adds a strategy to the cloneable strategies.
    /// @dev 'msg.sender' must be the Allo contract owner.
    /// @param _strategy The address of the strategy to add
    function addToCloneableStrategies(address _strategy) external;

    /// @notice Removes a strategy from the cloneable strategies.
    /// @dev 'msg.sender' must be the Allo contract owner.
    /// @param _strategy The address of the strategy to remove
    function removeFromCloneableStrategies(address _strategy) external;

    /// @notice Adds a pool manager to the pool.
    /// @dev 'msg.sender' must be a pool admin.
    /// @param _poolId The ID of the pool to add the manager to
    /// @param _manager The address of the manager to add
    function addPoolManager(uint256 _poolId, address _manager) external;

    /// @notice Removes a pool manager from the pool.
    /// @dev 'msg.sender' must be a pool admin.
    /// @param _poolId The ID of the pool to remove the manager from
    /// @param _manager The address of the manager to remove
    function removePoolManager(uint256 _poolId, address _manager) external;

    /// @notice Recovers funds from a pool.
    /// @dev 'msg.sender' must be a pool admin.
    /// @param _token The token to recover
    /// @param _recipient The address to send the recovered funds to
    function recoverFunds(address _token, address _recipient) external;

    /// @notice Registers a recipient and emits {Registered} event if successful and may be handled differently by each strategy.
    /// @param _poolId The ID of the pool to register the recipient for
    function registerRecipient(uint256 _poolId, bytes memory _data) external payable returns (address);

    /// @notice Registers a batch of recipients.
    /// @param _poolIds The pool ID's to register the recipients for
    /// @param _data The data to pass to the strategy and may be handled differently by each strategy
    function batchRegisterRecipient(uint256[] memory _poolIds, bytes[] memory _data)
        external
        returns (address[] memory);

    /// @notice Funds a pool.
    /// @dev 'msg.value' must be greater than 0 if the token is the native token
    ///       or '_amount' must be greater than 0 if the token is not the native token.
    /// @param _poolId The ID of the pool to fund
    /// @param _amount The amount to fund the pool with
    function fundPool(uint256 _poolId, uint256 _amount) external payable;

    /// @notice Allocates funds to a recipient.
    /// @dev Each strategy will handle the allocation of funds differently.
    /// @param _poolId The ID of the pool to allocate funds from
    /// @param _data The data to pass to the strategy and may be handled differently by each strategy.
    function allocate(uint256 _poolId, bytes memory _data) external payable;

    /// @notice Allocates funds to multiple recipients.
    /// @dev Each strategy will handle the allocation of funds differently
    function batchAllocate(uint256[] calldata _poolIds, bytes[] memory _datas) external;

    /// @notice Distributes funds to recipients and emits {Distributed} event if successful
    /// @dev Each strategy will handle the distribution of funds differently
    /// @param _poolId The ID of the pool to distribute from
    /// @param _recipientIds The recipient ids to distribute to
    /// @param _data The data to pass to the strategy and may be handled differently by each strategy
    function distribute(uint256 _poolId, address[] memory _recipientIds, bytes memory _data) external;

    /// =========================
    /// ==== View Functions =====
    /// =========================

    /// @notice Checks if an address is a pool admin.
    /// @param _poolId The ID of the pool to check
    /// @param _address The address to check
    /// @return 'true' if the '_address' is a pool admin, otherwise 'false'
    function isPoolAdmin(uint256 _poolId, address _address) external view returns (bool);

    /// @notice Checks if an address is a pool manager.
    /// @param _poolId The ID of the pool to check
    /// @param _address The address to check
    /// @return 'true' if the '_address' is a pool manager, otherwise 'false'
    function isPoolManager(uint256 _poolId, address _address) external view returns (bool);

    /// @notice Checks if a strategy is cloneable (is in the cloneableStrategies mapping).
    /// @param _strategy The address of the strategy to check
    /// @return 'true' if the '_strategy' is cloneable, otherwise 'false'
    function isCloneableStrategy(address _strategy) external view returns (bool);

    /// @notice Returns the address of the strategy for a given 'poolId'
    /// @param _poolId The ID of the pool to check
    /// @return strategy The address of the strategy for the ID of the pool passed in
    function getStrategy(uint256 _poolId) external view returns (address);

    /// @notice Returns the current percent fee
    /// @return percentFee The current percentage for the fee
    function getPercentFee() external view returns (uint256);

    /// @notice Returns the current base fee
    /// @return baseFee The current base fee
    function getBaseFee() external view returns (uint256);

    /// @notice Returns the current treasury address
    /// @return treasury The current treasury address
    function getTreasury() external view returns (address payable);

    /// @notice Returns the current registry address
    /// @return registry The current registry address
    function getRegistry() external view returns (IRegistry);

    /// @notice Returns the 'Pool' struct for a given 'poolId'
    /// @param _poolId The ID of the pool to check
    /// @return pool The 'Pool' struct for the ID of the pool passed in
    function getPool(uint256 _poolId) external view returns (Pool memory);

    /// @notice Returns the current fee denominator
    /// @dev 1e18 represents 100%
    /// @return feeDenominator The current fee denominator
    function getFeeDenominator() external view returns (uint256);
}

pragma solidity ^0.8.23;

interface IMVersion { 

    function getName() view external returns (string memory _name);

    function getVersion() view external returns (uint256 _version);
}

pragma solidity ^0.8.23;


interface IMRegister {

    function getChainId() view external returns (uint256 _chainId);

    function getAddress(string memory _name) view external returns (address _address);

    function getName(address _address) view external returns (string memory _name);

    function getDestinationConfig(uint256 _chainId) view external returns (DestinationConfig memory _dConfig);

}

pragma solidity ^0.8.23;


interface IMargariAlloStrategy { 


}

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

pragma solidity ^0.8.23;


interface IMProject { 

    function getProjectDescriptor() view external returns (Project memory _project);

    function getPaymentDirectives() view external returns (PaymentDirective [] memory _directives);
    
    function getDeliverableById(uint256 _deliverableId) view external returns (Deliverable memory _deliverable);

    function getDeliverableIds(uint256 _contributorId) view external returns (uint256[] memory _deliverableIds);

    function submitDeliverable(uint256 _deliverableId) external returns (bool _submitted);


    function getContributorIds() view external returns (uint256 [] memory _contributorIds);

    function getContributorById(uint256 _contributorId ) view external returns (Contributor memory _contributor);

    function getContributorByAddress(address _contributorWallet) view external returns (Contributor memory _contributor);

    function isContributor(address _address) view external returns (bool _isKnownContributor);


    function updatePayoutStatus(uint256 _deliverableId, PayoutStatus _status) external returns (bool _updated);

    function addDeliverable(Deliverable memory _deliverable, uint256 _contributorId) external returns (uint256 deliverableCount);


    function reAssignDeliverable(uint256 _deliverableId, uint256 _newContributorId) external  returns (bool _updated);

    function cancelPaymentDirective(uint256 _paymentDirectiveId) external returns (PaymentDirective memory _directive);

    function amendBudget(uint256 _newBudget) external returns (int256 _amendmentAmount);
}

pragma solidity ^0.8.23;

interface IMargari {

    // send a gilt to a destination chain 
    function sendGilt(Gilt memory _gilt, bytes32 _alloProfileId, uint256 _projectId, uint256 _destinationChainId) external returns (uint256 _sendId);

    // this function sends from the given project Id to the funds to the given remote recipient on the given chain
    function sendFunds(uint256 _chainId, address _erc20, uint256 _amount, address _remoteRecipient, bytes32 _alloProfileId, uint256 _projectId) external payable returns (uint256 _sendId);

    // this function enables the recipient to claim their gilts 
    function claimGilts() external returns (GiltClaim [] memory _giltClaims);

}

pragma solidity ^0.8.23;

// Interfaces


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

/// @title BaseStrategy Contract
/// @author @thelostone-mc <aditya@gitcoin.co>, @0xKurt <kurt@gitcoin.co>, @codenamejason <jason@gitcoin.co>, @0xZakk <zakk@gitcoin.co>, @nfrgosselin <nate@gitcoin.co>
/// @notice This contract is the base contract for all strategies
/// @dev This contract is implemented by all strategies.
abstract contract MBaseStrategy is IStrategy {
    /// ==========================
    /// === Storage Variables ====
    /// ==========================
    address constant NATIVE = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

    IAllo internal immutable allo;
    bytes32 internal immutable strategyId;
    bool internal poolActive;
    uint256 internal poolId;
    uint256 internal poolAmount;

    /// ====================================
    /// ========== Constructor =============
    /// ====================================

    /// @notice Constructor to set the Allo contract and "strategyId'.
    /// @param _allo Address of the Allo contract.
    /// @param _name Name of the strategy
    constructor(address _allo, string memory _name) {
        allo = IAllo(_allo);
        strategyId = keccak256(abi.encode(_name));
    }

    /// ====================================
    /// =========== Modifiers ==============
    /// ====================================

    /// @notice Modifier to check if the 'msg.sender' is the Allo contract.
    /// @dev Reverts if the 'msg.sender' is not the Allo contract.
    modifier onlyAllo() {
        _checkOnlyAllo();
        _;
    }

    /// @notice Modifier to check if the '_sender' is a pool manager.
    /// @dev Reverts if the '_sender' is not a pool manager.
    /// @param _sender The address to check if they are a pool manager
    modifier onlyPoolManager(address _sender) {
        _checkOnlyPoolManager(_sender);
        _;
    }

    /// @notice Modifier to check if the pool is active.
    /// @dev Reverts if the pool is not active.
    modifier onlyActivePool() {
        _checkOnlyActivePool();
        _;
    }

    /// @notice Modifier to check if the pool is inactive.
    /// @dev Reverts if the pool is active.
    modifier onlyInactivePool() {
        _checkInactivePool();
        _;
    }

    /// @notice Modifier to check if the pool is initialized.
    /// @dev Reverts if the pool is not initialized.
    modifier onlyInitialized() {
        _checkOnlyInitialized();
        _;
    }

    /// ================================
    /// =========== Views ==============
    /// ================================

    /// @notice Getter for the 'Allo' contract.
    /// @return The Allo contract
    function getAllo() external view override returns (IAllo) {
        return allo;
    }

    /// @notice Getter for the 'poolId'.
    /// @return The ID of the pool
    function getPoolId() external view override returns (uint256) {
        return poolId;
    }

    /// @notice Getter for the 'strategyId'.
    /// @return The ID of the strategy
    function getStrategyId() external view override returns (bytes32) {
        return strategyId;
    }

    /// @notice Getter for the 'poolAmount'.
    /// @return The balance of the pool
    function getPoolAmount() external view virtual override returns (uint256) {
        return poolAmount;
    }

    /// @notice Getter for whether or not the pool is active.
    /// @return 'true' if the pool is active, otherwise 'false'
    function isPoolActive() external view override returns (bool) {
        return _isPoolActive();
    }

    /// @notice Getter for the status of a recipient.
    /// @param _recipientId The ID of the recipient
    /// @return The status of the recipient
    function getRecipientStatus(address _recipientId) external view virtual returns (Status) {
        return _getRecipientStatus(_recipientId);
    }

    /// ====================================
    /// =========== Functions ==============
    /// ====================================

    /// @notice Initializes the 'Basetrategy'.
    /// @dev Will revert if the poolId is invalid or already initialized
    /// @param _poolId ID of the pool
    function __BaseStrategy_init(uint256 _poolId) internal virtual onlyAllo {
        // check if pool ID is not initialized already, if it is, revert
        if (poolId != 0) revert("ALREADY INITIALIZED"); 

        // check if pool ID is valid and not zero (0), if it is, revert
        if (_poolId == 0) revert("INVALID");
        poolId = _poolId;
    }

    /// @notice Increases the pool amount.
    /// @dev Increases the 'poolAmount' by '_amount'. Only 'Allo' contract can call this.
    /// @param _amount The amount to increase the pool by
    function increasePoolAmount(uint256 _amount) external override onlyAllo {
        _beforeIncreasePoolAmount(_amount);
        poolAmount += _amount;
        _afterIncreasePoolAmount(_amount);
    }

    /// @notice Registers a recipient.
    /// @dev Registers a recipient and returns the ID of the recipient. The encoded '_data' will be determined by the
    ///      strategy implementation. Only 'Allo' contract can call this when it is initialized.
    /// @param _data The data to use to register the recipient
    /// @param _sender The address of the sender
    /// @return recipientId The recipientId
    function registerRecipient(bytes memory _data, address _sender)
        external
        payable
        onlyAllo
        onlyInitialized
        returns (address recipientId)
    {
        _beforeRegisterRecipient(_data, _sender);
        recipientId = _registerRecipient(_data, _sender);
        _afterRegisterRecipient(_data, _sender);
    }

    /// @notice Allocates to a recipient.
    /// @dev The encoded '_data' will be determined by the strategy implementation. Only 'Allo' contract can
    ///      call this when it is initialized.
    /// @param _data The data to use to allocate to the recipient
    /// @param _sender The address of the sender
    function allocate(bytes memory _data, address _sender) external payable onlyAllo onlyInitialized {
        _beforeAllocate(_data, _sender);
        _allocate(_data, _sender);
        _afterAllocate(_data, _sender);
    }

    /// @notice Distributes funds (tokens) to recipients.
    /// @dev The encoded '_data' will be determined by the strategy implementation. Only 'Allo' contract can
    ///      call this when it is initialized.
    /// @param _recipientIds The IDs of the recipients
    /// @param _data The data to use to distribute to the recipients
    /// @param _sender The address of the sender
    function distribute(address[] memory _recipientIds, bytes memory _data, address _sender)
        external
        onlyAllo
        onlyInitialized
    {
        _beforeDistribute(_recipientIds, _data, _sender);
        _distribute(_recipientIds, _data, _sender);
        _afterDistribute(_recipientIds, _data, _sender);
    }

    /// @notice Gets the payout summary for recipients.
    /// @dev The encoded '_data' will be determined by the strategy implementation.
    /// @param _recipientIds The IDs of the recipients
    /// @param _data The data to use to get the payout summary for the recipients
    /// @return The payout summary for the recipients
    function getPayouts(address[] memory _recipientIds, bytes[] memory _data)
        external
        view
        virtual
        override
        returns (PayoutSummary[] memory)
    {
        uint256 recipientLength = _recipientIds.length;
        // check if the length of the recipient IDs and data arrays are equal, if they are not, revert
        if (recipientLength != _data.length) revert("ARRAY MISMATCH");

        PayoutSummary[] memory payouts = new PayoutSummary[](recipientLength);
        for (uint256 i; i < recipientLength;) {
            payouts[i] = _getPayout(_recipientIds[i], _data[i]);
            unchecked {
                i++;
            }
        }
        return payouts;
    }

    /// @notice Checks if the '_allocator' is a valid allocator.
    /// @dev How the allocator is determined is up to the strategy implementation.
    /// @param _allocator The address to check if it is a valid allocator for the strategy.
    /// @return 'true' if the address is a valid allocator, 'false' otherwise
    function isValidAllocator(address _allocator) external view virtual override returns (bool) {
        return _isValidAllocator(_allocator);
    }

    /// ====================================
    /// ============ Internal ==============
    /// ====================================

    /// @notice Checks if the 'msg.sender' is the Allo contract.
    /// @dev Reverts if the 'msg.sender' is not the Allo contract.
    function _checkOnlyAllo() internal view {
        if (msg.sender != address(allo)) revert("UNAUTHORIZED");
    }

    /// @notice Checks if the '_sender' is a pool manager.
    /// @dev Reverts if the '_sender' is not a pool manager.
    /// @param _sender The address to check if they are a pool manager
    function _checkOnlyPoolManager(address _sender) internal view {
        if (!allo.isPoolManager(poolId, _sender)) revert("UNAUTHORIZED");
    }

    /// @notice Checks if the pool is active.
    /// @dev Reverts if the pool is not active.
    function _checkOnlyActivePool() internal view {
        if (!poolActive) revert("POOL INACTIVE");
    }

    /// @notice Checks if the pool is inactive.
    /// @dev Reverts if the pool is active.
    function _checkInactivePool() internal view {
        if (poolActive) revert("POOL INACTIVE");
    }

    /// @notice Checks if the pool is initialized.
    /// @dev Reverts if the pool is not initialized.
    function _checkOnlyInitialized() internal view {
        if (poolId == 0) revert("NOT_INITIALIZED"); 
    }

    /// @notice Set the pool to active or inactive status.
    /// @dev This will emit a 'PoolActive()' event. Used by the strategy implementation.
    /// @param _active The status to set, 'true' means active, 'false' means inactive
    function _setPoolActive(bool _active) internal {
        poolActive = _active;
        emit PoolActive(_active);
    }

    /// @notice Checks if the pool is active.
    /// @dev Used by the strategy implementation.
    /// @return 'true' if the pool is active, otherwise 'false'
    function _isPoolActive() internal view virtual returns (bool) {
        return poolActive;
    }

    /// @notice Checks if the allocator is valid
    /// @param _allocator The allocator address
    /// @return 'true' if the allocator is valid, otherwise 'false'
    function _isValidAllocator(address _allocator) internal view virtual returns (bool);

    /// @notice This will register a recipient, set their status (and any other strategy specific values), and
    ///         return the ID of the recipient.
    /// @dev Able to change status all the way up to Accepted, or to Pending and if there are more steps, additional
    ///      functions should be added to allow the owner to check this. The owner could also check attestations directly
    ///      and then Accept for instance.
    /// @param _data The data to use to register the recipient
    /// @param _sender The address of the sender
    /// @return The ID of the recipient
    function _registerRecipient(bytes memory _data, address _sender) internal virtual returns (address);

    /// @notice This will allocate to a recipient.
    /// @dev The encoded '_data' will be determined by the strategy implementation.
    /// @param _data The data to use to allocate to the recipient
    /// @param _sender The address of the sender
    function _allocate(bytes memory _data, address _sender) internal virtual;

    /// @notice This will distribute funds (tokens) to recipients.
    /// @dev most strategies will track a TOTAL amount per recipient, and a PAID amount, and pay the difference
    /// this contract will need to track the amount paid already, so that it doesn't double pay.
    /// @param _recipientIds The ids of the recipients to distribute to
    /// @param _data Data required will depend on the strategy implementation
    /// @param _sender The address of the sender
    function _distribute(address[] memory _recipientIds, bytes memory _data, address _sender) internal virtual;

    /// @notice This will get the payout summary for a recipient.
    /// @dev The encoded '_data' will be determined by the strategy implementation.
    /// @param _recipientId The ID of the recipient
    /// @param _data The data to use to get the payout summary for the recipient
    /// @return The payout summary for the recipient
    function _getPayout(address _recipientId, bytes memory _data)
        internal
        view
        virtual
        returns (PayoutSummary memory);

    /// @notice This will get the status of a recipient.
    /// @param _recipientId The ID of the recipient
    /// @return The status of the recipient
    function _getRecipientStatus(address _recipientId) internal view virtual returns (Status);

    /// ===================================
    /// ============== Hooks ==============
    /// ===================================

    /// @notice Hook called before increasing the pool amount.
    /// @param _amount The amount to increase the pool by
    function _beforeIncreasePoolAmount(uint256 _amount) internal virtual {}

    /// @notice Hook called after increasing the pool amount.
    /// @param _amount The amount to increase the pool by
    function _afterIncreasePoolAmount(uint256 _amount) internal virtual {}

    /// @notice Hook called before registering a recipient.
    /// @param _data The data to use to register the recipient
    /// @param _sender The address of the sender
    function _beforeRegisterRecipient(bytes memory _data, address _sender) internal virtual {}

    /// @notice Hook called after registering a recipient.
    /// @param _data The data to use to register the recipient
    /// @param _sender The address of the sender
    function _afterRegisterRecipient(bytes memory _data, address _sender) internal virtual {}

    /// @notice Hook called before allocating to a recipient.
    /// @param _data The data to use to allocate to the recipient
    /// @param _sender The address of the sender
    function _beforeAllocate(bytes memory _data, address _sender) internal virtual {}

    /// @notice Hook called after allocating to a recipient.
    /// @param _data The data to use to allocate to the recipient
    /// @param _sender The address of the sender
    function _afterAllocate(bytes memory _data, address _sender) internal virtual {}

    /// @notice Hook called before distributing funds (tokens) to recipients.
    /// @param _recipientIds The IDs of the recipients
    /// @param _data The data to use to distribute to the recipients
    /// @param _sender The address of the sender
    function _beforeDistribute(address[] memory _recipientIds, bytes memory _data, address _sender) internal virtual {}

    /// @notice Hook called after distributing funds (tokens) to recipients.
    /// @param _recipientIds The IDs of the recipients
    /// @param _data The data to use to distribute to the recipients
    /// @param _sender The address of the sender
    function _afterDistribute(address[] memory _recipientIds, bytes memory _data, address _sender) internal virtual {}
}

pragma solidity ^0.8.23;



// Interfaces


contract MADeliveryStrategy is IMargariAlloStrategy, IMVersion, MBaseStrategy { 

    string constant name = "RESERVED_M_A_DELIVERY_STRATEGY";
    uint256 constant version = 4; 

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
    function _isValidAllocator(address _allocator) internal view override returns (bool){
        return isValidAllocatorByAddress[_allocator];
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
            uint256 availableFunding_ = descriptor_.budget - descriptor_.spent; 
            require(remainingAllocationByProject[_recipientIds[x]] >= availableFunding_, "available funding <> remaining allocation mis-match");

            remainingAllocationByProject[_recipientIds[x]] -= availableFunding_;

            if(address(erc20_) == NATIVE){
                require(self.balance >= availableFunding_, "insufficient native token funds in pool ");
            }
            else {
                require(erc20_.balanceOf(self) >= availableFunding_, "insufficient funds in pool");
                erc20_.approve(register.getAddress(MARGARI_CA), availableFunding_);
            }

            PaymentDirective [] memory paymentDirectives_ = project_.getPaymentDirectives(); 
            (uint256 [] memory sendIds_, uint256 totalPaid_) = payoutDirectives(paymentDirectives_, projectAddress_);
            
            totalPaidByRecipient[projectAddress_] += totalPaid_;
            remainingAllocationByProject[_recipientIds[x]] += (availableFunding_ - totalPaid_);

        }
    }

    function payoutDirectives(PaymentDirective [] memory paymentDirectives_, address _projectAddress) internal returns (uint256 [] memory _sendIds, uint256 _totalPaid){
         IMargari margari = IMargari(register.getAddress(MARGARI_CA));
         IMProject project_ = IMProject(_projectAddress);

        _sendIds = new uint256[](paymentDirectives_.length);
        for(uint256 y = 0; y < paymentDirectives_.length; y++){
            PaymentDirective memory paymentDirective_ = paymentDirectives_[y];
            if(paymentDirective_.status == PaymentDirectiveStatus.IN_FLIGHT){  // only pay inflights
                _totalPaid += paymentDirective_.amount;  
                if(paymentDirective_.contributor.homeChain != register.getChainId()){ // gilt and cross chain dispatch foreign chain payments
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