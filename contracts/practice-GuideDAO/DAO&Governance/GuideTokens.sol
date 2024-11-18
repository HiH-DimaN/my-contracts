// SPDX-License-Identifier: MIT

// Указываем компилятор Solidity версии 0.8.0
pragma solidity ^0.8.20;

// Импортируем необходимые библиотеки и контракты
import {ERC6909} from "./ERC6909.sol";
import {ERC6909TokenSupply} from "./ERC6909TokenSupply.sol";
import {ERC6909Metadata} from "./ERC6909Metadata.sol";
import {ERC6909ContentURI} from "./ERC6909ContentURI.sol";

// Определяем контракт GuideTokens, наследующий функциональность от нескольких контрактов
contract GuideTokens is ERC6909, ERC6909TokenSupply, ERC6909Metadata, ERC6909ContentURI {
    // Ошибка для случаев, когда вызывающий не является владельцем
    error NotAnOwner(address caller);

    // Приватная переменная для хранения адреса владельца
    address private _owner;

    // Приватная переменная для отслеживания следующего идентификатора токена
    uint256 private _nextTokenId;

    // Модификатор, позволяющий выполнение только владельцем
    modifier onlyOwner() {
        require(msg.sender == _owner, NotAnOwner(msg.sender));
        _;
    }

    // Конструктор контракта, принимающий адрес владельца и начальный URI контракта
    constructor(address owner, string memory _initialContractURI) ERC6909ContentURI(_initialContractURI) {
        // Устанавливаем владельца контракта
        _owner = owner;

        // Создаем и ментим первый токен
        uint256 tokenId0 = _nextTokenId++;
        _mint(_owner, tokenId0, 5 * 10 ** 18); // Ментим токен с количеством 5 * 10^18
        _setTokenMetadata(tokenId0, "Token Zero", "TK0", 18); // Устанавливаем метаданные токена
        _setTokenURI(tokenId0, "http://example.com/tokens/gtk/0.json"); // Устанавливаем URI токена

        // Создаем и ментим второй токен
        uint256 tokenId1 = _nextTokenId++;
        _mint(_owner, tokenId1, 5 * 10 ** 18); // Ментим токен с количеством 5 * 10^18
        _setTokenMetadata(tokenId1, "Token One", "TK1", 18); // Устанавливаем метаданные токена
        _setTokenURI(tokenId1, "http://example.com/tokens/gtk/1.json"); // Устанавливаем URI токена
    }

    // Функция для ментинга токена, доступна только владельцу
    function mint(address recipient, uint256 id, uint256 amount) public onlyOwner {
        _mint(recipient, id, amount);
    }

    // Функция для сжигания токена
    function burn(address sender, uint256 id, uint256 amount) public {
        _burn(sender, id, amount);
    }

    // Переопределение внутренней функции _mint для обеспечения совместимости
    function _mint(address recipient, uint256 id, uint256 amount) internal override(ERC6909, ERC6909TokenSupply) {
        super._mint(recipient, id, amount);
    }

    // Переопределение внутренней функции _burn для обеспечения совместимости
    function _burn(address sender, uint256 id, uint256 amount) internal override(ERC6909, ERC6909TokenSupply) {
        super._burn(sender, id, amount);
    }
}
