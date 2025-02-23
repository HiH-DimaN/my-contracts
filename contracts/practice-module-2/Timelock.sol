// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
 * @title Timelock
 * @dev Контракт для выполнения транзакций с задержкой и мультиподписью
 */
contract Timelock {
    uint constant MINIMUM_DELAY = 10; // Минимальная задержка перед исполнением транзакции
    uint constant MAXIMUM_DELAY = 1 days; // Максимальная задержка перед исполнением транзакции
    uint constant GRACE_PERIOD = 1 days; // Период, в течение которого транзакция остается действительной
    address[] public owners; // Список владельцев (подписантов)
    mapping(address => bool) public isOwner; // Проверка, является ли адрес владельцем
    string public message; // Сообщение для демо-функции
    uint public amount; // Сумма, отправленная в контракт
    uint public constant CONFIRMATIONS_REQUIRED = 3; // Количество подтверждений, необходимое для выполнения транзакции

    struct Transaction {
        bytes32 uid; // Уникальный идентификатор транзакции
        address to; // Адрес получателя транзакции
        uint value; // Значение транзакции (ETH)
        bytes data; // Данные транзакции (вызовы функций)
        bool executed; // Флаг выполнения транзакции
        uint confirmations; // Количество подтверждений транзакции
    }
    mapping(bytes32 => Transaction) public txs; // Список всех транзакций по их уникальному ID
    mapping(bytes32 => mapping(address => bool)) public confirmations; // Хранит, какие владельцы подтвердили транзакцию
    mapping(bytes32 => bool) public queue; // Хранит очередь ожидающих транзакций

    modifier onlyOwner() { // Модификатор доступа для владельцев
        require(isOwner[msg.sender], "not an owner!"); // Проверяет, является ли вызывающий контракт владельцем
        _; // Продолжает выполнение функции
    }

    event Queued(bytes32 txId); // Событие при добавлении транзакции в очередь
    event Discarded(bytes32 txId); // Событие при удалении транзакции из очереди
    event Executed(bytes32 txId); // Событие при выполнении транзакции

    /**
     * @dev Конструктор контракта, устанавливает владельцев
     * @param _owners Массив адресов владельцев
     */
    constructor(address[] memory _owners) {
        require(_owners.length >= CONFIRMATIONS_REQUIRED, "not enough owners!"); // Проверяем, что владельцев достаточно

        for(uint i = 0; i < _owners.length; i++) { // Проходим по переданному массиву владельцев
            address nextOwner = _owners[i]; // Берем следующего владельца
            require(nextOwner != address(0), "cant have zero address as owner!"); // Проверяем, что это не нулевой адрес
            require(!isOwner[nextOwner], "duplicate owner!"); // Проверяем, что владелец не добавлен повторно

            isOwner[nextOwner] = true; // Добавляем владельца в mapping
            owners.push(nextOwner); // Записываем владельца в массив
        }
    }

    /**
     * @dev Функция демонстрации записи строки и суммы
     * @param _msg Сообщение
     */
    function demo(string calldata _msg) external payable {
        message = _msg; // Записываем сообщение в переменную
        amount = msg.value; // Записываем отправленную сумму в контракт
    }

    /**
     * @dev Возвращает метку времени через 60 секунд
     * @return uint Новая метка времени
     */
    function getNextTimestamp() external view returns(uint) {
        return block.timestamp + 60; // Возвращает текущее время плюс 60 секунд
    }

    /**
     * @dev Кодирует строку в байтовые данные
     * @param _msg Строка для кодирования
     * @return bytes Закодированные данные
     */
    function prepareData(string calldata _msg) external pure returns(bytes memory) {
        return abi.encode(_msg); // Кодируем строку в формат bytes
    }

    /**
     * @dev Добавляет транзакцию в очередь с временной задержкой
     * @param _to Адрес получателя
     * @param _func Имя вызываемой функции
     * @param _data Данные транзакции
     * @param _value Количество ETH
     * @param _timestamp Время исполнения
     * @return bytes32 Идентификатор транзакции
     */
    function addToQueue(
        address _to,
        string calldata _func,
        bytes calldata _data,
        uint _value,
        uint _timestamp
    ) external onlyOwner returns(bytes32) {
        require(
            _timestamp > block.timestamp + MINIMUM_DELAY &&
            _timestamp < block.timestamp + MAXIMUM_DELAY,
            "invalid timestamp"
        ); // Проверяем, что время исполнения в допустимых пределах

        bytes32 txId = keccak256(abi.encode(
            _to,
            _func,
            _data,
            _value,
            _timestamp
        )); // Создаем хеш транзакции

        require(!queue[txId], "already queued"); // Проверяем, что транзакция еще не в очереди
        queue[txId] = true; // Добавляем транзакцию в очередь

        txs[txId] = Transaction({
            uid: txId, // Уникальный ID транзакции
            to: _to, // Адрес получателя
            value: _value, // Сумма ETH для отправки
            data: _data, // Данные транзакции
            executed: false, // Флаг выполнения
            confirmations: 0 // Количество подтверждений
        }); // Создаем запись транзакции

        emit Queued(txId); // Генерируем событие о добавлении в очередь
        return txId; // Возвращаем идентификатор транзакции
    }
}