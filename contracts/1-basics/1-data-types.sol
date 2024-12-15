// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataTypes {

    // boolean
    bool public myBool;
    // integer
    uint public myUint = 42;
    int public myInt = -42;
    // string
    string public myStr = "test";
    // address
    address public myAddr = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    // mapping
    mapping (address => uint) public payments;
    // enum
    enum Status {
        PAID, DELIVERED, RECEIVED
    }
    Status public curStatus = Status.PAID;
    // array
    uint[10] public items = [1,2,3];
    uint[] public dynamicArray;
    // byte arrays
    bytes1 public byteArray;
    bytes32 public strArray = "test";
    // struct
    struct Payment {
        uint amount;
        uint timestamp;
    }

    function demoStruct() public view  {
        Payment memory newPayment = Payment(
            10,
            block.timestamp
        );
    }

    function demoArray() public  {
        items[0] = 100;
        dynamicArray.push(4);
        dynamicArray.length; 

        // in-memory array
        uint[] memory inmemoryArray = new uint[](10); 

    } 

    function getBalance(address targetAddr) public view returns(uint) {
        return targetAddr.balance;
    }

    function transferTo(address payable targetAddr, uint amount) public {
        // address payable _to = payable (targetAddr);
        targetAddr.transfer(amount);
    }

    function receiveFunds() public payable {
        payments[msg.sender] = msg.value;
    }

    function myFunc(bool _inputBool)  public {
        bool localBool = false;
        if (localBool && _inputBool) {}

        string memory myTmpStr = "temp";
        myStr = "new value";

    }

}