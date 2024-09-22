// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import './Album.sol';

contract AlbumTracker is Ownable{

    // Конструктор, который вызывает конструктор Ownable и устанавливает владельца контракта
    constructor() Ownable(msg.sender) {}

    // Перечисление, описывающее возможные состояния альбома
    enum AlbumState {
        Created,      // Альбом создан
        Paid,         // Альбом оплачен
        Delivered    // Альбом доставлен
    }

    // Структура, представляющая альбом с его текущим состоянием
    struct AlbumProduct {
        Album album;       // Контракт альбома    
        AlbumState state;  // Текущее состояние альбома
        uint price;        // Цена альбома
        string title;       // Название альбома
    }

    // Событие, которое вызывается при изменении состояния альбома
    event AlbumStateChanged(uint _albumIndex, uint _stateNum, address _albuumAddress);

    // Хранение всех альбомов в маппинге по их индексам
    mapping (uint => AlbumProduct) public albums;
    uint currentIndex;    // Текущий индекс для новых альбомов

    // Функция создания нового альбома. Доступна только владельцу контракта.
    function creatAlbum(uint _price, string memory _title) public onlyOwner {
        Album newAlbum = new Album(_price, _title, currentIndex, this);  // Создание нового контракта альбома

        // Инициализация данных нового альбома в маппинге
        albums[currentIndex].album = newAlbum;
        albums[currentIndex].state = AlbumState.Created;
        albums[currentIndex].price = _price;
        albums[currentIndex].title = _title;

        emit AlbumStateChanged(currentIndex, uint(albums[currentIndex].state), address(newAlbum));

        currentIndex++;   // Увеличение текущего индекса для следующего альбома
    }

    // Функция, вызываемая для подтверждения оплаты альбома
    function triggerPayment(uint _index) public payable {
        require(albums[_index].state == AlbumState.Created, "This album is already purchased!");   // Проверка, что альбом находится в состоянии "создан"
        require(albums[_index].price == msg.value, "We accept only full payments!");   // Проверка, что сумма соответствует цене альбома

        albums[_index].state = AlbumState.Paid;   // Изменение состояния альбома на "оплачен"

        emit AlbumStateChanged(_index, uint(albums[_index].state), address(albums[_index].album));   // Вызов события об изменении состояния

    }

    // Функция, вызываемая для подтверждения доставки альбома
    function triggerDelivery(uint _index) public {
        require(albums[_index].state == AlbumState.Paid, "This album is not paid for!");   // Проверка, что альбом находится в состоянии "оплачен"

        albums[_index].state = AlbumState.Delivered;   // Изменение состояния альбома на "доставлен"

        emit AlbumStateChanged(_index, uint(albums[_index].state), address(albums[_index].album));   // Вызов события об изменении состояния

    }
}