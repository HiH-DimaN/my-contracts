// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./ERC165.sol"; // Импорт контракта для поддержки интерфейсов ERC165
import "./IERC721.sol"; // Интерфейс для стандартных операций с токенами ERC721
import "./IERC721Metadata.sol"; // Интерфейс для получения метаданных токенов ERC721
import "./Strings.sol"; // Библиотека для работы с числами как со строками
import "./IERC721Receiver.sol"; // Интерфейс для обработки безопасных перевоодов

/**
 * @title ERC721 Token
 * @dev Реализация стандарта ERC721 с поддержкой метаданных и безопасных переводов
 */
contract ERC721 is ERC165, IERC721, IERC721Metadata {
    using Strings for uint; // Подключение библиотеки для работы с числами как со строками

    string private _name; // Имя токенов
    string private _symbol; // Символ токенов

    // Маппинги для хранения данных о токенах и владельцах
    mapping(address => uint) private _balances; // Баланс каждого владельца
    mapping(uint => address) private _owners; // Владелец каждого токена
    mapping(uint => address) private _tokenApprovals; // Разрешенные адреса для передачи токенов
    mapping(address => mapping(address => bool)) private _operatorApprovals; // Разрешения для операторов

    /**
     * @dev Эмиттируется при передаче токена от одного адреса к другому.
     * @param from Адрес, с которого отправляется токен.
     * @param to Адрес, на который отправляется токен.
     * @param tokenId Идентификатор передаваемого токена.
     */
    event Transfer(address indexed from, address indexed to, uint indexed tokenId);

    /**
     * @dev Эмиттируется при утверждении другого адреса на управление конкретным токеном.
     * @param owner Адрес владельца токена.
     * @param approved Адрес, которому предоставлено разрешение на управление токеном.
     * @param tokenId Идентификатор токена, для которого было выдано разрешение.
     */
    event Approval(address indexed owner, address indexed approved, uint indexed tokenId);

    /**
     * @dev Эмиттируется при утверждении оператора, который может управлять всеми токенами владельца.
     * @param owner Адрес владельца всех токенов.
     * @param operator Адрес оператора, которому предоставлено разрешение на управление всеми токенами владельца.
     * @param approved Флаг, показывающий, разрешено ли оператору управлять всеми токенами владельца.
     */
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);
}

    /**
     * @dev Модификатор, который проверяет, что токен существует.
     * @param tokenId Идентификатор токена
     */
    modifier _requireMinted(uint tokenId) {
        require(_exists(tokenId), "ERC721: query for nonexistent token"); // Проверка существования токена
        _;
    }

    /**
     * @dev Конструктор для инициализации контракта с именем и символом
     * @param name_ Имя токенов
     * @param symbol_ Символ токенов
     */
    constructor(string memory name_, string memory symbol_) {
        _name = name_; // Инициализация имени токенов
        _symbol = symbol_; // Инициализация символа токенов
    }

    /**
     * @dev Функция для перевода токена от одного владельца к другому.
     * @param from Адрес отправителя
     * @param to Адрес получателя
     * @param tokenId Идентификатор токена
     */
    function transferFrom(address from, address to, uint tokenId) external {
        require(_isApprovedOrOwner(msg.sender, tokenId), "ERC721: caller is not owner nor approved"); // Проверка прав на токен
        _transfer(from, to, tokenId); // Перевод токена
    }

    /**
     * @dev Функция для безопасного перевода токенов с дополнительными данными.
     * @param from Адрес отправителя
     * @param to Адрес получателя
     * @param tokenId Идентификатор токена
     * @param data Дополнительные данные
     */
    function safeTransferFrom(
        address from,
        address to,
        uint tokenId,
        bytes memory data
    ) public {
        require(_isApprovedOrOwner(msg.sender, tokenId), "ERC721: caller is not owner nor approved"); // Проверка прав на токен
        _safeTransfer(from, to, tokenId, data); // Безопасный перевод с проверкой
    }

    /**
     * @dev Функция для получения имени токенов.
     * @return Имя токенов
     */
    function name() external view returns(string memory) {
        return _name; // Возвращение имени токенов
    }

    /**
     * @dev Функция для получения символа токенов.
     * @return Символ токенов
     */
    function symbol() external view returns(string memory) {
        return _symbol; // Возвращение символа токенов
    }

    /**
     * @dev Функция для получения баланса токенов у владельца.
     * @param owner Адрес владельца
     * @return Количество токенов у владельца
     */
    function balanceOf(address owner) public view returns(uint) {
        require(owner != address(0), "ERC721: balance query for the zero address"); // Проверка, что адрес не является нулевым
        return _balances[owner]; // Возвращение баланса владельца
    }

    /**
     * @dev Функция для получения владельца токена.
     * @param tokenId Идентификатор токена
     * @return Адрес владельца токена
     */
    function ownerOf(uint tokenId) public view _requireMinted(tokenId) returns(address) {
        return _owners[tokenId]; // Возвращение владельца токена
    }

    /**
     * @dev Функция для одобрения перевода токена другому адресу.
     * @param to Адрес получателя
     * @param tokenId Идентификатор токена
     */
    function approve(address to, uint tokenId) public {
        address owner = ownerOf(tokenId); // Получение владельца токена
        require(owner == msg.sender || isApprovedForAll(owner, msg.sender), "ERC721: approve caller is not owner nor approved for all"); // Проверка прав на одобрение
        require(to != owner, "ERC721: approval to current owner"); // Проверка, что адрес получателя не является владельцем
        _tokenApprovals[tokenId] = to; // Установка разрешения
        emit Approval(owner, to, tokenId); // Событие об одобрении
    }

    /**
     * @dev Функция для разрешения оператору управлять всеми токенами владельца.
     * @param operator Адрес оператора
     * @param approved Разрешение на управление
     */
    function setApprovalForAll(address operator, bool approved) public {
        require(msg.sender != operator, "ERC721: approve to caller"); // Проверка, что оператор не является вызывающим
        _operatorApprovals[msg.sender][operator] = approved; // Установка разрешения для оператора
        emit ApprovalForAll(msg.sender, operator, approved); // Событие об одобрении для оператора
    }

    /**
     * @dev Функция для получения разрешенного адреса для передачи токена.
     * @param tokenId Идентификатор токена
     * @return Адрес, которому разрешен перевод токена
     */
    function getApproved(uint tokenId) public view _requireMinted(tokenId) returns(address) {
        return _tokenApprovals[tokenId]; // Возвращение адреса с разрешением на передачу токена
    }

    /**
     * @dev Функция для проверки разрешений оператора для управления всеми токенами владельца.
     * @param owner Адрес владельца
     * @param operator Адрес оператора
     * @return true, если оператор имеет разрешение
     */
    function isApprovedForAll(address owner, address operator) public view returns(bool) {
        return _operatorApprovals[owner][operator]; // Проверка разрешений оператора для всех токенов владельца
    }

    /**
     * @dev Функция для проверки поддержки интерфейсов.
     * @param interfaceId Идентификатор интерфейса
     * @return true, если интерфейс поддерживается
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override returns(bool) {
        return interfaceId == type(IERC721).interfaceId || 
            interfaceId == type(IERC721Metadata).interfaceId || 
            super.supportsInterface(interfaceId); // Проверка поддержки интерфейсов
    }

    /**
     * @dev Вспомогательная функция для безопасного минтинга токенов.
     * @param to Адрес владельца
     * @param tokenId Идентификатор токена
     */
    function _safeMint(address to, uint tokenId) internal virtual {
        _safeMint(to, tokenId, ""); // Безопасный минтинг без дополнительных данных
    }

    /**
     * @dev Вспомогательная функция для безопасного минтинга токенов с дополнительными данными.
     * @param to Адрес владельца
     * @param tokenId Идентификатор токена
     * @param data Дополнительные данные
     */
    function _safeMint(address to, uint tokenId, bytes memory data) internal virtual {
        _mint(to, tokenId); // Минтинг токена
        require(_checkOnERC721Received(address(0), to, tokenId, data), "ERC721: transfer to non ERC721Receiver implementer"); // Проверка получения токена
    }

    /**
     * @dev Вспомогательная функция для минтинга токенов.
     * @param to Адрес владельца
     * @param tokenId Идентификатор токена
     */
    function _mint(address to, uint tokenId) internal virtual {
        require(to != address(0), "ERC721: mint to the zero address"); // Проверка на нулевой адрес
        require(!_exists(tokenId), "ERC721: token already minted"); // Проверка, что токен не существует
        _beforeTokenTransfer(address(0), to, tokenId); // Хук перед минтингом
        _balances[to]++; // Увеличение баланса владельца
        _owners[tokenId] = to; // Установка владельца токена
        emit Transfer(address(0), to, tokenId); // Событие минтинга
        _afterTokenTransfer(address(0), to, tokenId); // Хук после минтинга
    }

    /**
     * @dev Вспомогательная функция для получения базового URI.
     * @return Базовый URI
     */
    function _baseURI() internal view virtual returns (string memory) {
        return ""; // Возвращение базового URI
    }

    /**
     * @dev Вспомогательная функция для проверки существования токена.
     * @param tokenId Идентификатор токена
     * @return true, если токен существует
     */
    function _exists(uint tokenId) internal view returns(bool) {
        return _owners[tokenId] != address(0); // Проверка существования токена
    }

    /**
     * @dev Функция для проверки прав на токен.
     * @param spender Адрес проверяющего
     * @param tokenId Идентификатор токена
     * @return true, если есть право на токен
     */
    function _isApprovedOrOwner(address spender, uint tokenId) internal view returns(bool) {
        address owner = ownerOf(tokenId); // Получение владельца токена
        return (spender == owner || 
            getApproved(tokenId) == spender || 
            isApprovedForAll(owner, spender)); // Проверка прав на токен
    }

    /**
     * @dev Функция для безопасного перевода токенов с проверкой на поддерживающий интерфейс.
     * @param from Адрес отправителя
     * @param to Адрес получателя
     * @param tokenId Идентификатор токена
     * @param data Дополнительные данные
     */
    function _safeTransfer(address from, address to, uint tokenId, bytes memory data) internal {
        _transfer(from, to, tokenId); // Выполнение перевода
        require(_checkOnERC721Received(from, to, tokenId, data), "ERC721: transfer to non-erc721 receiver"); // Проверка поддержки интерфейса ERC721
    }

    /**
     * @dev Вспомогательная функция для проверки, поддерживает ли получатель интерфейс ERC721.
     * @param from Адрес отправителя
     * @param to Адрес получателя
     * @param tokenId Идентификатор токена
     * @param data Дополнительные данные
     * @return true, если получатель поддерживает ERC721
     */
    function _checkOnERC721Received(
        address from,
        address to,
        uint tokenId,
        bytes memory data
    ) private returns(bool) {
        if(to.code.length > 0) { // Проверка, поддерживает ли получатель код
            try IERC721Receiver(to).onERC721Received(msg.sender, from, tokenId, data) returns(bytes4 retval) {
                return retval == IERC721Receiver.onERC721Received.selector; // Проверка результата получения токена
            } catch(bytes memory reason) { 
                if(reason.length == 0) {
                    revert("Transfer to non-erc721 receiver"); // Ошибка перевода
                } else {
                    assembly {
                        revert(add(32, reason), mload(reason)) // Обработка ошибки
                    }
                }
            }
        } else {
            return true; // Возвращение true, если получатель не имеет кода
        }
    }

    /**
     * @dev Вспомогательная функция для выполнения перевода.
     * @param from Адрес отправителя
     * @param to Адрес получателя
     * @param tokenId Идентификатор токена
     */
    function _transfer(address from, address to, uint tokenId) internal {
        require(ownerOf(tokenId) == from, "ERC721: incorrect owner"); // Проверка на правильного владельца
        require(to != address(0), "ERC721: transfer to the zero address"); // Проверка на нулевой адрес
        _beforeTokenTransfer(from, to, tokenId); // Хук до перевода
        delete _tokenApprovals[tokenId]; // Удаление разрешений на токен
        _balances[from]--; // Уменьшение баланса отправителя
        _balances[to]++; // Увеличение баланса получателя
        _owners[tokenId] = to; // Установка нового владельца
        emit Transfer(from, to, tokenId); // Событие перевода
        _afterTokenTransfer(from, to, tokenId); // Хук после перевода
    }

    /**
     * @dev Хук, который вызывается до перевода токенов.
     * @param from Адрес отправителя
     * @param to Адрес получателя
     * @param tokenId Идентификатор токена
     */
    function _beforeTokenTransfer(address from, address to, uint tokenId) internal virtual {}

    /**
     * @dev Хук, который вызывается после перевода токенов.
     * @param from Адрес отправителя
     * @param to Адрес получателя
     * @param tokenId Идентификатор токена
     */
    function _afterTokenTransfer(address from, address to, uint tokenId) internal virtual {}
}
