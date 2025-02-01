// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title MyNFT
 * @dev Контракт ERC721 с расширением Enumerable, автоматически минтящий 10 токенов при развертывании
 */
contract MyNFT is ERC721Enumerable, Ownable {
    uint256 private _nextTokenId; // Переменная для отслеживания следующего доступного tokenId

    /**
     * @dev Конструктор, устанавливающий имя и символ токена, а также вызывающий функцию начального минтинга
     */
    constructor() ERC721("MyNFT", "MNFT") {
        _mintInitialTokens(); // Минтит первые 10 NFT при деплое контракта
    }

    /**
     * @dev Функция для начального минтинга 10 токенов владельцу контракта
     */
    function _mintInitialTokens() internal {
        for (uint256 i = 0; i < 10; i++) {
            _safeMint(msg.sender, _nextTokenId); // Безопасный минт токена текущему владельцу
            _nextTokenId++; // Увеличиваем счетчик tokenId
        }
    }

    /**
     * @notice Минт нового NFT только владельцем контракта
     * @dev Минтится один токен и отправляется владельцу контракта
     */
    function mint() external onlyOwner {
        _safeMint(msg.sender, _nextTokenId); // Минтим новый NFT
        _nextTokenId++; // Увеличиваем счетчик tokenId
    }
}