// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Sender is Ownable {
    // Конструктор, который передает адрес владельца в конструктор Ownable
    constructor() Ownable(msg.sender) {}
    
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