// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Ownable {
    address public owner;

    constructor(address ownerOverride) {
        owner = ownerOverride == address(0) ? msg.sender : ownerOverride;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "not an owner");
        _;
    }

    // virtual - this function can be overrided in the contract child
    function withdraw(address payable _to) public virtual onlyOwner {
        _to.transfer(address(this).balance);
    }
}

abstract contract Balances is Ownable {
    function getBalance() public view onlyOwner returns(uint) {
        return address(this).balance;
    }

    function withdraw(address payable _to) public override virtual onlyOwner {
        _to.transfer(getBalance());
    }
}

contract Inheritance is Ownable, Balances {
    constructor() Ownable(msg.sender) {

    }

    function withdraw(address payable _to) public override(Ownable, Balances) onlyOwner {
        //Balances.wathdraw(_to);
        super.withdraw(_to);
    }

}