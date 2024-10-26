// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Delegate {
    uint public num; // Переменная для хранения числа
    address public seneder; // Переменная для хранения адреса отправителя
    address public delegate; // Переменная для хранения адреса делегата

    // Функция для установки значений переменных
    function setVars(uint _num) public {
        num = _num; // Устанавливаем значение переменной num
        seneder = msg.sender; // Устанавливаем значение переменной sender
    }
}

contract Sender is Ownable {
    uint public num; // Переменная для хранения числа
    address public sender; // Переменная для хранения адреса отправителя
    address public delegate; // Адрес делегата (контракта Delegate)

    // Конструктор, который передает адрес владельца в конструктор Ownable
    // и устанавливает адрес делегата
    constructor(address _delegate) Ownable(_delegate) {
        delegate = _delegate; // Устанавливаем адрес делегата
    }    
    
    // Получение Эфира контрактом
    receive() external payable { }

    // Функция для отправки Эфира на другой контракт
    function sendEther(address payable recipient, uint amount) external onlyOwner {
        require(address(this).balance >= amount, "Insufficient balance");
        recipient.transfer(amount);
    } 

    // Функция для вызова другого контракта с использованием abi.encode и call
    function callOtherContract(address target, uint method) external payable {
        require(address(this).balance >= msg.value, "Insufficient balance to send");

        if (method == 1) {
            // Вызов функции receiveEther1() на целевом контракте с отправкой эфира
            (bool success, ) = target.call{value: msg.value}(abi.encodeWithSignature("receiveEther1()"));
            require(success, "Call to receiveEther1 failed");
        } else if (method == 2) {
            // Вызов функции receiveEther2() на целевом контракте с отправкой эфира
            (bool success,) = target.call{value: msg.value}(abi.encodeWithSelector(bytes4(keccak256("receiveEther2()"))));
            require(success, "Call to receiveEther2 failed");
        } else if (method == 3) {
            // Вызов функции receiveEther3(uint256) на целевом контракте с отправкой эфира
            bytes memory payload = abi.encodeWithSelector(bytes4(keccak256("receiveEther3(uint256)")), 123);
            (bool success,) = target.call{value: msg.value}(payload);
            require(success, "Call to receiveEther3 failed");
        }
    }

    // Функция для выполнения delegatecall к контракту Delegate
    function delegateCallSetVars(uint _num) public {
        // Выполнение delegatecall к функции setVars в контракте Delegate
        (bool success, ) = delegate.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );
        require(success, "delegatecall failed");
    }    
}

contract Receiver {
    // Событие для логирования полученного эфира
    event EtherReceived(address sender, uint amount, string method);

    // Функция для получения эфира, вызываемая методом 1
    function receiveEther1() external payable {
        emit EtherReceived(msg.sender, msg.value, "receiveEther1");
    }

    // Функция для получения эфира, вызываемая методом 2
    function receiveEther2() external payable {
        emit EtherReceived(msg.sender, msg.value, "receiveEther2");
    }

    // Функция для получения эфира, вызываемая методом 3
    function receiveEther3(uint param) external payable {
        emit EtherReceived(msg.sender, msg.value, string(abi.encodePacked("receiveEther3: ", param)));
    }

    // Получение эфира контрактом
    receive() external payable {
        emit EtherReceived(msg.sender, msg.value, "fallback");
     }
}

