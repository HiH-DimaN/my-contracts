// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title MyNFT
 * @dev ERC721 токен с расширением URIStorage, позволяющим хранить метаданные для каждого токена.
 */
contract MyNFT is ERC721URIStorage, Ownable {
    uint256 private _nextTokenId; // Переменная для отслеживания следующего tokenId

    /**
     * @dev Конструктор, устанавливающий имя и символ токена
     */
    constructor() ERC721("MyNFT", "MNFT") {}

    /**
     * @notice Минтит новый NFT с указанным URI
     * @dev Только владелец контракта может минтить токены
     * @param to Адрес получателя NFT
     * @param tokenURI URI метаданных токена
     */
    function mint(address to, string memory tokenURI) external onlyOwner {
        _safeMint(to, _nextTokenId); // Минтим токен
        _setTokenURI(_nextTokenId, tokenURI); // Устанавливаем URI метаданных
        _nextTokenId++; // Увеличиваем tokenId
    }

    /**
     * @notice Получает URI метаданных для конкретного токена
     * @dev Возвращает URI, привязанный к tokenId
     * @param tokenId Уникальный идентификатор токена
     * @return string URI, связанный с tokenId
     */
    function getTokenURI(uint256 tokenId) external view returns (string memory) {
        return tokenURI(tokenId); // Возвращает URI метаданных токена
    }
}