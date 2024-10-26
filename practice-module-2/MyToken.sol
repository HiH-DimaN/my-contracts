// Создать контракт токена, сделать деплой, минт 1 млн токенов

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title MyToken
 * @dev Токен ERC20, созданный с помощью конструктора OpenZeppelin.
 */
contract MyToken is ERC20, Ownable {

    /**
     * @dev Конструктор токена.
     * Инициализирует токен с именем "My Token", символом "MYT",
     * создает 1 млн токенов для создателя контракта и 
     * задает количество десятичных знаков как 18.
     */
    constructor() ERC20("My Token", "MYT")  Ownable(msg.sender) { 
        _mint(msg.sender, 1_000_000 * 10**18); // Минтим 1 млн токенов
    }
}
