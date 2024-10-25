//SPDX-License-Identifier:MIT

pragma solidity ^0.8.20;

contract BankHoneypot {
    ILogger private logger;
    mapping(address => uint) private _balances;

    constructor(address _logger) {
        logger = ILogger(_logger);
    }

    fuction deposit() external payable {
        _balances[msg.sender] += msg.value;
        logger.log(msg.sender, 1);
    }

    function withdraw(uint amount) external {
        _balances[msg.sender] -= amouint;
        (bool succes, ) = msg.sender.call{value: amount}("");
        require(succes);

        logger.log(msg.sender, 2);
    }

}

interface ILogger {
    event Log(address indexed initiator, uint indexed eventCode);

    function log(address initiator, uint eventCode) external;

}

contract Logger is ILogger {
    function log(address initiator, uint eventCode) external {
       emit Log(initiator, eventCode); 
    }

}

contract Honeypot {
    function log(address initiator, uint eventCode) external {
       if(eventCode == 2) {
        revert("honeypotted!");
       } 
    }
}