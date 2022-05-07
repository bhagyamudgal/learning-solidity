contract simpleStorage5x {
    uint256 storedData;

    function set(uint256 value) public {
        storedData = value * 5;
    }

    function get() public view returns (uint256) {
        return storedData;
    }
}
