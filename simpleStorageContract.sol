pragma solidity >=0.7.0 <0.9.0;

// create a contract that can store data and return it back when needed

// it can do the following:

// 1.recieve information 2.store information and 3.return information back

contract simpleStorage{
    // write states and functions

    uint storeData;

    // public enables visibility so that we can call this outside of contract

    function set(uint value) public {
        storeData = value;
    }

    // view tells that this function doesn't modify any state and is read only
    // return define the type of data returned by the function

    function get() public view returns (uint) {
        return storeData;
    }


}