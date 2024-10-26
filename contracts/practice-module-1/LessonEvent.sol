// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Event {

    event Log(address indexed sender, string message);
    event AnotherLog();

    function test() public {
        // Для порождения события следует написать в функции emit и название события с необходимыми аргументами
        emit Log(msg.sender, "Hello World!");
        emit Log(msg.sender, "Hello EVM!");
        emit AnotherLog();
    }
}