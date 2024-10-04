// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

/*
 * @title TokenExchange
 * @dev Контракт для обмена токенов A и B, а также покупки токена A за ETH.
 */
contract TokenExchange {
    using SafeERC20 for IERC20;

    IERC20 public tokenA;
    IERC20 public tokenB;
    uint256 public exchangeRate; // Коэффициент обмена токенов

    /*
     * @notice Конструктор контракта.
     * @param _tokenA Адрес контракта токена A.
     * @param _tokenB Адрес контракта токена B.
     */
    constructor(address _tokenA, address _tokenB) {
        tokenA = IERC20(_tokenA);
        tokenB = IERC20(_tokenB);
        exchangeRate = 100; // Например, 1 токен A = 100 токенов B
    }

    /*
     * @notice Обмен токенов A на токены B.
     * @param amount Количество токенов A для обмена.
     */
    function swapAToB(uint256 amount) public {
        // Проверяем, что у пользователя достаточно токенов A для обмена.
        require(tokenA.balanceOf(msg.sender) >= amount, "Not enough Token A");

        // Вычисляем количество токенов B, которые получит пользователь.
        uint256 amountB = amount * exchangeRate;

        // Переносим токены A от пользователя на контракт.
        tokenA.safeTransferFrom(msg.sender, address(this), amount);

        // Отправляем пользователю соответствующее количество токенов B.
        tokenB.safeTransfer(msg.sender, amountB);
    }

    /*
     * @notice Обмен токенов B на токены A.
     * @param amount Количество токенов B для обмена.
     */
    function swapBToA(uint256 amount) public {
        // Проверяем, что у пользователя достаточно токенов B для обмена.
        require(tokenB.balanceOf(msg.sender) >= amount, "Not enough Token B");

        // Вычисляем количество токенов A, которые получит пользователь.
        // При обратном обмене делаем деление, а не умножение.
        uint256 amountA = amount / exchangeRate;

        // Переносим токены B от пользователя на контракт.
        tokenB.safeTransferFrom(msg.sender, address(this), amount);

        // Отправляем пользователю соответствующее количество токенов A.
        tokenA.safeTransfer(msg.sender, amountA);
    }

    /*
     * @notice Покупка токенов A за ETH.
     */
    function buyTokenA() public payable {
        // Рассчитываем количество токенов A, которое пользователь получит за отправленный ETH.
        uint256 amount = msg.value * exchangeRate;

        // Переводим пользователю соответствующее количество токенов A.
        tokenA.safeTransfer(msg.sender, amount);
    }
}
