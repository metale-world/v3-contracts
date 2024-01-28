pragma solidity ^0.8.0;

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _transferOwnership(_msgSender());
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if the sender is not the owner.
     */
    function _checkOwner() internal view virtual {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

interface IBEP40 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the token decimals.
     */
    function decimals() external view returns (uint256);

    /**
     * @dev Returns the token symbol.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the token name.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the bep token owner.
     */
    function getOwner() external view returns (address);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(
        address _owner,
        address spender
    ) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
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
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

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
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

/**
 * @dev Contract module that helps prevent reentrant calls to a function.
 *
 * Inheriting from `ReentrancyGuard` will make the {nonReentrant} modifier
 * available, which can be applied to functions to make sure there are no nested
 * (reentrant) calls to them.
 *
 * Note that because there is a single `nonReentrant` guard, functions marked as
 * `nonReentrant` may not call one another. This can be worked around by making
 * those functions `private`, and then adding `external` `nonReentrant` entry
 * points to them.
 *
 * TIP: If you would like to learn more about reentrancy and alternative ways
 * to protect against it, check out our blog post
 * https://blog.openzeppelin.com/reentrancy-after-istanbul/[Reentrancy After Istanbul].
 */
abstract contract ReentrancyGuard {
    // Booleans are more expensive than uint256 or any type that takes up a full
    // word because each write operation emits an extra SLOAD to first read the
    // slot's contents, replace the bits taken up by the boolean, and then write
    // back. This is the compiler's defense against contract upgrades and
    // pointer aliasing, and it cannot be disabled.

    // The values being non-zero value makes deployment a bit more expensive,
    // but in exchange the refund on every call to nonReentrant will be lower in
    // amount. Since refunds are capped to a percentage of the total
    // transaction's gas, it is best to keep them low in cases like this one, to
    // increase the likelihood of the full refund coming into effect.
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;

    uint256 private _status;

    constructor() {
        _status = _NOT_ENTERED;
    }

    /**
     * @dev Prevents a contract from calling itself, directly or indirectly.
     * Calling a `nonReentrant` function from another `nonReentrant`
     * function is not supported. It is possible to prevent this from happening
     * by making the `nonReentrant` function external, and making it call a
     * `private` function that does the actual work.
     */
    modifier nonReentrant() {
        _nonReentrantBefore();
        _;
        _nonReentrantAfter();
    }

    function _nonReentrantBefore() private {
        // On the first call to nonReentrant, _status will be _NOT_ENTERED
        require(_status != _ENTERED, "ReentrancyGuard: reentrant call");

        // Any calls to nonReentrant after this point will fail
        _status = _ENTERED;
    }

    function _nonReentrantAfter() private {
        // By storing the original value once again, a refund is triggered (see
        // https://eips.ethereum.org/EIPS/eip-2200)
        _status = _NOT_ENTERED;
    }

    /**
     * @dev Returns true if the reentrancy guard is currently set to "entered", which indicates there is a
     * `nonReentrant` function in the call stack.
     */
    function _reentrancyGuardEntered() internal view returns (bool) {
        return _status == _ENTERED;
    }
}

// helper methods for interacting with ERC20 tokens and sending ETH that do not consistently return true/false
library TransferHelper {
    function safeApprove(address token, address to, uint256 value) internal {
        // bytes4(keccak256(bytes('approve(address,uint256)')));
        (bool success, bytes memory data) = token.call(
            abi.encodeWithSelector(0x095ea7b3, to, value)
        );
        require(
            success && (data.length == 0 || abi.decode(data, (bool))),
            "TransferHelper: APPROVE_FAILED"
        );
    }

    function safeTransfer(address token, address to, uint256 value) internal {
        // bytes4(keccak256(bytes('transfer(address,uint256)')));
        (bool success, bytes memory data) = token.call(
            abi.encodeWithSelector(0xa9059cbb, to, value)
        );
        require(
            success && (data.length == 0 || abi.decode(data, (bool))),
            "TransferHelper: TRANSFER_FAILED"
        );
    }

    function safeTransferFrom(
        address token,
        address from,
        address to,
        uint256 value
    ) internal {
        // bytes4(keccak256(bytes('transferFrom(address,address,uint256)')));
        (bool success, bytes memory data) = token.call(
            abi.encodeWithSelector(0x23b872dd, from, to, value)
        );
        require(
            success && (data.length == 0 || abi.decode(data, (bool))),
            "TransferHelper: TRANSFER_FROM_FAILED"
        );
    }

    function safeTransferETH(address to, uint256 value) internal {
        (bool success, ) = to.call{value: value}(new bytes(0));
        require(success, "TransferHelper: ETH_TRANSFER_FAILED");
    }
}

interface CreateBookDelegate {
    function createBook(
        string memory _name,
        address _author
    ) external returns (address);

    function mint(address to, address book, uint256 tokenId) external;
}

contract MetaleTech is Ownable, ReentrancyGuard {
    using SafeMath for uint256;

    address public protocolFeeDestination =
        0x9884aD84143BD948298107696d77EF2E70e56B49;
    address public holdingFeeDestination =
        0xEE2D107cCf18C6B4C441353c0f86Aa08eDa61B50;
    uint256 public protocolFeePercent = 300000000000000000;
    uint256 public subjectFeePercent = 300000000000000000;
    uint256 public holdingFeePercent = 400000000000000000;

    IBEP40 public rcm = IBEP40(0xaFC1C35ae28d6A20E837a7bBbFF2807095281fcf);
    // create book by user
    CreateBookDelegate public createBookDelegate =
        CreateBookDelegate(0x74AA0e52D9fd8513A9E11d671e67E805842c1eEe);

    event Trade(
        address trader,
        address subject,
        bool isBuy,
        uint256 shareAmount,
        uint256 ethAmount,
        uint256 protocolEthAmount,
        uint256 subjectEthAmount,
        uint256 holderAmount,
        uint256 supply
    );

    event BookCreate(address author, uint256 index, address book, string name);

    event Transfer(address book, address from, address to, uint256 amount);

    // books
    // book-address => author address
    mapping(address => address) public author;
    // author address => book address list
    mapping(address => address[]) public books;

    // book => (Holder => Balance)
    mapping(address => mapping(address => uint256)) public sharesBalance;

    // book => Supply
    mapping(address => uint256) public sharesSupply;

    // user can lock his book shares
    // user address => book => lock amount
    mapping(address => mapping(address => uint256)) public lockedTo;

    // book max supply
    mapping(address => uint256) private maxSupply;

    // Book Base Price, it will decrease if rcm price is up
    mapping(address => uint) public bookBasePrice;
    uint256 public defaultBookBasePrice = 10000;

    // shares can transfer if enable
    bool public transferEnable = false;

    // step fee
    // shares 0-50, fee = 10%
    // shares 51-100 fee = 7%
    // shares 101-150 fee = 4%
    // shares 150-inf fee = 1%
    uint256[][] public stepFee;

    // 0 -> 10, 50 -> 7, 100 -> 4, 150 -> 1
    function setStepFee(uint256[][] memory _stepFee) public onlyOwner {
        stepFee = _stepFee;
    }

    function setTransferEnable(bool value) public onlyOwner {
        transferEnable = value;
    }

    function setDefaultBookBasePrice(uint256 value) public onlyOwner {
        defaultBookBasePrice = value;
    }

    function createdBookSize(address _author) external view returns (uint256) {
        return books[_author].length;
    }

    // change book maxSupply, can only decrease
    function changeMaxSupply(address book, uint256 _maxSupply) external {
        require(author[book] == msg.sender, "not author");
        uint256 prev = getMaxSupply(book);
        require(_maxSupply < prev && _maxSupply > 0, "only support decrease");
        maxSupply[book] = _maxSupply;
    }

    function getMaxSupply(address book) public view returns (uint256) {
        uint256 value = maxSupply[book];
        if (value == 0) {
            value = 5000;
        }
        return value;
    }

    // create book by user
    function createBook(
        string memory name,
        uint256 index,
        uint256 _maxSupply
    ) public {
        require(books[msg.sender].length == index, "invalid index");
        require(_maxSupply <= 5000, "MaxSupply cannot be greater than 5000");
        address book = createBookDelegate.createBook(name, msg.sender);
        author[address(book)] = msg.sender;
        books[msg.sender].push(address(book));
        maxSupply[address(book)] = _maxSupply;
        bookBasePrice[address(book)] = defaultBookBasePrice;
        emit BookCreate(msg.sender, index, address(book), name);
    }

    // lock book shares by user
    function lockShares(address book, uint256 timestamp) public {
        require(
            timestamp < block.timestamp + 31104000,
            "can't lock more than 360 days"
        );
        require(
            timestamp > lockedTo[msg.sender][book],
            "only support increase"
        );
        lockedTo[msg.sender][book] = timestamp;
    }

    function setCreateBookDelegate(address _delegate) public onlyOwner {
        createBookDelegate = CreateBookDelegate(_delegate);
    }

    function setProtocalFeeDestination(
        address _feeDestination
    ) public onlyOwner {
        protocolFeeDestination = _feeDestination;
    }

    function setHoldingFeeDestination(
        address _feeDestination
    ) public onlyOwner {
        holdingFeeDestination = _feeDestination;
    }

    function setFee(
        uint256 _protocalFee,
        uint256 _subjectFee,
        uint256 _holdingFee
    ) public onlyOwner {
        protocolFeePercent = _protocalFee;
        subjectFeePercent = _subjectFee;
        holdingFeePercent = _holdingFee;
    }

    // get price, similar to friend.tech
    function getPrice(
        uint256 supply,
        uint256 amount
    ) public pure returns (uint256) {
        uint256 sum1 = supply == 0
            ? 0
            : ((supply - 1) * (supply) * (2 * (supply - 1) + 1)) / 6;
        uint256 sum2 = supply == 0 && amount == 1
            ? 0
            : ((amount + supply - 1) *
                (supply + amount) *
                (2 * (amount + supply - 1) + 1)) / 6;
        uint256 summation = sum2 - sum1;
        return (1000 * (summation * 1 ether)) / 16000;
    }

    function getPriceAndFeeWithBaseAndAmount(
        uint256 basePrice,
        uint256 baseAmount,
        uint256 amount
    ) public view returns (uint256, uint256) {
        uint256 price = (getPrice(baseAmount, amount) * basePrice) / 10000;
        uint fee = 0;
        // step calculate fee
        uint256 feePercent = stepFee[0][1];
        for (uint256 i = 1; i < stepFee.length; i++) {
            uint next = stepFee[i][0];
            uint nextFeePercent = stepFee[i][1];
            if (baseAmount + amount <= next) {
                fee += (getPrice(baseAmount, amount) * feePercent) / 1 ether;
                break;
            } else {
                fee +=
                    (getPrice(baseAmount, next - baseAmount) * feePercent) /
                    1 ether;
                amount -= (next - baseAmount);
                baseAmount = next;
                feePercent = nextFeePercent;
            }
        }
        fee = (fee * basePrice) / 10000;
        return (price, fee);
    }

    function getBuyPriceAfterFee(
        address book,
        uint256 amount
    ) public view returns (uint256, uint256, uint256) {
        (uint256 price, uint256 fee) = getPriceAndFeeWithBaseAndAmount(
            bookBasePrice[book],
            sharesSupply[book],
            amount
        );
        return (price + fee, price, fee);
    }

    function getSellPriceAfterFee(
        address book,
        uint256 amount
    ) public view returns (uint256, uint256, uint256) {
        (uint256 price, uint256 fee) = getPriceAndFeeWithBaseAndAmount(
            bookBasePrice[book],
            sharesSupply[book] - amount,
            amount
        );
        return (price - fee, price, fee);
    }

    // buy shares by user, the first must be author buy
    function buyShares(address book, uint256 amount) public nonReentrant {
        require(amount > 0, "invalid amount");
        uint256 supply = sharesSupply[book];
        require(
            supply > 0 || author[book] == msg.sender,
            "Only the shares' subject can buy the first share"
        );
        require(supply + amount <= getMaxSupply(book), "Insufficient supply ");
        (, uint256 price, uint256 fee) = getBuyPriceAfterFee(book, amount);
        uint256 protocolFee = (fee * protocolFeePercent) / 1 ether;
        uint256 holdingFee = (fee * holdingFeePercent) / 1 ether;
        uint256 subjectFee = (fee * subjectFeePercent) / 1 ether;

        // transfer rcm
        require(
            rcm.balanceOf(msg.sender) >= price + fee,
            "Insufficient rcm balance"
        );
        sharesBalance[book][msg.sender] += amount;
        sharesSupply[book] += amount;

        if (price > 0) {
            rcm.transferFrom(msg.sender, address(this), price);
        }
        if (protocolFee > 0) {
            rcm.transferFrom(msg.sender, protocolFeeDestination, protocolFee);
        }
        if (holdingFee > 0) {
            rcm.transferFrom(msg.sender, holdingFeeDestination, holdingFee);
        }
        if (subjectFee > 0) {
            rcm.transferFrom(msg.sender, author[book], subjectFee);
        }

        emit Trade(
            msg.sender,
            book,
            true,
            amount,
            price,
            protocolFee,
            subjectFee,
            holdingFee,
            supply + amount
        );
    }

    function buySharesWithLock(
        address book,
        uint256 amount,
        uint256 timestamp
    ) public {
        buyShares(book, amount);
        lockShares(book, timestamp);
    }

    function sellShares(address book, uint256 amount) public nonReentrant {
        require(amount > 0, "invalid amount");
        require(lockedTo[msg.sender][book] < block.timestamp, "shares locked");
        uint256 supply = sharesSupply[book];
        require(supply > amount, "Cannot sell the last share");
        (, uint256 price, uint256 fee) = getSellPriceAfterFee(book, amount);
        uint256 protocolFee = (fee * protocolFeePercent) / 1 ether;
        uint256 holdingFee = (fee * holdingFeePercent) / 1 ether;
        uint256 subjectFee = (fee * subjectFeePercent) / 1 ether;

        // transfer rcm
        require(
            rcm.balanceOf(address(this)) >= price,
            "Insufficient rcm balance"
        );
        require(
            sharesBalance[book][msg.sender] >= amount,
            "Insufficient shares"
        );
        sharesBalance[book][msg.sender] -= amount;
        sharesSupply[book] -= amount;

        if (price - fee > 0) {
            rcm.transfer(msg.sender, price - fee);
        }
        if (protocolFee > 0) {
            rcm.transfer(protocolFeeDestination, protocolFee);
        }
        if (holdingFee > 0) {
            rcm.transfer(holdingFeeDestination, holdingFee);
        }
        if (subjectFeePercent > 0) {
            rcm.transfer(author[book], subjectFee);
        }

        emit Trade(
            msg.sender,
            book,
            false,
            amount,
            price,
            protocolFee,
            subjectFee,
            holdingFee,
            supply - amount
        );
    }

    // book shares to nft, can't reverse
    function bookToBNft(address book, uint256 tokenId) public nonReentrant {
        require(lockedTo[msg.sender][book] < block.timestamp, "shares locked");
        require(sharesBalance[book][msg.sender] >= 1, "Insufficient shares");
        sharesBalance[book][msg.sender] -= 1;
        createBookDelegate.mint(msg.sender, book, tokenId);
    }

    // transfer shares if transfer able
    function transfer(
        address book,
        address dest,
        uint amount
    ) public nonReentrant {
        require(transferEnable, "transfer not enabled");
        require(
            sharesBalance[book][msg.sender] >= amount,
            "Insufficient shares"
        );
        sharesBalance[book][msg.sender] -= amount;
        sharesBalance[book][dest] += amount;
        emit Transfer(book, msg.sender, dest, amount);
    }

    // change read2n-v2 init supply
    address public changeInitSupplyAddress = msg.sender;

    // create book by admin, after finish, the address it set to address(0) by discardInitSupplyAddress
    function createBookWithInitSupply(
        string memory name,
        address _author,
        uint256 index,
        uint256 _maxSupply,
        uint256 _initSupply
    ) public {
        require(msg.sender == changeInitSupplyAddress, "not owner");
        require(books[_author].length == index, "invalid index");
        require(_maxSupply <= 5000, "MaxSupply cannot be greater than 5000");
        address book = createBookDelegate.createBook(name, _author);
        author[address(book)] = _author;
        books[_author].push(address(book));
        maxSupply[address(book)] = _maxSupply;
        sharesSupply[address(book)] = _initSupply;
        bookBasePrice[address(book)] = defaultBookBasePrice;
        emit BookCreate(_author, index, address(book), name);
    }

    function changeInitSupply(address book, uint256 initSupply) external {
        require(msg.sender == changeInitSupplyAddress, "not owner");
        sharesSupply[book] = initSupply;
    }

    function discardInitSupplyAddress() external {
        require(msg.sender == changeInitSupplyAddress, "not owner");
        changeInitSupplyAddress = address(0);
    }

    // contract data migrate
    address public contractMigrateAddress = msg.sender;
    modifier onlyMigrate() {
        require(msg.sender == contractMigrateAddress, "only migrate address");
        _;
    }

    // migrate contract, after finish, the address it set to address(0) by discardInitSupplyAddress
    function migrateBook(
        address[] memory _books,
        address[] memory _authors
    ) public onlyMigrate {
        for (uint256 i = 0; i < _books.length; i++) {
            address _book = _books[i];
            address _author = _authors[i];
            author[_book] = _author;
            books[_author].push(_book);
            maxSupply[_book] = 5000;
            bookBasePrice[_book] = 10000;
        }
    }

    function migrateSharesBalance(
        address[] memory _accounts,
        address[] memory _books,
        uint256[] memory _balances
    ) public onlyMigrate {
        for (uint256 i = 0; i < _accounts.length; i++) {
            sharesBalance[_books[i]][_accounts[i]] = _balances[i];
        }
    }

    function migrateSharesSupply(
        address[] memory _books,
        uint256[] memory _supplys
    ) public onlyMigrate {
        for (uint256 i = 0; i < _books.length; i++) {
            sharesSupply[_books[i]] = _supplys[i];
        }
    }

    function discardMigrateAddress() public onlyMigrate {
        contractMigrateAddress = address(0);
    }
}
