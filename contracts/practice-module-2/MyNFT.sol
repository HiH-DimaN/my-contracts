// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Импортируем необходимые контракты из OpenZeppelin
import "@openzeppelin/contracts/token/ERC721/ERC721.sol"; // Импортируем базовый контракт ERC721
import "@openzeppelin/contracts/utils/Counters.sol"; // Импортируем библиотеку Counters для управления ID токенов

/**
 * @title MyNFT
 * @dev Контракт для создания NFT с использованием стандарта ERC721.
 * Поддерживает минтинг токенов и хранение их URI.
 */
contract MyNFT is ERC721 {
    using Counters for Counters.Counter; // Используем библиотеку Counters для управления ID токенов
    Counters.Counter private _tokenIds; // Счетчик для генерации уникальных ID токенов

    /**
     * @dev Конструктор контракта.
     * Задает имя и символ токена.
     */
    constructor() ERC721("MyNFT", "MNFT") {} // Инициализируем контракт с именем "MyNFT" и символом "MNFT"

    /**
     * @dev Функция для минтинга нового токена.
     * @param to Адрес получателя токена.
     * @return newTokenId ID нового токена.
     */
    function mint(address to) public returns (uint256) {
        _tokenIds.increment(); // Увеличиваем счетчик токенов на 1
        uint256 newTokenId = _tokenIds.current(); // Получаем текущее значение счетчика (ID нового токена)
        _mint(to, newTokenId); // Минтим токен и назначаем его адресу `to`
        return newTokenId; // Возвращаем ID нового токена
    }

    /**
     * @dev Функция для минтинга первых 10 токенов.
     * @param to Адрес получателя токенов.
     */
    function mintFirst10Tokens(address to) public {
        require(_tokenIds.current() == 0, "First 10 tokens already minted"); // Проверяем, что токены еще не были заминтины
        for (uint256 i = 0; i < 10; i++) { // Цикл для минтинга 10 токенов
            mint(to); // Минтим токен и назначаем его адресу `to`
        }
    }

    /**
     * @dev Функция для получения общего количества токенов.
     * @return Общее количество заминтинных токенов.
     */
    function totalSupply() public view returns (uint256) {
        return _tokenIds.current(); // Возвращаем текущее значение счетчика токенов
    }
}