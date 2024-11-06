// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.20; // Установка версии компилятора Solidity

import "./ERC165.sol"; // Импорт контракта ERC165 для поддержки интерфейсов
import "./IERC721.sol"; // Импорт интерфейса ERC721 для стандартных операций с токенами
import "./IERC721Metadata.sol"; // Импорт интерфейса ERC721Metadata для метаданных токенов
import "./Strings.sol"; // Импорт библиотеки Strings для работы со строками
import "./IERC721Receiver.sol"; // Импорт интерфейса IERC721Receiver для обработки безопасных переводов токенов
import "hardhat/console.sol"; // Импорт консоли для отладки (только в среде разработки Hardhat)

/**
* @title ERC721 Token
* @dev Реализация стандарта ERC721 с поддержкой метаданных и безопасных переводов
* @author HiH_DimaN
*/
contract ERC721 is ERC165, IERC721, IERC721Metadata {
    using Strings for uint; // Использование библиотеки Strings для преобразования чисел в строки

    string private _name; // Имя токенов
    string private _symbol; // Символ токенов

    mapping(address => uint) private _balances; // Баланс каждого владельца токенов
    mapping(uint => address) private _owners; // Владелец каждого токена по его ID
    mapping(uint => address) private _tokenApprovals; // Разрешенные адреса для управления конкретным токеном
    mapping(address => mapping(address => bool)) private _operatorApprovals; // Разрешения операторов для управления всеми токенами владельца

    /**
     * @dev Модификатор, проверяющий, что токен существует.
     * @param tokenId Идентификатор токена для проверки
     */
    modifier _requireMinted(uint tokenId) {
        require(_exists(tokenId), "not minted!"); // Проверка существования токена
        _; // Продолжение выполнения функции
    }

    /**
     * @dev Конструктор для инициализации контракта с именем и символом токенов.
     * @param name_ Имя токенов
     * @param symbol_ Символ токенов
     */
    constructor(string memory name_, string memory symbol_) {
        _name = name_; // Установка имени токенов
        _symbol = symbol_; // Установка символа токенов
    }

    /**
     * @dev Функция для передачи токена от одного владельца к другому.
     * @param from Адрес отправителя токена
     * @param to Адрес получателя токена
     * @param tokenId Идентификатор передаваемого токена
     */
    function transferFrom(address from, address to, uint tokenId) external {
        require(_isApprovedOrOwner(msg.sender, tokenId), "not approved or owner!"); // Проверка прав на передачу токена
        _transfer(from, to, tokenId); // Вызов внутренней функции передачи токена
    }

    // function safeTransferFrom(
    //     address from,
    //     address to,
    //     uint tokenId
    // ) public {
    //     safeTransferFrom(from, to, tokenId, ""); // Вызов безопасной передачи токена без данных
    // }

    /**
     * @dev Функция для безопасной передачи токена с дополнительными данными.
     * @param from Адрес отправителя токена
     * @param to Адрес получателя токена
     * @param tokenId Идентификатор передаваемого токена
     * @param data Дополнительные данные, передаваемые вместе с токеном
     */
    function safeTransferFrom(
        address from,
        address to,
        uint tokenId,
        bytes memory data
    ) public {
        require(_isApprovedOrOwner(msg.sender, tokenId), "not owner!"); // Проверка прав на передачу токена
        _safeTransfer(from, to, tokenId, data); // Вызов внутренней безопасной функции передачи токена
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
     * @param owner Адрес владельца токенов
     * @return Количество токенов, принадлежащих владельцу
     */
    function balanceOf(address owner) public view returns(uint) {
        require(owner != address(0), "owner cannot be zero"); // Проверка, что адрес владельца не нулевой
        return _balances[owner]; // Возвращение баланса владельца
    }

    /**
     * @dev Функция для получения владельца токена по его идентификатору.
     * @param tokenId Идентификатор токена
     * @return Адрес владельца токена
     */
    function ownerOf(uint tokenId) public view _requireMinted(tokenId) returns(address) {
        return _owners[tokenId]; // Возвращение владельца токена
    }

    /**
     * @dev Функция для утверждения другого адреса на управление конкретным токеном.
     * @param to Адрес, которому предоставляется разрешение
     * @param tokenId Идентификатор токена
     */
    function approve(address to, uint tokenId) public {
        address _owner = ownerOf(tokenId); // Получение владельца токена
        require(
            _owner == msg.sender || isApprovedForAll(_owner, msg.sender),
            "not an owner!" // Проверка, что вызывающий является владельцем или оператором
        );
        require(to != _owner, "cannot approve to self"); // Проверка, что нельзя утверждать себе
        _tokenApprovals[tokenId] = to; // Установка разрешения для токена
        emit Approval(_owner, to, tokenId); // Генерация события утверждения
    }

    /**
     * @dev Функция для установки разрешения оператора на управление всеми токенами владельца.
     * @param operator Адрес оператора
     * @param approved Статус утверждения: true для утверждения, false для отмены
     */
    function setApprovalForAll(address operator, bool approved) public {
        require(msg.sender != operator, "cannot approve to self"); // Проверка, что оператор не сам себе
        _operatorApprovals[msg.sender][operator] = approved; // Установка разрешения для оператора
        emit ApprovalForAll(msg.sender, operator, approved); // Генерация события утверждения оператора
    }

    /**
     * @dev Функция для получения адреса, утвержденного для управления конкретным токеном.
     * @param tokenId Идентификатор токена
     * @return Адрес, утвержденный для управления токеном
     */
    function getApproved(uint tokenId) public view _requireMinted(tokenId) returns(address) {
        return _tokenApprovals[tokenId]; // Возвращение утвержденного адреса
    }

    /**
     * @dev Функция для проверки, утвержден ли оператор на управление всеми токенами владельца.
     * @param owner Адрес владельца токенов
     * @param operator Адрес оператора
     * @return true, если оператор утвержден, иначе false
     */
    function isApprovedForAll(address owner, address operator) public view returns(bool) {
        return _operatorApprovals[owner][operator]; // Возвращение статуса утверждения оператора
    }

    /**
     * @dev Функция для проверки поддержки интерфейсов.
     * @param interfaceId Идентификатор интерфейса
     * @return true, если интерфейс поддерживается, иначе false
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override returns(bool) {
        return interfaceId == type(IERC721).interfaceId || // Проверка поддержки интерфейса ERC721
            interfaceId == type(IERC721Metadata).interfaceId || // Проверка поддержки интерфейса ERC721Metadata
            super.supportsInterface(interfaceId); // Вызов родительской функции для других интерфейсов
    }

    /**
     * @dev Внутренняя функция для безопасного минтинга токена без дополнительных данных.
     * @param to Адрес получателя токена
     * @param tokenId Идентификатор токена
     */
    function _safeMint(address to, uint tokenId) internal virtual {
        _safeMint(to, tokenId, ""); // Вызов безопасного минтинга с пустыми данными
    }

    /**
     * @dev Внутренняя функция для безопасного минтинга токена с дополнительными данными.
     * @param to Адрес получателя токена
     * @param tokenId Идентификатор токена
     * @param data Дополнительные данные для безопасного минтинга
     */
    function _safeMint(address to, uint tokenId, bytes memory data) internal virtual {
        _mint(to, tokenId); // Вызов внутренней функции минтинга токена
        require(_checkOnERC721Received(address(0), to, tokenId, data), "non-erc721 receiver"); // Проверка поддержки ERC721 получателем
    }

    /**
     * @dev Внутренняя функция для минтинга токена.
     * @param to Адрес получателя токена
     * @param tokenId Идентификатор токена
     */
    function _mint(address to, uint tokenId) internal virtual {
        require(to != address(0), "zero address to"); // Проверка, что адрес получателя не нулевой
        require(!_exists(tokenId), "this token id is already minted"); // Проверка, что токен с таким ID еще не существует
        _beforeTokenTransfer(address(0), to, tokenId); // Вызов хука перед минтингом токена
        _owners[tokenId] = to; // Установка владельца токена
        _balances[to]++; // Увеличение баланса получателя
        emit Transfer(address(0), to, tokenId); // Генерация события минтинга токена
        _afterTokenTransfer(address(0), to, tokenId); // Вызов хука после минтинга токена
    }

    /**
     * @dev Функция для сжигания токена.
     * @param tokenId Идентификатор токена для сжигания
     */
    function burn(uint256 tokenId) public virtual {
        require(_isApprovedOrOwner(msg.sender, tokenId), "not owner!"); // Проверка прав на сжигание токена
        _burn(tokenId); // Вызов внутренней функции сжигания токена
    }

    /**
     * @dev Внутренняя функция для сжигания токена.
     * @param tokenId Идентификатор токена для сжигания
     */
    function _burn(uint tokenId) internal virtual {
        address owner = ownerOf(tokenId); // Получение владельца токена
        _beforeTokenTransfer(owner, address(0), tokenId); // Вызов хука перед сжиганием токена
        delete _tokenApprovals[tokenId]; // Удаление разрешения на токен
        _balances[owner]--; // Уменьшение баланса владельца
        delete _owners[tokenId]; // Удаление владельца токена
        emit Transfer(owner, address(0), tokenId); // Генерация события сжигания токена
        _afterTokenTransfer(owner, address(0), tokenId); // Вызов хука после сжигания токена
    }

    /**
     * @dev Внутренняя функция для получения базового URI.
     * @return Базовый URI для токенов
     */
    function _baseURI() internal pure virtual returns(string memory) {
        return ""; // Возвращение пустого базового URI
    }

    /**
     * @dev Функция для получения URI метаданных токена.
     * @param tokenId Идентификатор токена
     * @return URI метаданных токена
     */
    function tokenURI(uint tokenId) public view virtual _requireMinted(tokenId) returns(string memory) {
        string memory baseURI = _baseURI(); // Получение базового URI
        return bytes(baseURI).length > 0 ? // Проверка, задан ли базовый URI
            string(abi.encodePacked(baseURI, tokenId.toString())) : // Объединение базового URI с идентификатором токена
            ""; // Возвращение пустой строки, если базовый URI не задан
    }

    /**
     * @dev Внутренняя функция для проверки существования токена.
     * @param tokenId Идентификатор токена
     * @return true, если токен существует, иначе false
     */
    function _exists(uint tokenId) internal view returns(bool) {
        return _owners[tokenId] != address(0); // Проверка, что токен имеет владельца
    }

    /**
     * @dev Внутренняя функция для проверки, является ли адрес утвержденным или владельцем токена.
     * @param spender Адрес, проверяющий права на токен
     * @param tokenId Идентификатор токена
     * @return true, если адрес является владельцем или утвержденным оператором, иначе false
     */
    function _isApprovedOrOwner(address spender, uint tokenId) internal view returns(bool) {
        address owner = ownerOf(tokenId); // Получение владельца токена
        return(
            spender == owner || // Проверка, что адрес является владельцем токена
            isApprovedForAll(owner, spender) || // Проверка, что адрес утвержден как оператор для всех токенов владельца
            getApproved(tokenId) == spender // Проверка, что адрес утвержден для управления конкретным токеном
        ); // Возвращение результата проверки прав
    }

    /**
     * @dev Внутренняя функция для безопасной передачи токена с проверкой поддерживающего интерфейса получателя.
     * @param from Адрес отправителя токена
     * @param to Адрес получателя токена
     * @param tokenId Идентификатор токена
     * @param data Дополнительные данные для передачи
     */
    function _safeTransfer(
        address from,
        address to,
        uint tokenId,
        bytes memory data
    ) internal {
        _transfer(from, to, tokenId); // Вызов внутренней функции передачи токена
        require(
            _checkOnERC721Received(from, to, tokenId, data),
            "transfer to non-erc721 receiver" // Проверка, что получатель поддерживает интерфейс ERC721
        ); // Генерация ошибки, если получатель не поддерживает ERC721
    }
    
    /**
     * @dev Внутренняя функция для проверки, поддерживает ли получатель интерфейс ERC721.
     * @param from Адрес отправителя токена
     * @param to Адрес получателя токена
     * @param tokenId Идентификатор токена
     * @param data Дополнительные данные для передачи
     * @return true, если получатель поддерживает ERC721, иначе false
     */
    function _checkOnERC721Received(
        address from,
        address to,
        uint tokenId,
        bytes memory data
    ) private returns(bool) {
        if(to.code.length > 0) { // Проверка, что получатель является контрактом
            try IERC721Receiver(to).onERC721Received(msg.sender, from, tokenId, data) returns(bytes4 retval) { // Попытка вызова функции onERC721Received
                return retval == IERC721Receiver.onERC721Received.selector; // Проверка соответствия возвращаемого значения селектору
            } catch(bytes memory reason) { // Обработка исключений при вызове функции
                if(reason.length == 0) { // Если причина ошибки не предоставлена
                    revert("Transfer to non-erc721 receiver"); // Генерация ошибки
                } else {
                    assembly { // Использование ассемблера для возврата причины ошибки
                        revert(add(32, reason), mload(reason)) // Возврат причины ошибки
                    }
                }
            }
        } else {
            return true; // Возвращение true, если получатель не является контрактом
        }
    }
    
    /**
     * @dev Внутренняя функция для передачи токена.
     * @param from Адрес отправителя токена
     * @param to Адрес получателя токена
     * @param tokenId Идентификатор токена
     */
    function _transfer(address from, address to, uint tokenId) internal {
        require(ownerOf(tokenId) == from, "incorrect owner!"); // Проверка, что адрес отправителя является владельцем токена
        require(to != address(0), "to address is zero!"); // Проверка, что адрес получателя не является нулевым
        _beforeTokenTransfer(from, to, tokenId); // Вызов хука перед передачей токена
        delete _tokenApprovals[tokenId]; // Удаление разрешений на токен
        _balances[from]--; // Уменьшение баланса отправителя
        _balances[to]++; // Увеличение баланса получателя
        _owners[tokenId] = to; // Установка нового владельца токена
        emit Transfer(from, to, tokenId); // Генерация события передачи токена
        _afterTokenTransfer(from, to, tokenId); // Вызов хука после передачи токена
    }

    /**
     * @dev Внутренняя функция, вызываемая перед каждым переводом токена.
     * Может быть переопределена в дочерних контрактах для добавления дополнительной логики.
     * @param from Адрес отправителя токена
     * @param to Адрес получателя токена
     * @param tokenId Идентификатор токена
     */
    function _beforeTokenTransfer(
        address from, address to, uint tokenId
    ) internal virtual {} // Пустой хук, может быть переопределен

    /**
     * @dev Внутренняя функция, вызываемая после каждого перевода токена.
     * Может быть переопределена в дочерних контрактах для добавления дополнительной логики.
     * @param from Адрес отправителя токена
     * @param to Адрес получателя токена
     * @param tokenId Идентификатор токена
     */
    function _afterTokenTransfer(
        address from, address to, uint tokenId
    ) internal virtual {} // Пустой хук, может быть переопределен
}
