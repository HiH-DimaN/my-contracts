// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './AlbumTracker.sol';

contract Album {
    uint public price;      // Цена альбома
    string public title;    // Название альбома
    bool public purchased;  // Флаг, который указывает, был ли альбом куплен
    uint public index;      // Индекс альбома в системе отслеживания
    AlbumTracker tracker;   // Ссылка на контракт AlbumTracker для управления состоянием альбома

    // Конструктор, который инициализирует контракт альбома
    constructor(uint _price, string memory _title, uint _index, AlbumTracker _tracker) {
        price = _price;     // Устанавливаем цену альбома 
        title = _title;     // Устанавливаем название альбома
        index = _index;     // Устанавливаем индекс альбома
        tracker = _tracker; // Устанавливаем ссылку на контракт AlbumTracker
    }

    // Функция, которая вызывается при получении эфира на контракт
    receive() external payable { 
        require(!purchased, "This album is already purchased!");       // Проверка, что альбом еще не куплен
        require(price == msg.value, "We accept only full payments!");  // Проверка, что отправленная сумма совпадает с ценой альбома

        // Вызов функции triggerPayment контракта AlbumTracker для изменения состояния альбома на "оплаченный"
        (bool success, ) = address(tracker).call{value: msg.value}(abi.encodeWithSignature("triggerPayment(uint256)", index));
        require(success, "Sorry, we could not process your transaction.");  // Проверка успешности транзакции

        purchased = true;  // Установка флага, что альбом был куплен
    }
}