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
        require(tokenA.balanceOf(msg.sender) >= amount, "Not enough Token A");
        uint256 amountB = amount * exchangeRate;

        tokenA.safeTransferFrom(msg.sender, address(this), amount);
        tokenB.safeTransfer(msg.sender, amountB);
    }

    /*
     * @notice Покупка токенов A за ETH.
     */
    function buyTokenA() public payable {
        uint256 amount = msg.value * exchangeRate; // Расчет количества токенов A за ETH
        tokenA.safeTransfer(msg.sender, amount);
    }
}