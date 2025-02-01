// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Импортируем необходимые контракты из OpenZeppelin
import "@openzeppelin/contracts/token/ERC721/ERC721.sol"; // Базовый контракт ERC721
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol"; // Расширение для хранения URI
import "@openzeppelin/contracts/access/Ownable.sol"; // Контракт для управления правами доступа

/**
 * @title MyNFT
 * @dev Оптимизированный контракт для создания NFT с использованием стандарта ERC721.
 * Поддерживает минтинг токенов, установку URI и получение URI по ID токена.
 * Включает проверки безопасности и оптимизацию по газу.
 */
contract MyNFT is ERC721, ERC721URIStorage, Ownable {
    uint256 private _tokenIds; // Счетчик для генерации уникальных ID токенов (оптимизация по газу)

    /**
     * @dev Конструктор контракта.
     * Задает имя и символ токена.
     */
    constructor() ERC721("MyNFT", "MNFT") {} // Инициализируем контракт с именем "MyNFT" и символом "MNFT"

    /**
     * @dev Функция для минтинга нового токена с URI.
     * @param to Адрес получателя токена.
     * @param tokenURI URI, который будет привязан к токену.
     * @return newTokenId ID нового токена.
     */
    function mint(address to, string memory tokenURI) external onlyOwner returns (uint256) {
        require(to != address(0), "Invalid address"); // Проверка, что адрес получателя не нулевой
        require(bytes(tokenURI).length > 0, "URI cannot be empty"); // Проверка, что URI не пустой

        _tokenIds++; // Увеличиваем счетчик токенов (оптимизация по газу)
        uint256 newTokenId = _tokenIds; // Получаем текущее значение счетчика (ID нового токена)
        _mint(to, newTokenId); // Минтим токен и назначаем его адресу `to`
        _setTokenURI(newTokenId, tokenURI); // Устанавливаем URI для токена

        return newTokenId; // Возвращаем ID нового токена
    }

    /**
     * @dev Переопределяем функцию _burn для поддержки ERC721URIStorage.
     * @param tokenId ID токена, который будет сожжен.
     */
    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId); // Вызываем функцию _burn из ERC721 и ERC721URIStorage
    }

    /**
     * @dev Переопределяем функцию tokenURI для поддержки ERC721URIStorage.
     * @param tokenId ID токена, для которого запрашивается URI.
     * @return URI токена.
     */
    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId); // Возвращаем URI токена
    }

    /**
     * @dev Функция для получения общего количества токенов.
     * @return Общее количество заминтинных токенов.
     */
    function totalSupply() external view returns (uint256) {
        return _tokenIds; // Возвращаем текущее значение счетчика токенов
    }
}