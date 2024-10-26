// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LessonGlobalVariablesAndConstructor {
    address public owner;
    uint public timestamp;
    uint public constant THREE_DAYS = 3 days;
    uint public constant TWO_WEEKS = 2 weeks;

    // Устанавливаем владельца контракта иметку времени при его создании
    constructor() {
        owner = msg.sender;
        timestamp = block.timestamp;
    }

    // модификатор проверки, что отправитель транзакции должен быть владельцем контракта и адрес не нулевой
    modifier onlyOwner(address _newAddr) {
        require(_newAddr != address(0), "Invalid address");
        require(owner == msg.sender, "Not the owner");
        _;

    }

    // Функция для проверки времени и обновления временной метки
    function checkAndUpdateTimestamp() public {
        if (block.timestamp >= timestamp + THREE_DAYS) {
            timestamp += TWO_WEEKS;
        }
    }

    // Функция для изменения владельца, доступна только текущему владельцу
    function changeOwner(address _newAddr) public onlyOwner(_newAddr) {
        owner = _newAddr;
    }
}