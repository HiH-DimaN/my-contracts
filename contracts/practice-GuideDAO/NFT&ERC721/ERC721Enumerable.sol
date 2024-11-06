// SPDX-License-Identifier: MIT // Лицензия контракта

pragma solidity ^0.8.20; // Установка версии компилятора Solidity

import "./ERC721.sol"; // Импорт контракта ERC721 для базовой реализации стандарта ERC721
import "./IERC721Enumerable.sol"; // Импорт интерфейса IERC721Enumerable для работы с перечислением токенов

/**
 * @title ERC721Enumerable
 * @dev Реализация расширенной версии ERC721 с возможностью перечисления токенов.
 * @author HiH_DimaN
 * Контракт добавляет функционал для работы с перечислением всех токенов и токенов, принадлежащих конкретному владельцу.
 */
abstract contract ERC721Enumerable is ERC721, IERC721Enumerable {
    uint[] private _allTokens; // Массив для хранения всех токенов
    mapping(address => mapping(uint => uint)) private _ownedTokens; // Сопоставление адреса владельца с его токенами
    mapping(uint => uint) private _allTokensIndex; // Индексы всех токенов в массиве _allTokens
    mapping(uint => uint) private _ownedTokensIndex; // Индексы токенов владельцев в массиве _ownedTokens

    /**
     * @dev Возвращает общее количество токенов, находящихся в обращении.
     * @return Количество всех токенов.
     */
    function totalSupply() public view returns(uint) {
        return _allTokens.length; // Возвращает количество всех токенов
    }

    /**
     * @dev Возвращает токен по его индексу.
     * @param index Индекс токена в массиве _allTokens.
     * @return ID токена.
     */
    function tokenByIndex(uint index) public view returns(uint) {
        require(index < totalSupply(), "out of bounds"); // Проверка на выход за пределы диапазона
        return _allTokens[index]; // Возвращает ID токена по индексу
    }

    /**
     * @dev Возвращает токен по индексу владельца.
     * @param owner Адрес владельца токенов.
     * @param index Индекс токена в массиве владельца.
     * @return ID токена владельца.
     */
    function tokenOfOwnerByIndex(address owner, uint index) public view returns(uint) {
        require(index < balanceOf(owner), "out of bounds"); // Проверка на выход за пределы диапазона для владельца
        return _ownedTokens[owner][index]; // Возвращает токен владельца по индексу
    }

    /**
     * @dev Проверка поддерживаемых интерфейсов.
     * @param interfaceId Идентификатор интерфейса для проверки.
     * @return true, если интерфейс поддерживается, иначе false.
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721) returns(bool) {
        return interfaceId == type(IERC721Enumerable).interfaceId || // Проверка поддерживаемого интерфейса IERC721Enumerable
            super.supportsInterface(interfaceId); // Вызов метода из родительского контракта для других интерфейсов
    }

    /**
     * @dev Хук, вызываемый перед каждым переводом токенов. Модифицируется для работы с перечислением токенов.
     * @param from Адрес отправителя.
     * @param to Адрес получателя.
     * @param tokenId ID токена для перевода.
     */
    function _beforeTokenTransfer(address from, address to, uint tokenId) internal virtual override {
        super._beforeTokenTransfer(from, to, tokenId); // Вызов хука из родительского контракта
        if(from == address(0)) {
            _addTokenToAllTokensEnumeration(tokenId); // Добавление токена в массив всех токенов при его создании
        } else if(from != to) {
            _removeTokenFromOwnerEnumeration(from, tokenId); // Удаление токена из массива владельца при передаче
        }
        if(to == address(0)) {
            _removeTokenFromAllTokensEnumeration(tokenId); // Удаление токена из массива всех токенов при сжигании
        } else if(to != from) {
            _addTokenToOwnerEnumeration(to, tokenId); // Добавление токена в массив нового владельца
        }
    }

    /**
     * @dev Добавляет токен в массив всех токенов.
     * @param tokenId ID добавляемого токена.
     */
    function _addTokenToAllTokensEnumeration(uint tokenId) private {
        _allTokensIndex[tokenId] = _allTokens.length; // Устанавливает индекс для нового токена
        _allTokens.push(tokenId); // Добавляет токен в массив всех токенов
    }

    /**
     * @dev Удаляет токен из массива всех токенов.
     * @param tokenId ID удаляемого токена.
     */
    function _removeTokenFromAllTokensEnumeration(uint tokenId) private {
        uint lastTokenIndex = _allTokens.length - 1; // Индекс последнего токена в массиве
        uint tokenIndex = _allTokensIndex[tokenId]; // Индекс токена, который нужно удалить
        uint lastTokenId = _allTokens[lastTokenIndex]; // ID последнего токена
        _allTokens[tokenIndex] = lastTokenId; // Перемещает последний токен на место удаляемого
        _allTokensIndex[lastTokenId] = tokenIndex; // Обновляет индекс для последнего токена
        delete _allTokensIndex[tokenId]; // Удаляет индекс для удаляемого токена
        _allTokens.pop(); // Удаляет последний элемент из массива
    }

    /**
     * @dev Добавляет токен в массив токенов владельца.
     * @param to Адрес нового владельца.
     * @param tokenId ID добавляемого токена.
     */
    function _addTokenToOwnerEnumeration(address to, uint tokenId) private {
        uint _length = balanceOf(to); // Получаем текущий баланс владельца
        _ownedTokensIndex[tokenId] = _length; // Устанавливаем индекс для нового токена у владельца
        _ownedTokens[to][_length] = tokenId; // Добавляем токен в массив владельца
    }

    /**
     * @dev Удаляет токен из массива токенов владельца.
     * @param from Адрес старого владельца.
     * @param tokenId ID удаляемого токена.
     */
    function _removeTokenFromOwnerEnumeration(address from, uint tokenId) private {
        uint lastTokenIndex = balanceOf(from) - 1; // Индекс последнего токена владельца
        uint tokenIndex = _ownedTokensIndex[tokenId]; // Индекс токена, который нужно удалить
        if(tokenIndex != lastTokenIndex) {
            uint lastTokenId = _ownedTokens[from][lastTokenIndex]; // ID последнего токена
            _ownedTokens[from][tokenIndex] = lastTokenId; // Перемещает последний токен на место удаляемого
            _ownedTokensIndex[lastTokenId] = tokenIndex; // Обновляет индекс для последнего токена
        }
        delete _ownedTokensIndex[tokenId]; // Удаляет индекс для удаляемого токена
        delete _ownedTokens[from][lastTokenIndex]; // Удаляет токен из массива владельца
    }
}
