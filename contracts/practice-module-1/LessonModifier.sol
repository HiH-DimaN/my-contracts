// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract FunctionModifier {

    address public owner;
    uint public x = 10;
    bool public locked;

    constructor() {
        // Установка владельца контракта при его деплое.
        // Владельцем будет тот, кто делает деплой
        owner = msg.sender;
    }

    // Модификатор будет проверять права владельца
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    // Модификатор, который может принимать аргументы.
    // Проверяет равен ли введеный адрес нулевому адресу
    modifier validAddress(address _addr) {
        require(_addr != address(0), "Not valid address");
        _;
    }

    //Функция установки нового адреса владельца
    function changeOwner(address _newOwner) public onlyOwner validAddress(_newOwner) {
        owner = _newOwner;
    }

}