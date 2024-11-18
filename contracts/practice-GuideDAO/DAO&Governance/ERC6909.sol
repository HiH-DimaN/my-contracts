// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.0;

import {IERC6909} from "./IERC6909.sol";

/*
* @title ERC6909 Multi-Token Reference Implementation
* @author HiH_DimaN
*/
contract ERC6909 is IERC6909 {
    /*
    * @dev Выбрасывается, когда баланс владельца для указанного идентификатора недостаточен.
    * @param owner Адрес владельца.
    * @param id Идентификатор токена.
    */
    error InsufficientBalance(address owner, uint256 id);
    
    /*
    * @dev Выбрасывается, когда разрешение оператора для указанного идентификатора недостаточно.
    * @param spender Адрес оператора.
    * @param id Идентификатор токена.
    */
    error InsufficientPermission(address spender, uint256 id);

    mapping(address owner => mapping(uint256 id => uint256 amount)) public balanceOf; // Хранение баланса токенов для каждого владельца и идентификатора.

    mapping(address owner => mapping(address spender => mapping(uint256 id => uint256 amount))) public allowance; // Хранение разрешений на использование токенов для владельца и оператора.

    mapping(address owner => mapping(address spender => bool)) public isOperator; // Проверка, является ли указанный адрес оператором владельца.

    /**
     * @notice Проверяет, поддерживает ли контракт интерфейс.
     * @param interfaceId Идентификатор интерфейса, согласно ERC-165.
     * @return supported Возвращает true, если контракт поддерживает указанный интерфейс.
     */
    function supportsInterface(bytes4 interfaceId) public pure returns (bool supported) {
        return interfaceId == 0x0f632fb3 || interfaceId == 0x01ffc9a7; // Проверка идентификаторов интерфейсов.
    }

    /**
     * @notice Переводит токены от отправителя к получателю.
     * @param receiver Адрес получателя токенов.
     * @param id Идентификатор токена.
     * @param amount Количество токенов для перевода.
     * @return Возвращает true, если операция выполнена успешно.
     */
    function transfer(address receiver, uint256 id, uint256 amount) public returns (bool) {
        if (balanceOf[msg.sender][id] < amount) revert InsufficientBalance(msg.sender, id); // Проверка наличия достаточного баланса у отправителя.
        balanceOf[msg.sender][id] -= amount; // Снижение баланса отправителя.
        balanceOf[receiver][id] += amount; // Увеличение баланса получателя.
        emit Transfer(msg.sender, msg.sender, receiver, id, amount); // Генерация события перевода токенов.
        return true; // Успешное завершение функции.
    }

    /**
     * @notice Переводит токены от одного адреса к другому с проверкой разрешений.
     * @param sender Адрес отправителя токенов.
     * @param receiver Адрес получателя токенов.
     * @param id Идентификатор токена.
     * @param amount Количество токенов для перевода.
     * @return Возвращает true, если операция выполнена успешно.
     */
    function transferFrom(address sender, address receiver, uint256 id, uint256 amount) public returns (bool) {
        if (sender != msg.sender && !isOperator[sender][msg.sender]) { // Проверка, является ли вызвавший оператором или отправителем.
            uint256 senderAllowance = allowance[sender][msg.sender][id]; // Получение текущего разрешения.
            if (senderAllowance < amount) revert InsufficientPermission(msg.sender, id); // Проверка достаточного разрешения.
            if (senderAllowance != type(uint256).max) {
                allowance[sender][msg.sender][id] = senderAllowance - amount; // Обновление разрешения при условии, что оно не максимальное.
            }
        }
        if (balanceOf[sender][id] < amount) revert InsufficientBalance(sender, id); // Проверка баланса отправителя.
        balanceOf[sender][id] -= amount; // Снижение баланса отправителя.
        balanceOf[receiver][id] += amount; // Увеличение баланса получателя.
        emit Transfer(msg.sender, sender, receiver, id, amount); // Генерация события перевода токенов.
        return true; // Успешное завершение функции.
    }

    /**
     * @notice Устанавливает разрешение на использование токенов для указанного оператора.
     * @param spender Адрес оператора.
     * @param id Идентификатор токена.
     * @param amount Количество токенов, на которые выдается разрешение.
     * @return Возвращает true, если операция выполнена успешно.
     */
    function approve(address spender, uint256 id, uint256 amount) public returns (bool) {
        allowance[msg.sender][spender][id] = amount; // Установка разрешения для оператора.
        emit Approval(msg.sender, spender, id, amount); // Генерация события установки разрешения.
        return true; // Успешное завершение функции.
    }

    /**
     * @notice Назначает или отменяет оператора для отправителя.
     * @param spender Адрес оператора.
     * @param approved Статус оператора (true для назначения, false для отмены).
     * @return Возвращает true, если операция выполнена успешно.
     */
    function setOperator(address spender, bool approved) public returns (bool) {
        isOperator[msg.sender][spender] = approved; // Установка или отмена оператора.
        emit OperatorSet(msg.sender, spender, approved); // Генерация события о назначении оператора.
        return true; // Успешное завершение функции.
    }

    /**
     * @notice Создает новые токены и начисляет их указанному получателю.
     * @dev ВНИМАНИЕ: важные проверки безопасности должны предшествовать вызовам этого метода.
     * @param receiver Адрес получателя токенов.
     * @param id Идентификатор токена.
     * @param amount Количество токенов для создания.
     */
    function _mint(address receiver, uint256 id, uint256 amount) internal virtual { 
        // ВНИМАНИЕ: важные проверки безопасности должны предшествовать вызовам этого метода.
        balanceOf[receiver][id] += amount; // Увеличение баланса получателя.
        emit Transfer(msg.sender, address(0), receiver, id, amount); // Генерация события создания токенов.
    }

    /**
     * @notice Сжигает токены у указанного отправителя.
     * @param sender Адрес отправителя токенов.
     * @param id Идентификатор токена.
     * @param amount Количество токенов для сжигания.
     */
    function _burn(address sender, uint256 id, uint256 amount) internal virtual {
        if (sender != msg.sender && !isOperator[sender][msg.sender]) { // Проверка прав оператора или отправителя.
            uint256 senderAllowance = allowance[sender][msg.sender][id]; // Получение текущего разрешения.
            if (senderAllowance < amount) revert InsufficientPermission(msg.sender, id); // Проверка достаточного разрешения.
            if (senderAllowance != type(uint256).max) {
                allowance[sender][msg.sender][id] = senderAllowance - amount; // Обновление разрешения при условии, что оно не максимальное.
            }
        }
        balanceOf[sender][id] -= amount; // Снижение баланса отправителя.
        emit Transfer(msg.sender, sender, address(0), id, amount); // Генерация события сжигания токенов.
    }

}
