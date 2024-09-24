
/* --- Пункт 2: Создать контракт токена на основе задания 1, сделать деплой и минт 1_000_000 токенов. --- */

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./MyERC20.sol";

/**
 * @title MyToken
 * @dev Контракт токена на основе MyERC20.
 * @notice При деплое автоматически выпускает 1 000 000 токенов для владельца.
 */
contract MyToken is MyERC20 {

    /**
     * @dev Конструктор для инициализации токена MyToken.
     * @param name_ Название токена.
     * @param symbol_ Символ токена.
     * @param decimals_ Количество знаков после запятой.
     */
    constructor(string memory name_, string memory symbol_, uint8 decimals_) 
        MyERC20(name_, symbol_, decimals_) 
    {
        _mint(msg.sender, 1_000_000 * 10 ** decimals_); // Минт 1 миллиона токенов для владельца
    }
}