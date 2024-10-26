// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract SharedWallet is Ownable {
    // Структура для представления члена (пользователя) кошелька
    struct Member {
        string name;    // Имя пользователя
        uint limit;     // Лимит на снятие средств
        bool is_admin;  // Флаг, определяющий, является ли пользователь администратором
    }

    // Маппинг для хранения информации о членах кошелька
    mapping(address => Member) public members;

    // Событие, сигнализирующее об изменении лимита для пользователя
    event LimitChanged(address indexed member, uint oldLimit, uint newLimit);

    // Событие, сигнализирующее о назначении нового администратора
    event AdminAdded(address indexed member);

    // Событие, сигнализирующее о снятии роли администратора
    event AdminRevoked(address indexed member);

    // Конструктор контракта
    constructor(address _owner) Ownable(_owner) {
        // Устанавливаем владельца как первого администратора
        members[msg.sender] = Member("Owner", 0, true);
    }

    // Проверка, является ли отправитель владельцем контракта
    function isOwner() internal view returns(bool) {
        return owner() == _msgSender();
    }

    // Модификатор, проверяющий, является ли отправитель владельцем или находится ли он в пределах лимита
    modifier ownerOrWithinLimits(uint amount) {
        Member memory member = members[_msgSender()];
        require(
            isOwner() || 
            member.is_admin || 
            member.limit >= amount, 
            "You are not allowed to perform this operation!"
        );
        _;
    }

    // Добавление нового пользователя в кошелек
    function addMember(address memberAddress, string memory name, uint limit, bool isAdmin) public onlyOwner {
        uint oldLimit = members[memberAddress].limit;
        members[memberAddress] = Member(name, limit, isAdmin);

        // Запускаем событие при изменении лимита
        emit LimitChanged(memberAddress, oldLimit, limit);
    }

    // Установка нового лимита для пользователя
    function setLimit(address memberAddress, uint limit) public onlyOwner {
        uint oldLimit = members[memberAddress].limit;
        members[memberAddress].limit = limit;

        // Запускаем событие при изменении лимита
        emit LimitChanged(memberAddress, oldLimit, limit);
    }

    // Вычитание суммы из лимита пользователя
    function deduceFromLimit(address memberAddress, uint amount) internal {
        members[memberAddress].limit -= amount;
    }

    // Отказ от владения контрактом
    function renounceOwnership() override public view onlyOwner {
        revert("Can't renounce!");
    }

    // Функция, делающая пользователя администратором
    function makeAdmin(address memberAddress) public onlyOwner {
        members[memberAddress].is_admin = true;

        // Испускаем событие о назначении нового администратора
        emit AdminAdded(memberAddress);
    }

    // Функция, снимающая роль администратора у пользователя
    function revokeAdmin(address memberAddress) public onlyOwner {
        members[memberAddress].is_admin = false;

        // Испускаем событие о снятии роли администратора
        emit AdminRevoked(memberAddress);
    }
}