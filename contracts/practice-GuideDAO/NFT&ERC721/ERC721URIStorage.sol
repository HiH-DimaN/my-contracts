// SPDX-License-Identifier: MIT // Лицензия контракта

pragma solidity ^0.8.20; // Установка версии компилятора Solidity

import "./ERC721.sol"; // Импорт контракта ERC721 для базовой реализации стандарта ERC721

/**
 * @title ERC721URIStorage
 * @dev Контракт расширяет ERC721 для хранения URI метаданных токенов.
 * @author HiH_DimaN
 * Этот контракт позволяет каждому токену иметь уникальный URI для метаданных и управлять его URI.
 */
abstract contract ERC721URIStorage is ERC721 {
    // Хранение URI для каждого токена
    mapping(uint => string) private _tokenURIs;

    /**
     * @dev Возвращает URI метаданных для указанного токена.
     * @param tokenId ID токена для которого требуется URI.
     * @return URI метаданных для токена.
     */
    function tokenURI(uint tokenId) public view virtual override _requireMinted(tokenId) returns(string memory) {
        string memory _tokenURI = _tokenURIs[tokenId]; // Получаем URI токена из маппинга
        string memory base = _baseURI(); // Получаем базовый URI для контракта
        if(bytes(base).length == 0) { // Если базовый URI не задан
            return _tokenURI; // Возвращаем только URI, привязанный к токену
        }
        if(bytes(_tokenURI).length > 0) { // Если URI для токена задан
            return string(abi.encodePacked(base, _tokenURI)); // Возвращаем полный URI, комбинируя базовый URI и URI токена
        }
        return super.tokenURI(tokenId); // Если URI токена не задан, используем стандартный метод из контракта ERC721
    }

    /**
     * @dev Устанавливает URI метаданных для конкретного токена.
     * @param tokenId ID токена, для которого устанавливается URI.
     * @param _tokenURI Новый URI метаданных для токена.
     */
    function _setTokenURI(uint tokenId, string memory _tokenURI) internal virtual _requireMinted(tokenId) {
        _tokenURIs[tokenId] = _tokenURI; // Устанавливаем URI для токена в маппинг
    }

    /**
     * @dev Переопределяет функцию _burn для удаления URI при сжигании токена.
     * @param tokenId ID токена, который будет сожжен.
     */
    function _burn(uint tokenId) internal virtual override {
        super._burn(tokenId); // Вызов метода _burn из родительского контракта
        if(bytes(_tokenURIs[tokenId]).length != 0) { // Проверка, если URI для токена существует
            delete _tokenURIs[tokenId]; // Удаление URI токена после его сжигания
        }
    }
}
