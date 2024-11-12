// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Импорт интерфейсов ERC1155, ERC1155MetadataURI и ERC1155Receiver.
import "./IERC1155.sol"; // Импорт интерфейса IERC1155 для стандартного мульти-токена.
import "./IERC1155MetadataURI.sol"; // Импорт интерфейса для работы с URI метаданных.
import "./IERC1155Receiver.sol"; // Импорт интерфейса для приемника токенов ERC1155.

/**
 * @title ERC1155
 * @dev Реализация стандарта ERC1155 для мульти-токенов.
 */
contract ERC1155 is IERC1155, IERC1155MetadataURI {
    // Хранение балансов для каждого типа токена и адреса владельца. //
    mapping(uint => mapping(address => uint)) private _balances; // Маппинг для отслеживания балансов.
    // Хранение данных о разрешении операторов для владельцев токенов. //
    mapping(address => mapping(address => bool)) private _operatorApprovals; // Маппинг для управления разрешениями операторов.
    // Базовый URI для токенов. //
    string private _uri; // Переменная для хранения базового URI.

    /**
     * @dev Конструктор контракта.
     * @param uri_ Базовый URI для метаданных токенов.
     */
    constructor(string memory uri_) {
        _setURI(uri_); // Установка базового URI при развертывании контракта.
    }

    /**
     * @dev Возвращает URI для метаданных токена.
     * @param id Идентификатор токена (не используется в базовой реализации).
     */
    function uri(uint id) external view virtual returns (string memory) {
        return _uri; // Возвращает базовый URI.
    }

    /**
     * @dev Возвращает баланс токена `id` для указанного адреса `account`.
     * @param account Адрес владельца токенов.
     * @param id Идентификатор токена.
     */
    function balanceOf(address account, uint id) public view returns (uint) {
        require(account != address(0), "Invalid address"); // Проверка, что адрес не равен нулевому.
        return _balances[id][account]; // Возвращает баланс для заданного токена и адреса.
    }

    /**
     * @dev Возвращает балансы для набора адресов и идентификаторов токенов.
     * @param accounts Массив адресов владельцев токенов.
     * @param ids Массив идентификаторов токенов.
     */
    function balanceOfBatch(
        address[] calldata accounts,
        uint[] calldata ids
    ) public view returns (uint[] memory batchBalances) {
        require(accounts.length == ids.length, "Accounts and IDs length mismatch"); // Проверка соответствия длин массивов.
        batchBalances = new uint[](accounts.length); // Инициализация массива для результатов.
        for (uint i = 0; i < accounts.length; ++i) {
            batchBalances[i] = balanceOf(accounts[i], ids[i]); // Получение баланса для каждого аккаунта и ID.
        }
    }

    /**
     * @dev Устанавливает или снимает разрешение оператора на управление всеми токенами владельца.
     * @param operator Адрес оператора.
     * @param approved Статус разрешения (true для установки, false для отмены).
     */
    function setApprovalForAll(address operator, bool approved) external {
        _setApprovalForAll(msg.sender, operator, approved); // Установка разрешения оператора для владельца.
    }

    /**
     * @dev Проверяет, имеет ли оператор разрешение на управление токенами владельца.
     * @param account Адрес владельца токенов.
     * @param operator Адрес оператора.
     */
    function isApprovedForAll(address account, address operator) public view returns (bool) {
        return _operatorApprovals[account][operator]; // Возвращает статус разрешения оператора.
    }

    /**
     * @dev Переводит указанное количество токенов `id` от `from` к `to`.
     * @param from Адрес отправителя.
     * @param to Адрес получателя.
     * @param id Идентификатор токена.
     * @param amount Количество токенов.
     * @param data Дополнительные данные для вызова.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint id,
        uint amount,
        bytes calldata data
    ) external {
        require(
            from == msg.sender || isApprovedForAll(from, msg.sender),
            "Caller is not owner nor approved"
        ); // Проверка, что вызывающий — владелец или имеет разрешение.
        _safeTransferFrom(from, to, id, amount, data); // Вызов внутренней функции безопасного перевода.
    }

    /**
     * @dev Переводит несколько типов токенов в одной транзакции от `from` к `to`.
     * @param from Адрес отправителя.
     * @param to Адрес получателя.
     * @param ids Массив идентификаторов токенов.
     * @param amounts Массив количеств токенов.
     * @param data Дополнительные данные для вызова.
     */
    function safeBatchTransferFrom(
        address from,
        address to,
        uint[] calldata ids,
        uint[] calldata amounts,
        bytes calldata data
    ) external {
        require(
            from == msg.sender || isApprovedForAll(from, msg.sender),
            "Caller is not owner nor approved"
        ); // Проверка прав на перевод.
        _safeBatchTransferFrom(from, to, ids, amounts, data); // Вызов внутренней функции пакетного перевода.
    }

    /**
     * @dev Внутренняя функция для безопасного перевода токенов.
     */
    function _safeTransferFrom(
        address from,
        address to,
        uint id,
        uint amount,
        bytes calldata data
    ) internal {
        require(to != address(0), "Transfer to zero address"); // Проверка, что адрес получателя не нулевой.
        address operator = msg.sender; // Определение оператора транзакции.

        uint[] memory ids = _asSingletonArray(id); // Преобразование ID в массив.
        uint[] memory amounts = _asSingletonArray(amount); // Преобразование количества в массив.

        _beforeTokenTransfer(operator, from, to, ids, amounts, data); // Вызов хука перед передачей.

        uint fromBalance = _balances[id][from]; // Получение текущего баланса отправителя.
        require(fromBalance >= amount, "Insufficient balance for transfer"); // Проверка, что баланс достаточен.
        _balances[id][from] = fromBalance - amount; // Обновление баланса отправителя.
        _balances[id][to] += amount; // Обновление баланса получателя.

        emit TransferSingle(operator, from, to, id, amount); // Генерация события о передаче.

        _afterTokenTransfer(operator, from, to, ids, amounts, data); // Вызов хука после передачи.

        _doSafeTransferAcceptanceCheck(operator, from, to, id, amount, data); // Проверка принятия токенов получателем.
    }

    /**
     * @dev Внутренняя функция для безопасного пакетного перевода токенов.
     */
    function _safeBatchTransferFrom(
        address from,
        address to,
        uint[] calldata ids,
        uint[] calldata amounts,
        bytes calldata data
    ) internal {
        require(ids.length == amounts.length, "IDs and amounts length mismatch"); // Проверка соответствия длин массивов.
        require(to != address(0), "Transfer to zero address"); // Проверка адреса получателя.

        address operator = msg.sender; // Определение оператора транзакции.
        _beforeTokenTransfer(operator, from, to, ids, amounts, data); // Вызов хука перед передачей.

        for (uint i = 0; i < ids.length; ++i) {
            uint id = ids[i]; // Получение ID токена.
            uint amount = amounts[i]; // Получение количества токенов.

            uint fromBalance = _balances[id][from]; // Получение текущего баланса отправителя.
            require(fromBalance >= amount, "Insufficient balance for transfer"); // Проверка баланса.
            _balances[id][from] = fromBalance - amount; // Обновление баланса отправителя.
            _balances[id][to] += amount; // Обновление баланса получателя.
        }

        emit TransferBatch(operator, from, to, ids, amounts); // Генерация события о пакетной передаче.

        _afterTokenTransfer(operator, from, to, ids, amounts, data); // Вызов хука после передачи.

        _doSafeBatchTransferAcceptanceCheck(operator, from, to, ids, amounts, data); // Проверка принятия токенов.
    }

    /**
     * @dev Устанавливает базовый URI для метаданных токенов.
     * @param newUri Новый URI.
     */
    function _setURI(string memory newUri) internal virtual {
        _uri = newUri; // Установка нового URI.
    }

    /**
 * @dev Внутренняя функция для установки разрешения оператора.
 */
function _setApprovalForAll(
    address owner, // Адрес владельца токенов.
    address operator, // Адрес оператора, которому выдается или снимается разрешение.
    bool approved // Статус разрешения (true для установки, false для снятия).
) internal {
    require(owner != operator, "Setting approval status for self"); // Проверка, что владелец и оператор не совпадают.
    _operatorApprovals[owner][operator] = approved; // Установка статуса разрешения для оператора.
    emit ApprovalForAll(owner, operator, approved); // Генерация события о изменении разрешения.
}

/**
 * @dev Внутренний хук, вызываемый перед передачей токенов.
 */
function _beforeTokenTransfer(
    address operator, // Адрес оператора, инициирующего передачу.
    address from, // Адрес отправителя токенов.
    address to, // Адрес получателя токенов.
    uint[] memory ids, // Массив идентификаторов токенов.
    uint[] memory amounts, // Массив количеств токенов.
    bytes memory data // Дополнительные данные.
) internal virtual {} // Пустая функция-хук, может быть переопределена в дочерних контрактах.

/**
 * @dev Внутренний хук, вызываемый после передачи токенов.
 */
function _afterTokenTransfer(
    address operator, // Адрес оператора, инициирующего передачу.
    address from, // Адрес отправителя токенов.
    address to, // Адрес получателя токенов.
    uint[] memory ids, // Массив идентификаторов токенов.
    uint[] memory amounts, // Массив количеств токенов.
    bytes memory data // Дополнительные данные.
) internal virtual {} // Пустая функция-хук, может быть переопределена в дочерних контрактах.

/**
 * @dev Проверяет принятие токенов контрактом-получателем.
 */
function _doSafeTransferAcceptanceCheck(
    address operator, // Адрес оператора, инициирующего передачу.
    address from, // Адрес отправителя токенов.
    address to, // Адрес получателя токенов.
    uint id, // Идентификатор токена.
    uint amount, // Количество токенов.
    bytes calldata data // Дополнительные данные.
) private {
    if (to.code.length > 0) { // Проверка, что адрес получателя является контрактом.
        try IERC1155Receiver(to).onERC1155Received(operator, from, id, amount, data) returns (bytes4 resp) {
            if (resp != IERC1155Receiver.onERC1155Received.selector) { // Проверка, что контракт возвращает правильный селектор.
                revert("Rejected tokens"); // Отклонение, если селектор не совпадает.
            }
        } catch Error(string memory reason) {
            revert(reason); // Перехват ошибки с сообщением и откат транзакции.
        } catch {
            revert("Non-ERC1155 receiver"); // Откат транзакции, если вызов не удался.
        }
    }
}

/**
 * @dev Проверяет принятие пакетного перевода токенов контрактом-получателем.
 */
function _doSafeBatchTransferAcceptanceCheck(
    address operator, // Адрес оператора, инициирующего передачу.
    address from, // Адрес отправителя токенов.
    address to, // Адрес получателя токенов.
    uint[] memory ids, // Массив идентификаторов токенов.
    uint[] memory amounts, // Массив количеств токенов.
    bytes calldata data // Дополнительные данные.
) private {
    if (to.code.length > 0) { // Проверка, что адрес получателя является контрактом.
        try IERC1155Receiver(to).onERC1155BatchReceived(operator, from, ids, amounts, data) returns (bytes4 resp) {
            if (resp != IERC1155Receiver.onERC1155BatchReceived.selector) { // Проверка, что контракт возвращает правильный селектор для пакетной передачи.
                revert("Rejected tokens"); // Отклонение, если селектор не совпадает.
            }
        } catch Error(string memory reason) {
            revert(reason); // Перехват ошибки с сообщением и откат транзакции.
        } catch {
            revert("Non-ERC1155 receiver"); // Откат транзакции, если вызов не удался.
        }
    }
}

/**
 * @dev Вспомогательная функция для создания массива из одного элемента.
 */
function _asSingletonArray(uint el) private pure returns (uint[] memory result) {
    result = new uint; // Создание массива длиной 1.
    result[0] = el; // Присвоение элемента массиву.
}

}