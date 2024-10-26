// Data Storage Optimization Contract.
// Write a contract that optimizes data storage using bit fields.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/* @title Контракт для хранения данных о пользователях с оптимизацией
 * @author HiH_DimaN
 * @notice Этот контракт демонстрирует использование битовых полей для экономии газа
 */
contract UserRegistry {
    /* @notice Структура для хранения данных о пользователе с использованием битовых полей
     */
    struct User {
        string name; // Имя пользователя (256 бит)
        uint8 age; // Возраст пользователя (8 бит)
        bool isActive; // Активен ли пользователь (1 бит)
        // Оставшиеся места для bool значений: 256 - 8 - 1 = 247 бит
        uint256 flags; // Дополнительные флаги (256 бит), 
                       // каждый бит может использоваться для хранения bool значения

    }

    /* @notice Маппинг для хранения данных о пользователях
     * @dev Ключ - адрес пользователя, значение - структура User
     */
    mapping(address => User) public users; 

    /* @notice Функция для регистрации нового пользователя
     * @param _name Имя пользователя
     * @param _age Возраст пользователя
     */
    function registerUser(string memory _name, uint8 _age) public {
        users[msg.sender] = User(_name, _age, false, 0);
        // Все флаги по умолчанию устанавливаются в 0
    }

    /* @notice Функция для получения данных о пользователе
     * @param _userAddress Адрес пользователя
     * @return user Данные о пользователе (структура User)
     */
    function getUser(address _userAddress) public view returns (User memory user) {
        user = users[_userAddress];
    }

    /* @notice Функция для установки значения флага пользователя
     * @param _flagIndex Индекс флага (от 0 до 255)
     * @param _value Новое значение флага (true или false)
     */
    function setFlag(uint8 _flagIndex, bool _value) public {
        if (_value) {
            users[msg.sender].flags |= 1 << _flagIndex; // Устанавливаем бит в 1 
        } else {
            users[msg.sender].flags &= ~(1 << _flagIndex); // Устанавливаем бит в 0
        }
    }

    /* @notice Функция для получения значения флага пользователя
     * @param _flagIndex Индекс флага (от 0 до 255)
     * @return Значение флага (true или false)
     */
    function getFlag(uint8 _flagIndex) public view returns (bool) {
        return (users[msg.sender].flags & (1 << _flagIndex)) != 0;
    }


}