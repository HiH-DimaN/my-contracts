// SPDX-License-Identifier: MIT // Лицензия контракта
pragma solidity ^0.8.0; // Версия компилятора Solidity

import "./IERC20.sol"; // Импорт интерфейса IERC20 для взаимодействия с другими токенами

/**
 * @title ERC20
 * @dev Реализация токена стандарта ERC20.
 * @author HiH_DimaN
 * Контракт позволяет чеканить, сжигать токены, а также проводить их передачу и утверждение разрешений.
 */
contract ERC20 is IERC20 {
    uint totalTokens; // Общее количество токенов
    address owner; // Владелец контракта
    mapping(address => uint) balances; // Балансы каждого адреса
    mapping(address => mapping(address => uint)) allowances; // Разрешения (allowances) на перевод токенов
    string _name; // Имя токена
    string _symbol; // Символ токена
    uint _decimals; // Количество десятичных знаков

    /**
     * @dev Событие для логирования перевода токенов
     * @param from Адрес отправителя токенов
     * @param to Адрес получателя токенов
     * @param amount Количество токенов, переданных между адресами
     */
    event Transfer(address indexed from, address indexed to, uint amount); // Объявление события Transfer для перевода токенов

    /**
     * @dev Событие для логирования утверждения разрешения (approve)
     * @param owner Адрес владельца токенов, который выдал разрешение
     * @param spender Адрес, которому разрешено тратить токены
     * @param amount Количество токенов, разрешенных для использования
     */
    event Approve(address indexed owner, address indexed spender, uint amount); // Объявление события Approve для утверждения разрешений

    /**
     * @dev Возвращает имя токена.
     */
    function name() external view returns(string memory) {
        return _name; // Возвращает имя токена
    }

    /**
     * @dev Возвращает символ токена.
     */
    function symbol() external view returns(string memory) {
        return _symbol; // Возвращает символ токена
    }

    /**
     * @dev Возвращает количество десятичных знаков токена.
     */
    function decimals() external pure returns(uint) {
        return 18; // Устанавливает 18 знаков после запятой для дробной части токена
    }

    /**
     * @dev Возвращает общее количество токенов в обращении.
     */
    function totalSupply() external view returns(uint) {
        return totalTokens; // Возвращает общее количество токенов в обращении
    }

    /**
     * @dev Модификатор для проверки, что у отправителя достаточно токенов.
     */
    modifier enoughTokens(address _from, uint _amount) {
        require(balanceOf(_from) >= _amount, "not enough tokens!"); // Проверка, что у отправителя достаточно токенов для операции
        _;
    }

    /**
     * @dev Модификатор для проверки, что функция вызывается только владельцем контракта.
     */
    modifier onlyOwner() {
        require(msg.sender == owner, "not an owner!"); // Проверка, что вызов функции идет от владельца контракта
        _;
    }

    /**
     * @dev Конструктор, устанавливающий начальные параметры токена.
     */
    constructor(string memory name_, string memory symbol_, uint initialSupply, address shop) {
        _name = name_; // Установка имени токена
        _symbol = symbol_; // Установка символа токена
        owner = msg.sender; // Установка владельца контракта на текущий адрес
        mint(initialSupply, shop); // Вызов функции mint для начального выпуска токенов
    }

    /**
     * @dev Возвращает баланс указанного аккаунта.
     */
    function balanceOf(address account) public view returns(uint) {
        return balances[account]; // Возвращает текущий баланс указанного аккаунта
    }

    /**
     * @dev Перевод токенов на другой адрес.
     */
    function transfer(address to, uint amount) external enoughTokens(msg.sender, amount) {
        _beforeTokenTransfer(msg.sender, to, amount); // Вызов хука перед выполнением трансфера
        balances[msg.sender] -= amount; // Уменьшение баланса отправителя на указанное количество токенов
        balances[to] += amount; // Увеличение баланса получателя на указанное количество токенов
        emit Transfer(msg.sender, to, amount); // Логирование события Transfer для отслеживания перевода
    }

    /**
     * @dev Чеканка новых токенов.
     */
    function mint(uint amount, address shop) public onlyOwner {
        _beforeTokenTransfer(address(0), shop, amount); // Вызов хука перед выпуском новых токенов
        balances[shop] += amount; // Увеличение баланса магазина на количество новых токенов
        totalTokens += amount; // Увеличение общего количества токенов
        emit Transfer(address(0), shop, amount); // Логирование события Transfer для отслеживания выпуска новых токенов
    }

    /**
     * @dev Сжигание токенов (уменьшение их количества).
     */
    function burn(address _from, uint amount) public onlyOwner {
        _beforeTokenTransfer(_from, address(0), amount); // Вызов хука перед сжиганием токенов
        balances[_from] -= amount; // Уменьшение баланса адреса отправителя на указанное количество токенов
        totalTokens -= amount; // Уменьшение общего количества токенов
        emit Transfer(_from, address(0), amount); // Логирование события Transfer для отслеживания сжигания токенов
    }

    /**
     * @dev Возвращает количество токенов, которые разрешено перевести от имени владельца.
     */
    function allowance(address _owner, address spender) public view returns(uint) {
        return allowances[_owner][spender]; // Возвращает количество токенов, разрешенных для перевода от владельца к указанному адресату
    }

    /**
     * @dev Устанавливает разрешение для переводов токенов.
     */
    function approve(address spender, uint amount) public {
        _approve(msg.sender, spender, amount); // Внутренний вызов функции _approve для установки разрешения
    }

    /**
     * @dev Внутренняя функция для обновления разрешений.
     */
    function _approve(address sender, address spender, uint amount) internal virtual {
        allowances[sender][spender] = amount; // Устанавливает разрешение на использование токенов в пользу указанного адреса
        emit Approve(sender, spender, amount); // Логирование события Approve для отслеживания утверждения разрешений
    }

    /**
     * @dev Перевод токенов от имени отправителя.
     */
    function transferFrom(address sender, address recipient, uint amount) public enoughTokens(sender, amount) {
        _beforeTokenTransfer(sender, recipient, amount); // Вызов хука перед выполнением трансфера
        allowances[sender][recipient] -= amount; // Уменьшение разрешенного количества токенов для перевода
        balances[sender] -= amount; // Уменьшение баланса отправителя на указанное количество токенов
        balances[recipient] += amount; // Увеличение баланса получателя на указанное количество токенов
        emit Transfer(sender, recipient, amount); // Логирование события Transfer для отслеживания перевода токенов
    }

    /**
     * @dev Хук, вызываемый перед каждым переводом токенов.
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint amount
    ) internal virtual {} // Пустой хук, может быть переопределен в дочерних контрактах для добавления логики
}