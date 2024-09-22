
/* --- Пункт 2: Создать контракт токена на основе конструктора от OZ. 
* Сделать деплой, минт 1 млн токенов и сжигание 0.5 от общего количества. --- */

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title MyOZToken
 * @dev Контракт токена на основе ERC20 от OpenZeppelin.
 * @notice При деплое автоматически выпускает 1 000 000 токенов для владельца 
 * и сжигает 50% от общего количества.
 */
contract MyOZToken is ERC20, Ownable {

    /**
     * @dev Конструктор для инициализации токена MyOZToken.
     * @param name_ Название токена.
     * @param symbol_ Символ токена.
     */
    constructor(string memory name_, string memory symbol_) ERC20(name_, symbol_) {
        _mint(msg.sender, 1_000_000 * 10 ** decimals()); // Минт 1 миллиона токенов для владельца
        _burn(msg.sender, totalSupply() / 2);  // Сжигание 50% токенов владельца
    }
}