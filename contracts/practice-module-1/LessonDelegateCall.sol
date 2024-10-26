// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title Delegate
 * @author HiH_DimaN
 * @notice Контракт, который будет использоваться для делегирования вызовов.
 */
contract Delegate {
    uint public num; // Переменная для хранения числа
    address public seneder; // Переменная для хранения адреса отправителя
    address public delegate; // Переменная для хранения адреса делегата

    /**
     * @dev Функция для установки значений переменных.
     * @param _num Новое значение для переменной num.
     */
    function setVars(uint _num) public {
        num = _num; // Устанавливаем значение переменной num
        seneder = msg.sender; // Устанавливаем значение переменной sender
    }
}

/**
 * @title Sender
 * @author HiH_DimaN
 * @notice Контракт, который отправляет Ether другому контракту и вызывается для взаимодействия с другим контрактом.
 */
contract Sender is Ownable {
    uint public num; // Переменная для хранения числа
    address public sender; // Переменная для хранения адреса отправителя
    address public delegate; // Адрес делегата (контракта Delegate)

    /**
     * @dev Конструктор, который передает адрес владельца в конструктор Ownable
     * и устанавливает адрес делегата.
     * @param _delegate Адрес контракта Delegate.
     */
    constructor(address _delegate) Ownable(_delegate) {
        delegate = _delegate; // Устанавливаем адрес делегата
    }    
    
    /**
     * @dev Функция для получения Ether контрактом.
     */
    receive() external payable { }

    /**
     * @dev Функция для отправки Ether на другой контракт.
     * @param recipient Адрес получателя.
     * @param amount Количество Ether для отправки.
     */
    function sendEther(address payable recipient, uint amount) external onlyOwner {
        require(address(this).balance >= amount, "Insufficient balance"); // Проверяем баланс отправителя
        recipient.transfer(amount); // Переводим Ether на другой контракт
    } 

    /**
     * @dev Функция для вызова другого контракта с использованием abi.encode и call.
     * @param target Адрес целевого контракта.
     * @param method Номер метода, который нужно вызвать на целевом контракте.
     */
    function callOtherContract(address target, uint method) external payable {
        require(address(this).balance >= msg.value, "Insufficient balance to send"); // Проверяем баланс отправителя

        if (method == 1) {
            // Вызов функции receiveEther1() на целевом контракте с отправкой эфира
            (bool success, ) = target.call{value: msg.value}(abi.encodeWithSignature("receiveEther1()")); // Вызываем функцию receiveEther1()
            require(success, "Call to receiveEther1 failed"); // Проверяем успешность вызова
        } else if (method == 2) {
            // Вызов функции receiveEther2() на целевом контракте с отправкой эфира
            (bool success,) = target.call{value: msg.value}(abi.encodeWithSelector(bytes4(keccak256("receiveEther2()")))); // Вызываем функцию receiveEther2()
            require(success, "Call to receiveEther2 failed"); // Проверяем успешность вызова
        } else if (method == 3) {
            // Вызов функции receiveEther3(uint256) на целевом контракте с отправкой эфира
            bytes memory payload = abi.encodeWithSelector(bytes4(keccak256("receiveEther3(uint256)")), 123); // Кодируем данные для вызова receiveEther3()
            (bool success,) = target.call{value: msg.value}(payload); // Вызываем функцию receiveEther3()
            require(success, "Call to receiveEther3 failed"); // Проверяем успешность вызова
        }
    }

    /**
     * @dev Функция для выполнения delegatecall к контракту Delegate.
     * @param _num Новое значение для переменной num в контракте Delegate.
     */
    function delegateCallSetVars(uint _num) public {
        // Выполнение delegatecall к функции setVars в контракте Delegate
        (bool success, ) = delegate.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", _num)
        ); // Выполняем delegatecall
        require(success, "delegatecall failed"); // Проверяем успешность вызова
    }    
}

/**
 * @title Receiver
 * @author HiH_DimaN
 * @notice Контракт, который принимает Ether и отправляет события.
 */
contract Receiver {
    // Событие для логирования полученного эфира
    event EtherReceived(address sender, uint amount, string method); // Событие для записи информации о получении эфира

    /**
     * @dev Функция для получения эфира, вызываемая методом 1.
     */
    function receiveEther1() external payable {
        emit EtherReceived(msg.sender, msg.value, "receiveEther1"); // Вызываем событие EtherReceived с информацией о получении эфира
    }

    /**
     * @dev Функция для получения эфира, вызываемая методом 2.
     */
    function receiveEther2() external payable {
        emit EtherReceived(msg.sender, msg.value, "receiveEther2"); // Вызываем событие EtherReceived с информацией о получении эфира
    }

    /**
     * @dev Функция для получения эфира, вызываемая методом 3.
     * @param param Параметр, который передается в функцию.
     */
    function receiveEther3(uint param) external payable {
        emit EtherReceived(msg.sender, msg.value, string(abi.encodePacked("receiveEther3: ", param))); // Вызываем событие EtherReceived с информацией о получении эфира и параметром
    }

    /**
     * @dev Функция для получения эфира контрактом.
     */
    receive() external payable {
        emit EtherReceived(msg.sender, msg.value, "fallback"); // Вызываем событие EtherReceived с информацией о получении эфира в fallback функции
    }
}
