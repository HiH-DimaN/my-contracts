// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "./ERC721.sol";
import "./ERC721Enumerable.sol";
import "./ERC721URIStorage.sol";

/**
 * @title MyTokenERC721
 * @dev Контракт для создания токенов стандарта ERC721 с дополнительными функциями.
 * @author HiH_DimaN
 * Этот контракт объединяет функционал ERC721, ERC721Enumerable и ERC721URIStorage.
 */
contract MyTokenERC721 is ERC721, ERC721Enumerable, ERC721URIStorage {
    address public owner; // Переменная для хранения владельца контракта
    uint currentTokenId; // Переменная для отслеживания текущего токен-идентификатора

    /**
     * @dev Конструктор контракта. Устанавливает владельца и имя/символ токена.
     */
    constructor() ERC721("MyToken", "MTK") {
        owner = msg.sender; // Устанавливаем владельца контракта на адрес, который развернул контракт
    }

    /**
     * @dev Функция для безопасного минтинга токенов с привязкой URI.
     * @param to Адрес, на который будет переведен токен.
     * @param tokenId Строковый идентификатор токена (URI).
     */
    function safeMint(address to, string calldata tokenId) public {
        require(owner == msg.sender, "not an owner!"); // Проверяем, что вызывающий является владельцем контракта
        _safeMint(to, currentTokenId); // Безопасно минтим токен
        _setTokenURI(currentTokenId, tokenId); // Устанавливаем URI для токена
        currentTokenId++; // Увеличиваем текущий токен-идентификатор
    }

    /**
     * @dev Переопределение функции для поддержки интерфейсов ERC721 и ERC721Enumerable.
     * @param interfaceId Идентификатор интерфейса.
     * @return bool Возвращает true, если интерфейс поддерживается.
     */
    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId); // Вызываем родительский метод для проверки поддержки интерфейсов
    }

    /**
     * @dev Переопределение функции для базового URI.
     * @return string Базовый URI для токенов.
     */
    function _baseURI() internal pure override returns(string memory) {
        return "ipfs://"; // Возвращаем базовый URI, который будет использоваться для токенов
    }

    /**
     * @dev Переопределение функции _burn для корректного сжигания токенов.
     * @param tokenId Идентификатор токена, который нужно сжечь.
     */
    function _burn(uint tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId); // Вызываем родительские функции для сжигания токенов
    }

    /**
     * @dev Переопределение функции tokenURI для получения URI токена.
     * @param tokenId Идентификатор токена.
     * @return string Строка с URI токена.
     */
    function tokenURI(uint tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId); // Вызываем родительскую функцию для получения URI
    }

    /**
     * @dev Переопределение функции _beforeTokenTransfer для дополнительных действий при передаче токенов.
     * @param from Адрес отправителя.
     * @param to Адрес получателя.
     * @param tokenId Идентификатор токена.
     */
    function _beforeTokenTransfer(address from, address to, uint tokenId) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId); // Вызываем родительскую функцию для выполнения стандартных проверок
    }
}