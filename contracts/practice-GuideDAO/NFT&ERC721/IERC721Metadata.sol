// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./IERC721.sol";

/**
 * @title Интерфейс ERC721Metadata
 * @dev Расширяет стандарт ERC721 для добавления метаданных токенов.
 * Позволяет получать информацию о токенах, такую как имя, символ и URI токена.
 */
interface IERC721Metadata is IERC721 {

    /** 
     * @dev Функция для получения имени токенов.
     * @return Имя токенов в контракте.
     */
    function name() external view returns(string memory); // Получить имя токенов

    /** 
     * @dev Функция для получения символа токенов.
     * @return Символ токенов в контракте.
     */
    function symbol() external view returns(string memory); // Получить символ токенов

    /** 
     * @dev Функция для получения URI для конкретного токена.
     * @param tokenId Идентификатор токена.
     * @return URI, содержащий метаданные токена.
     */
    function tokenURI(uint tokenId) external view returns(string memory); // Получить URI токена
}
