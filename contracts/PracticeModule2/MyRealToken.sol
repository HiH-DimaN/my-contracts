// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title MyRealToken
 * @dev Контракт вашего реального токена, наследующийся от MyERC20 и Ownable.
 * Этот контракт добавляет функции для выпуска (mint) и сжигания (burn) токенов, 
 * которые доступны только владельцу контракта.
 */
contract MyRealToken is MyERC20 {
    /**
     * @dev Конструктор для инициализации токена MyRealToken.
     * @param name_ Название токена.
     * @param symbol_ Символ токена.
     * @param decimals_ Количество знаков после запятой.
     */
    constructor(string memory name_, string memory symbol_, uint8 decimals_) 
        MyERC20(name_, symbol_, decimals_) 
    {}

    /**
     * @dev Функция для выпуска новых токенов. 
     * Доступна только владельцу контракта.
     *
     * @param to Адрес, на который будут зачислены новые токены.
     * @param amount Количество выпускаемых токенов.
     */
    function _mint(address to, uint32 amount) public onlyOwner {
        _mint(to, amount);
    }

    /**
     * @dev Функция для сжигания токенов. 
     * Доступна только владельцу контракта.
     *
     * @param from Адрес, с которого будут сожжены токены.
     * @param amount Количество сжигаемых токенов.
     * 
     * Требования:
     * - Сжигание токенов должно быть разрешено.
     */
    function burn(address from, uint256 amount) public onlyOwner whenBurningEnabled {
        _burn(from, amount);
    }

}