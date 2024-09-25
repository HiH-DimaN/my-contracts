
/* --- Пункт 2: Создать контракт токена на основе конструктора от OZ. 
* Сделать деплой, минт 1 млн токенов и сжигание 0.5 от общего количества. --- */

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Импортируем OpenZeppelin ERC20 и Ownable
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title MyOZToken
 * @dev Контракт токена на основе ERC20 от OpenZeppelin.
 * @notice При деплое автоматически выпускает 1 000 000 токенов для владельца 
 * и сжигает 50% от общего количества.
 */

contract MyOZToken is ERC20, Ownable {
    constructor() ERC20("My Custom Token", "MCT") Ownable() 
        // Выпуск 1 000 000 токенов владельцу контракта
        _mint(msg.sender, 1000000 * 10 ** decimals());

        // Сжигание 50% от общего количества токенов
        _burn(msg.sender, (1000000 * 10 ** decimals()) / 2);
    
}

