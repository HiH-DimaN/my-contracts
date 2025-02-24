// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

/**
 * @title Интерфейс IERC165
 * @dev Стандарт для проверки поддерживаемых интерфейсов в смарт-контрактах, как описано в EIP-165.
 * Это позволяет смарт-контрактам заявлять, какие интерфейсы они поддерживают.
 */
interface IERC165 {

    /**
     * @dev Функция для проверки, поддерживает ли смарт-контракт конкретный интерфейс.
     * @param interfaceId Идентификатор интерфейса, обычно вычисляется с помощью:
     * `bytes4(keccak256("functionName(...)"))`.
     * @return Возвращает `true`, если смарт-контракт поддерживает интерфейс с данным идентификатором.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool); // Проверка поддерживаемого интерфейса
}
