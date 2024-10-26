// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Импортируем контракт Ownable из библиотеки OpenZeppelin
import "@openzeppelin/contracts/access/Ownable.sol";

// Объявляем контракт UserStorage, наследуемся от Ownable
contract UserOwnable is Ownable {

    // Структура для хранения информации о пользователе
    struct User {
        string name; // Имя пользователя
        uint age; // Возраст пользователя
    }

    // Мэппинг для хранения данных пользователей по их адресам
    mapping (address => User) private users;

    // Конструктор контракта UserStorage
    // Передает адрес развертывающего контракта в конструктор Ownable
    constructor() Ownable(msg.sender) {}

    // Функция для установки информации о пользователе
    // Только сам пользователь может установить свои данные
    function setUser(string memory _name, uint _age) public {
        users[msg.sender] = User(_name, _age); // Сохраняем данные пользователя в мэппинг
    } 

    // Функция для получения информации о пользователе по адресу
    // Может быть вызвана любым пользователем
    function getUser(address _user) public view returns (string memory, uint) {
        User memory user = users[_user]; // Получаем данные пользователя из мэппинга
        return (user.name, user.age);    // Возвращаем имя и возраст пользователя 
    }

    // Функция для удаления информации о пользователе
    // Может быть вызвана только владельцем контракта
    function deleteUser(address _user) public onlyOwner {
        delete users[_user]; // Удаляем данные пользователя из мэппинга
    }

}