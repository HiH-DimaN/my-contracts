// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title LessonGlobalVariablesAndConstructor
 * @author HiH_DimaN
 * @notice Контракт, демонстрирующий работу с глобальными переменными и конструктором.
 */
contract LessonGlobalVariablesAndConstructor {
    /**
     * @dev Адрес владельца контракта.
     */
    address public owner; // Адрес владельца контракта

    /**
     * @dev Временная метка (timestamp).
     */
    uint public timestamp; // Временная метка

    /**
     * @dev Константа, представляющая 3 дня.
     */
    uint public constant THREE_DAYS = 3 days; // Константа, представляющая 3 дня

    /**
     * @dev Константа, представляющая 2 недели.
     */
    uint public constant TWO_WEEKS = 2 weeks; // Константа, представляющая 2 недели

    /**
     * @dev Конструктор контракта.
     * Устанавливает владельца контракта и временную метку при его создании.
     */
    constructor() {
        owner = msg.sender; // Устанавливаем владельца в адрес вызывающего
        timestamp = block.timestamp; // Устанавливаем временную метку в текущий блок timestamp
    }

    /**
     * @dev Модификатор, проверяющий, что отправитель транзакции является владельцем контракта и адрес не нулевой.
     * @param _newAddr Новый адрес.
     */
    modifier onlyOwner(address _newAddr) {
        require(_newAddr != address(0), "Invalid address"); // Проверяем, что адрес не нулевой
        require(owner == msg.sender, "Not the owner"); // Проверяем, что вызывающий является владельцем
        _; // Выполняем следующую инструкцию, если условия модификатора выполнены
    }

    /**
     * @dev Функция проверки времени и обновления временной метки.
     */
    function checkAndUpdateTimestamp() public {
        if (block.timestamp >= timestamp + THREE_DAYS) { // Проверяем, прошло ли 3 дня с момента установки timestamp
            timestamp += TWO_WEEKS; // Обновляем timestamp на 2 недели
        }
    }

    /**
     * @dev Функция изменения владельца контракта.
     * Доступна только текущему владельцу.
     * @param _newAddr Новый адрес владельца.
     */
    function changeOwner(address _newAddr) public onlyOwner(_newAddr) {
        owner = _newAddr; // Изменяем владельца на новый адрес
    }
}