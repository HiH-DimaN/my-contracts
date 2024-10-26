// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LessonErrorsAndConditions {
    // Объявляем переменные состояния
    uint public myNumber;
    address public myAddress;
    bool public comparisonResult;

    // Функция для установки начальных значений переменных
    function initialize(uint _number, address _address) public {
        myNumber = _number;
        myAddress = _address;
    }

    // Функция для инкремента числа
    function incrementNumber() public {
        myNumber += 1;
    }

    // Функция для сравнения адресов
    function compareAddresses(address _addressToCompare) public {
        comparisonResult = (myAddress == _addressToCompare);
    }

    // Функция с использованием тернарного оператора
    function ternaryOperation(uint _inputNumber) public {
        comparisonResult = (_inputNumber > 100) ? true : false;
    }

    
}

