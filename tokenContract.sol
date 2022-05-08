pragma solidity >=0.7.0 <0.9.0;

// The contract allows contract owner to create new tokens
// Anyone can send token to any address

contract Token {
    // public making variables accessible outside of contract
    address public minter;
    mapping(address => uint256) public balances;

    // it runs when the contract is deployed
    constructor() {
        minter = msg.sender;
    }

    // event
    event sent(address from, address to, uint256 amount);

    modifier onlyOwner() {
        require(minter == msg.sender);
        _;
    }

    // function to mint new tokens
    function mint(address payable reciever, uint256 amount) public onlyOwner {
        balances[reciever] += amount;
    }

    // error is returned to caller displaying what goes wrong
    error insufficientBalance(uint256 requested, uint256 available);

    // function to send token to specified address
    function send(address payable reciever, uint256 amount) public {
        address sender = msg.sender;

        if (amount > balances[sender])
            revert insufficientBalance({
                requested: amount,
                available: balances[sender]
            });

        balances[sender] -= amount;
        balances[reciever] += amount;

        emit sent(sender, reciever, amount);
    }
}
