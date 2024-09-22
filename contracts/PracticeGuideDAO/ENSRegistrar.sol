//SPDX-License-Identifier: GPL-3.0 
pragma solidity ^0.8.0;

// Объявление контракта
contract ENSRegistrar {
    // Структура, хранящая информацию о домене
    struct DomainInfo {
        address owner; // Владелец домена
        uint priceReg; // Цена регистрации домена
        uint timestamp; // Время создания домена
        uint registrationYears; // Срок регистрации в годах
    }

    // Сопоставление доменного имени со структурой DomainInfo
    mapping(string => DomainInfo) public domains;

    // Переменные для хранения адреса ENS контракта, цены за год регистрации и коэффициента продления
    address public ensAddress;
    uint public registrationPricePerYear;
    uint public renewalCoefficient;
    uint constant public MIN_REGISTRATION_YEARS = 1;
    uint constant public MAX_REGISTRATION_YEARS = 10;

    // Переменная для хранения владельца контракта
    address public owner;

    // Событие для уведомления о успешной регистрации домена
    event DomainRegistred(string domain, address owner, uint priceReg, uint timestamp, uint registrationYears);

    // Конструктор контракта
    constructor(uint _registrationPricePerYear, uint _renewalCoefficient) {
        owner = msg.sender;
        registrationPricePerYear = _registrationPricePerYear;
        renewalCoefficient = _renewalCoefficient;
    }

    // Модификатор для проверки, что вызывающий адрес является владельцем контракта
    modifier onlyOwner() {
        require(msg.sender == owner, "Only contract owner can call this function");
        _;
    }

    // Сеттер для цены регистрации за год
    function setRegistrationPricePerYear(uint _registrationPricePerYear) external onlyOwner {
        registrationPricePerYear = _registrationPricePerYear;
    }

    // Сеттер для коэффициента продления
    function setRenewalCoefficient(uint _renewalCoefficient) external onlyOwner {
        renewalCoefficient = _renewalCoefficient;
    }

    // Функция для регистрации домена
    function registerDomain(string memory domain, uint registrationYears) external payable {
        // Проверяем, что пользователь заплатил достаточную сумму для регистрации
        uint totalRegistrationPrice = registrationPricePerYear * registrationYears;
        require(msg.value >= totalRegistrationPrice, "Insufficient funds");

        // Проверяем, что срок регистрации в пределах минимального и максимального значения
        require(registrationYears >= MIN_REGISTRATION_YEARS && registrationYears <= MAX_REGISTRATION_YEARS, "Invalid registration years");

        // Проверяем, что домен свободен
        require(domains[domain].owner == address(0) || block.timestamp >= domains[domain].timestamp + domains[domain].registrationYears * 365 days, "Domain already registered");

        // Создаем новую запись о регистрации домена
        domains[domain] = DomainInfo({
            owner: msg.sender,
            priceReg: totalRegistrationPrice,
            timestamp: block.timestamp,
            registrationYears: registrationYears
        });     

        // Отправляем событие о регистрации домена
        emit DomainRegistred(domain, msg.sender, totalRegistrationPrice, block.timestamp, registrationYears);
    }

    // Функция для продления домена
    function renewDomain(string memory domain, uint renewalYears) external payable {
        // Проверяем, что домен принадлежит отправителю
        require(domains[domain].owner == msg.sender, "You are not the owner of this domain");
        
        // Подсчитываем цену продления
        uint renewalPrice = domains[domain].priceReg * renewalCoefficient * renewalYears;
        require(msg.value >= renewalPrice, "Insufficient funds");

        // Обновляем информацию о домене
        domains[domain].priceReg = renewalPrice;
        domains[domain].timestamp = block.timestamp;
        domains[domain].registrationYears += renewalYears;

        // Отправляем событие о продлении домена
        emit DomainRegistred(domain, msg.sender, renewalPrice, block.timestamp, domains[domain].registrationYears);
    }

    // Функция для получения адреса владельца домена
    function getDomainOwner(string memory domain) external view returns (address) {
        return domains[domain].owner;
    }

    // Функция для снятия средств с контракта
    function withdraw() external onlyOwner {
        // Получаем текущий баланс контракта
        uint contractBalance = address(this).balance;
        // Переводим все средства с контракта на адрес владельца контракта
        payable(owner).transfer(contractBalance);
    }
}