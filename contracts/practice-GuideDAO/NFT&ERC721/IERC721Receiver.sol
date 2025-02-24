// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title Интерфейс для получения токенов ERC721
 * @dev Этот интерфейс используется для обработки полученных токенов ERC721.
 * Контракты, принимающие токены ERC721, должны реализовать этот интерфейс для обработки входящих переводов.
 */
interface IERC721Receiver {

    /**
     * @dev Функция, вызываемая при получении токена ERC721.
     * @param operator Адрес, который инициирует передачу токена (например, адрес вызывающего контракта).
     * @param from Адрес отправителя токена.
     * @param tokenId Идентификатор токена, который был передан.
     * @param data Дополнительные данные, переданные с транзакцией (необязательные).
     * @return bytes4 Стандартный код возврата для подтверждения, что контракт успешно принял токен.
     * @notice Этот метод должен возвращать селектор `onERC721Received` для подтверждения успешного получения.
     */
    function onERC721Received(
        address operator,
        address from,
        uint tokenId,
        bytes calldata data
    ) external returns(bytes4); // Метод для обработки получения токена ERC721
}
