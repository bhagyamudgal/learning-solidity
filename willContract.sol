pragma solidity >=0.7.0 <0.9.0;

contract Will {
    address owner;
    uint256 fortune;
    bool isDeceased;

    // payable keyword means it can recieve or make payments
    constructor() public payable {
        owner = msg.sender; // msg.sender represents address that is being called
        fortune = msg.value; // msg value tells how much value is being sent
        isDeceased = false;
    }

    // create modifier so the only person who can call the contract is owner
    modifier onlyOwner() {
        require(owner == msg.sender);
        _;
    }

    // create modifier so that we only allocate funds if person is deceased
    modifier mustBeDeceased() {
        require(isDeceased == true);
        _;
    }

    // list of family wallets addresses
    address payable[] familyWallets;

    // map through inheritance
    mapping(address => uint256) inheritance;

    // function to set inheritance for each address
    function setInheritance(address payable wallet, uint256 amount)
        public
        onlyOwner
    {
        familyWallets.push(wallet);
        inheritance[wallet] = amount;
    }

    // function to pay each family member based on their wallet address
    function payout() private mustBeDeceased {
        for (uint256 i = 0; i < familyWallets.length; i++) {
            // transfering funds from contract address to family wallet address
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
        }
    }

    // oracle switch simulation
    function deceased() public onlyOwner {
        isDeceased = true;
        payout();
    }
}
