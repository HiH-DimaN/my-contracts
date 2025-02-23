// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Timelock с Multisig-подтверждениями
 * @notice Контракт для отложенного выполнения транзакций с требовнием нескольких подтверждений
 * @dev Сочетает механизм Timelock и Multi-Signature Wallet
 */
contract Timelock {
    /// @notice Минимальная задержка выполнения транзакции (в секундах)
    uint constant MINIMUM_DELAY = 10;
    /// @notice Максимальная задержка выполнения транзакции (1 день)
    uint constant MAXIMUM_DELAY = 1 days;
    /// @notice Период, в течение которого транзакция может быть выполнена после готовности
    uint constant GRACE_PERIOD = 1 days;
    
    /// @notice Список владельцев Multisig
    address[] public owners;
    /// @notice Отображение адреса на статус владельца
    mapping(address => bool) public isOwner;
    
    // Демо-переменные для тестирования
    string public message;    // Текстовое сообщение
    uint public amount;       // Хранимая сумма ETH
    
    /// @notice Требуемое количество подтверждений
    uint public constant CONFIRMATIONS_REQUIRED = 3;

    /**
     * @notice Структура данных транзакции
     * @param uid Уникальный идентификатор транзакции
     * @param to Адрес получателя
     * @param value Сумма ETH для отправки
     * @param data Данные вызова
     * @param executed Флаг выполнения транзакции
     * @param confirmations Количество полученных подтверждений
     */
    struct Transaction {
        bytes32 uid;
        address to;
        uint value;
        bytes data;
        bool executed;
        uint confirmations;
    }

    /// @notice Хранилище транзакций по их ID
    mapping(bytes32 => Transaction) public txs;
    /// @notice Подтверждения транзакций участниками
    mapping(bytes32 => mapping(address => bool)) public confirmations;
    /// @notice Очередь ожидающих транзакций
    mapping(bytes32 => bool) public queue;

    /// @notice Модификатор для проверки прав владельца
    modifier onlyOwner() {
        require(isOwner[msg.sender], "not an owner!");
        _;
    }

    /// @notice Событие при добавлении транзакции в очередь
    event Queued(bytes32 txId);
    /// @notice Событие при отмене транзакции
    event Discarded(bytes32 txId);
    /// @notice Событие при успешном выполнении транзакции
    event Executed(bytes32 txId);

    /**
     * @notice Инициализирует контракт списком владельцев
     * @param _owners Массив адресов владельцев
     * @dev Требует минимум CONFIRMATIONS_REQUIRED владельцев
     */
    constructor(address[] memory _owners) {
        require(_owners.length >= CONFIRMATIONS_REQUIRED, "not enough owners!");

        for(uint i = 0; i < _owners.length; i++) {
            address nextOwner = _owners[i];
            // Проверка на нулевой адрес
            require(nextOwner != address(0), "cant have zero address as owner!");
            // Проверка на дубликаты
            require(!isOwner[nextOwner], "duplicate owner!");

            isOwner[nextOwner] = true; // Добавление в mapping
            owners.push(nextOwner);    // Добавление в массив
        }
    }

    /**
     * @notice Демо-функция для обновления сообщения и суммы
     * @param _msg Новое сообщение для сохранения
     * @dev Принимает ETH через payable
     */
    function demo(string calldata _msg) external payable {
        message = _msg;      // Сохраняем сообщение
        amount = msg.value;  // Сохраняем полученный ETH
    }

    /**
     * @notice Возвращает текущее время + 60 секунд
     * @return Временная метка для тестирования
     */
    function getNextTimestamp() external view returns(uint) {
        return block.timestamp + 60; // Текущий блок + 1 минута
    }

    /**
     * @notice Кодирует строку в формат bytes
     * @param _msg Строка для кодирования
     * @return Закодированные данные
     */
    function prepareData(string calldata _msg) external pure returns(bytes memory) {
        return abi.encode(_msg); // Кодируем строку через abi.encode
    }

    /**
     * @notice Добавляет транзакцию в очередь
     * @param _to Адрес получателя
     * @param _func Сигнатура функции (пустая строка для fallback)
     * @param _data Данные вызова
     * @param _value Сумма ETH
     * @param _timestamp Время выполнения
     * @return txId Уникальный идентификатор транзакции
     */
    function addToQueue(
        address _to,
        string calldata _func,
        bytes calldata _data,
        uint _value,
        uint _timestamp
    ) external onlyOwner returns(bytes32) {
        // Проверка временного диапазона
        require(
            _timestamp > block.timestamp + MINIMUM_DELAY &&
            _timestamp < block.timestamp + MAXIMUM_DELAY,
            "invalid timestamp"
        );
        
        // Генерация уникального ID транзакции
        bytes32 txId = keccak256(abi.encode(_to, _func, _data, _value, _timestamp));
        // Проверка на существование в очереди
        require(!queue[txId], "already queued");

        queue[txId] = true; // Добавление в очередь
        // Создание новой транзакции
        txs[txId] = Transaction({
            uid: txId,
            to: _to,
            value: _value,
            data: _data,
            executed: false,
            confirmations: 0
        });

        emit Queued(txId); // Эмитим событие
        return txId;       // Возвращаем ID
    }

    /**
     * @notice Подтверждение транзакции владельцем
     * @param _txId ID транзакции для подтверждения
     */
    function confirm(bytes32 _txId) external onlyOwner {
        require(queue[_txId], "not queued!");          // Проверка очереди
        require(!confirmations[_txId][msg.sender], "already confirmed!"); // Проверка подтверждения

        Transaction storage transaction = txs[_txId]; // Получаем транзакцию
        transaction.confirmations++;                   // Увеличиваем счетчик
        confirmations[_txId][msg.sender] = true;       // Отмечаем подтверждение
    }

    /**
     * @notice Отмена подтверждения транзакции
     * @param _txId ID транзакции
     */
    function cancelConfirmation(bytes32 _txId) external onlyOwner {
        require(queue[_txId], "not queued!");        // Проверка очереди
        require(confirmations[_txId][msg.sender], "not confirmed!"); // Проверка подтверждения

        Transaction storage transaction = txs[_txId]; // Получаем транзакцию
        transaction.confirmations--;                  // Уменьшаем счетчик
        confirmations[_txId][msg.sender] = false;     // Снимаем подтверждение
    }

    /**
     * @notice Выполнение транзакции
     * @param _to Адрес получателя
     * @param _func Сигнатура функции
     * @param _data Данные вызова
     * @param _value Сумма ETH
     * @param _timestamp Время выполнения
     * @return resp Результат вызова
     */
    function execute(
        address _to,
        string calldata _func,
        bytes calldata _data,
        uint _value,
        uint _timestamp
    ) external payable onlyOwner returns(bytes memory) {
        require(block.timestamp > _timestamp, "too early");             // Проверка времени
        require(_timestamp + GRACE_PERIOD > block.timestamp, "tx expired"); // Проверка срока действия

        bytes32 txId = keccak256(abi.encode(_to, _func, _data, _value, _timestamp)); // Генерируем ID
        require(queue[txId], "not queued!"); // Проверка наличия в очереди

        Transaction storage transaction = txs[txId]; 
        require(transaction.confirmations >= CONFIRMATIONS_REQUIRED, "not enough confirmations!"); // Проверка подтверждений

        delete queue[txId];        // Удаление из очереди
        transaction.executed = true; // Отметка выполнения

        bytes memory data;
        if(bytes(_func).length > 0) {
            // Формируем данные для вызова функции
            data = abi.encodePacked(bytes4(keccak256(bytes(_func))), _data);
        } else {
            data = _data; // Fallback вызов
        }

        // Низкоуровневый вызов
        (bool success, bytes memory resp) = _to.call{value: _value}(data);
        require(success); // Проверка успешности

        emit Executed(txId); // Эмитим событие
        return resp;         // Возвращаем результат
    }

    /**
     * @notice Удаление транзакции из очереди
     * @param _txId ID транзакции
     */
    function discard(bytes32 _txId) external onlyOwner {
        require(queue[_txId], "not queued"); // Проверка очереди
        delete queue[_txId];                 // Удаление транзакции
        emit Discarded(_txId);               // Эмитим событие
    }
}