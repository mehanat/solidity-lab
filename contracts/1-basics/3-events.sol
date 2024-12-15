// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Events {
    // require - condition is met, otherwise returns an error message
    // revert - return an error message
    // assert - if condition is not met, raise a Panic error
    address owner;

    event Paid(address indexed _from, uint _amount, uint _timestamp);

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {
        pay();
    }

    modifier onlyOwner(address _to) {
        require(msg.sender == owner, "You are not an owner!");
        require(_to != address(0), "Incorrect address!");
        // call main function
        _;
    }

    function pay() public payable {
        emit Paid(msg.sender, msg.value, block.timestamp);
    }

    function withdraw(address payable _to) external onlyOwner(_to) {
        require(msg.sender == owner, "You are not an owner!");

        if (msg.sender != owner) {
            revert("You are not an owner!");
        }

        _to.transfer(
            address(this).balance
        );
    }
}