// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Functions {

    string message = "Hello!";
    uint public balance;

    // allows to receive money by default
    receive() external payable {

    }

    // default function, if someone has called non existed function
    fallback() external payable {

    }

    // public - both outside contract and inside contract
    // external - outside contract only
    // internal - inside contract only
    // private - inside only (not even childrens)

    // view - can read data, but nor modify
    //    can be called via 'call'
    // pure - can't read any external data
    //    also can be called vua 'call'
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function getMessage() external pure returns(string memory) {
        return "hello!";
    }

    // can be called via transaction
    // can not return any value
    function setMessage(string memory newMessage) public {
        message = newMessage;
    }

    // payable - can receive money
    function pay() external payable {
        balance += msg.value;
    }
 }