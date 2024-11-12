// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./ERC20.sol"; // Импорт базового контракта ERC20.
import "./ERC20Permit.sol"; // Импорт контракта ERC20Permit для поддержки EIP-2612 (permit-функциональность).

/**
 * @title MyToken
 * @dev Контракт токена, наследуемый от ERC20 и ERC20Permit. Включает функциональность с подписями и возможность выпуска новых токенов владельцем.
 */
contract MyToken is ERC20, ERC20Permit {
    // Адрес владельца контракта.
    address private owner;

    // Модификатор для ограничения доступа к функциям только для владельца.
    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner"); // Проверка, что вызов функции производится владельцем.
        _;
    }

    /**
     * @dev Конструктор контракта, вызывается при развертывании.
     * Устанавливает владельца, инициализирует контракт ERC20 и ERC20Permit и выпускает начальный объем токенов.
     */
    constructor() ERC20("MyToken", "MTK") ERC20Permit("MyToken") {
        owner = msg.sender; // Устанавливаем владельца контракта.
        _mint(msg.sender, 100 * 10 ** decimals()); // Выпускаем 100 токенов с учетом десятичных разрядов.
    }

    /**
     * @dev Функция выпуска новых токенов, доступна только владельцу.
     * @param to Адрес получателя токенов.
     * @param amount Количество токенов для выпуска.
     */
    function mint(address to, uint amount) public onlyOwner {
        _mint(to, amount); // Вызываем внутреннюю функцию _mint для выпуска токенов.
    }
}
