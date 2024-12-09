// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// contract Logger {
//     mapping(address => uint[]) payments;

//     function log(address _from, uint _amount) public {
//         require(_from != address(0), "zero address!");

//         payments[_from].push(_amount);
//     }

//     function getEntry(address _from, uint _index) public view returns(uint) {
//         return payments[_from][_index];
//     }
// }

interface ILogger {
    function log(address _from, uint _amount) external;

    function getEntry(address _from, uint _index) external view returns(uint);
}

// import from file
// import "./logger.sol";

contract InterfaceDemo {
    ILogger logger;

    constructor(address _logger) {
        // create contract obj from its address
        logger = ILogger(_logger);
    }

    receive() external payable {
        logger.log(msg.sender, _msg.value);
    }
}