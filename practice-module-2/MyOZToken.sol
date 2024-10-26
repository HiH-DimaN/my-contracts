// Создать контракт токена на основе конструктора от OZ.
// Сделать деплой, минт 1 млн токенов и сжигание 0.5 от общего количества.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title MyToken
 * @dev Токен ERC20, созданный с помощью конструктора OpenZeppelin.
 */
contract MyOZToken is ERC20, Ownable {

    /**
     * @dev Конструктор токена.
     * Инициализирует токен с именем "My Token", символом "MYT",
     * создает 1 млн токенов для создателя контракта и 
     * задает количество десятичных знаков как 18.
     */
    constructor() ERC20("My Token", "MYT") Ownable(msg.sender) { // Передаем msg.sender в Ownable
        _mint(msg.sender, 1_000_000 * 10**18); // Минтим 1 млн токенов
    }

    /**
     * @dev Сжигает 500 тыс. токенов, принадлежащих владельцу.
     *
     * Доступно только для владельца контракта.
     */
    function burnTokens() public onlyOwner {
        _burn(msg.sender, 500_000 * 10**18);
    }
}