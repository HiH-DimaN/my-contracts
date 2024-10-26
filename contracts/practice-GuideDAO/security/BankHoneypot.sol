//SPDX-License-Identifier:MIT

pragma solidity ^0.8.20;

/**
 * @title BankHoneypot
 * @author HiH_DimaN
 * @notice Контракт, представляющий собой "медовый горшок" (honeypot) для сбора средств.
 */
contract BankHoneypot {
    /**
     * @dev Ссылка на контракт ILogger.
     */
    ILogger private logger; // Ссылка на контракт ILogger

    /**
     * @dev Отображение балансов пользователей.
     */
    mapping(address => uint) private _balances; // Отображение балансов пользователей

    /**
     * @dev Конструктор контракта.
     * @param _logger Адрес контракта ILogger.
     */
    constructor(address _logger) {
        logger = ILogger(_logger); // Инициализация ссылки на контракт ILogger
    }

    /**
     * @dev Функция для пополнения баланса.
     */
    function deposit() external payable {
        _balances[msg.sender] += msg.value; // Пополняем баланс отправителя
        logger.log(msg.sender, 1); // Логируем событие пополнения баланса
    }

    /**
     * @dev Функция для вывода средств.
     * @param amount Сумма для вывода.
     */
    function withdraw(uint amount) external {
        _balances[msg.sender] -= amount; // Вычитаем сумму из баланса отправителя
        (bool succes, ) = msg.sender.call{value: amount}(""); // Отправляем средства отправителю
        require(succes); // Проверяем успешность отправки

        logger.log(msg.sender, 2); // Логируем событие вывода средств
    }

}

/**
 * @title ILogger
 * @author HiH_DimaN
 * @notice Интерфейс для логирования событий.
 */
interface ILogger {
    event Log(address indexed initiator, uint indexed eventCode);

    function log(address initiator, uint eventCode) external;
}

/**
 * @title Logger
 * @author HiH_DimaN
 * @notice Контракт, реализующий интерфейс ILogger для логирования событий.
 */
contract Logger is ILogger {
    /**
     * @dev Функция для записи события в лог.
     * @param initiator Адрес инициатора события.
     * @param eventCode Код события.
     */
    function log(address initiator, uint eventCode) external {
       emit Log(initiator, eventCode); 
    }
}

/**
 * @title Honeypot
 * @author HiH_DimaN
 * @notice Контракт, который имитирует "медовый горшок" (honeypot) и вызывает ошибку при выводе средств.
 */
contract Honeypot {
    /**
     * @dev Функция для логирования событий.
     * @param initiator Адрес инициатора события.
     * @param eventCode Код события.
     */
    function log(address initiator, uint eventCode) external {
       if(eventCode == 2) {
        revert("honeypotted!"); // Вызываем ошибку, если код события равен 2
       } 
    }
}