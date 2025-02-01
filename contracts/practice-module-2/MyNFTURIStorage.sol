// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

/**
 * @title MyNFT
 * @dev Контракт ERC721 для выпуска NFT с индивидуальными URI.
 */
contract MyNFT is ERC721URIStorage {
    uint256 private _nextTokenId; // Переменная для хранения следующего ID токена

    /**
     * @dev Конструктор контракта, задающий имя и символ токена.
     */
    constructor() ERC721("MyNFT", "MNFT") {}

    /**
     * @notice Минтит новый NFT и устанавливает URI.
     * @param to Адрес получателя NFT.
     * @param uri Ссылка на метаданные токена.
     * @return tokenId ID созданного токена.
     */
    function mint(address to, string memory uri) external returns (uint256) {
        uint256 tokenId = _nextTokenId++; // Генерируем новый токен ID
        _safeMint(to, tokenId); // Безопасно минтим токен
        _setTokenURI(tokenId, uri); // Устанавливаем URI для токена
        return tokenId; // Возвращаем ID нового токена
    }

    /**
     * @notice Получает URI метаданных для указанного токена.
     * @param tokenId ID токена.
     * @return string URI метаданных токена.
     */
    function getTokenURI(uint256 tokenId) external view returns (string memory) {
        return tokenURI(tokenId); // Возвращает сохраненный URI
    }
}