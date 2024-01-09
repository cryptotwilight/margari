
// File: @openzeppelin/contracts/token/ERC20/IERC20.sol


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

// File: contracts/interfaces/IMVersion.sol


pragma solidity ^0.8.23;

interface IMVersion { 

    function getName() view external returns (string memory _name);

    function getVersion() view external returns (uint256 _version);
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
// File: contracts/interfaces/IMSender.sol


pragma solidity ^0.8.23;

interface IMSender {

    function getTransmittedGilt(uint256 _sendId) view external returns (TransmittedGilt memory _gilt);

    function sendGilt(uint256 _destinationChainId, Gilt memory _gilt, address _owner, bytes32 _alloProfileId, uint256 _projectId) external returns (uint256 _sendId);

}
// File: contracts/interfaces/IMReciever.sol


pragma solidity ^0.8.23;

interface IMReciever {

    function claimGilts(address _claimant) external returns (GiltClaim [] memory giltClaims);

}
// File: contracts/interfaces/IMargari.sol


pragma solidity ^0.8.23;

interface IMargari {

    // send a gilt to a destination chain 
    function sendGilt(Gilt memory _gilt, bytes32 _alloProfileId, uint256 _projectId, uint256 _destinationChainId) external returns (uint256 _sendId);

    // this function sends from the given project Id to the funds to the given remote recipient on the given chain
    function sendFunds(uint256 _chainId, address _erc20, uint256 _amount, address _remoteRecipient, bytes32 _alloProfileId, uint256 _projectId) external payable returns (uint256 _sendId);

    // this function enables the recipient to claim their gilts 
    function claimGilts() external returns (GiltClaim [] memory _giltClaims);

}
// File: contracts/interfaces/IMRegister.sol


pragma solidity ^0.8.23;


interface IMRegister {

    function getChainId() view external returns (uint256 _chainId);

    function getAddress(string memory _name) view external returns (address _address);

    function getName(address _address) view external returns (string memory _name);

    function getDestinationConfig(uint256 _chainId) view external returns (DestinationConfig memory _dConfig);

}
// File: contracts/core/Margari.sol


pragma solidity ^0.8.23;

contract Margari is IMargari, IMVersion { 

    string constant name = "RESERVED_MARGARI_CORE";
    uint256 constant version = 1; 
    address constant NATIVE = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

    string constant RECIEVER_CA = "RESERVED_M_RECIEVER";
    string constant SENDER_CA = "RESERVED_M_SENDER";
    string constant GILT_CONTRACT_CA = "RESERVED_GILT_CONTRACT"; 
    
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
        Gilt memory gilt_;
        if(_erc20 == NATIVE) {
            require(msg.value >= _amount, " insufficient value transmitted ");
            gilt_ = giltContract.bondFunds{value : _amount}(_erc20, _amount);
        }
        else {
            IERC20 erc20_ = IERC20(_erc20);
            erc20_.transferFrom(msg.sender, self, _amount);
            erc20_.approve(address(giltContract), _amount);
            gilt_ = giltContract.bondFunds(_erc20, _amount);
        }
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