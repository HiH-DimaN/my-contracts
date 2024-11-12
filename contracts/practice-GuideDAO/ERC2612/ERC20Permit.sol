// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./IERC20Permit.sol";
import "./ERC20.sol";
import "./utils/Counters.sol";
import "./crypto/ECDSA.sol";
import "./crypto/EIP712.sol";

/**
 * @title ERC20Permit
 * @dev Реализация интерфейса ERC20Permit для токенов ERC20 с поддержкой разрешений (permit).
 * Позволяет подписывать транзакции вне блокчейна для разрешения операций.
 */
abstract contract ERC20Permit is ERC20, IERC20Permit, EIP712 {
    using Counters for Counters.Counter; // Используем библиотеку Counters для управления счетчиками.

    // Хранит nonce для каждого адреса (необходим для защиты от повторных транзакций).
    mapping(address => Counters.Counter) private _nonces;

    // Хэш типа данных для функции permit.
    bytes32 private constant _PERMIT_TYPEHASH = keccak256(
        "Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"
    );

    /**
     * @dev Конструктор контракта, инициализирует EIP712 с именем токена.
     * @param name Имя токена.
     */
    constructor(string memory name) EIP712(name, "1") {}

    /**
     * @notice Разрешает `spender` тратить токены от имени `owner` через подпись.
     * @param owner Адрес владельца токенов.
     * @param spender Адрес, которому разрешено тратить токены.
     * @param value Количество токенов для разрешения.
     * @param deadline Временная метка, до которой разрешение действительно.
     * @param v Параметр подписи (v).
     * @param r Параметр подписи (r).
     * @param s Параметр подписи (s).
     */
    function permit(
        address owner,
        address spender,
        uint value,
        uint deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external virtual {
        require(block.timestamp <= deadline, "expired"); // Проверяем, что срок действия не истек.

        // Формируем хэш структуры permit.
        bytes32 structHash = keccak256(
            abi.encode(
                _PERMIT_TYPEHASH,
                owner,
                spender,
                value,
                _useNonce(owner), // Используем и увеличиваем nonce.
                deadline
            )
        );

        // Получаем хэш с использованием EIP712.
        bytes32 hash = _hashTypedDataV4(structHash);

        // Восстанавливаем адрес владельца из подписи.
        address signer = ECDSA.recover(hash, v, r, s);

        require(signer == owner, "not an owner"); // Проверка, что подпись принадлежит владельцу.

        _approve(owner, spender, value); // Вызываем внутреннюю функцию для установки разрешения.
    }

    /**
     * @notice Возвращает текущий nonce для указанного адреса.
     * @param owner Адрес, для которого нужно получить nonce.
     * @return Текущий nonce.
     */
    function nonces(address owner) external view returns(uint) {
        return _nonces[owner].current(); // Возвращаем текущее значение nonce.
    }

    /**
     * @notice Возвращает доменный разделитель EIP712.
     * @return Доменный разделитель.
     */
    function DOMAIN_SEPARATOR() external view returns(bytes32) {
        return _domainSeparatorV4(); // Возвращаем доменный разделитель для использования в подписи.
    }

    /**
     * @dev Внутренняя функция для использования и увеличения nonce.
     * @param owner Адрес, для которого используется nonce.
     * @return current Текущее значение nonce перед инкрементом.
     */
    function _useNonce(address owner) internal virtual returns(uint current) {
        Counters.Counter storage nonce = _nonces[owner]; // Получаем ссылку на счетчик nonce.

        current = nonce.current(); // Сохраняем текущее значение.

        nonce.increment(); // Увеличиваем значение счетчика.
    }
}
