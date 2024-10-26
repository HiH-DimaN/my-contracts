// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title ContractThree
 * @author HiH_DimaN
 * @notice Контракт, который выполняет простую арифметическую операцию.
 */
contract ContractThree {
    uint public result; // Переменная для хранения результата вычислений

    /**
     * @dev Функция для выполнения вычислений, складывает два числа.
     * @param a Первое число.
     * @param b Второе число.
     * @return Результат сложения.
     */
    function doCalculation(uint a, uint b) public returns (uint) {
        result = a + b; // Складываем два числа
        return result; // Возвращаем результат
    }
}

/**
 * @title ContractOne
 * @author HiH_DimaN
 * @notice Контракт, который использует delegatecall для вызова функций в ContractThree.
 */
contract ContractOne {
    address public contractThree; // Адрес контракта ContractThree
    uint public result; // Переменная для хранения результата вычислений

    /**
     * @dev Конструктор, принимающий адрес контракта ContractThree.
     * @param _contractThree Адрес контракта ContractThree.
     */
    constructor(address _contractThree) {
        contractThree = _contractThree; // Устанавливаем адрес контракта ContractThree
    }

    /**
     * @dev Функция для получения эфира.
     */
    receive() external payable {}

    /**
     * @dev Fallback функция, которая использует delegatecall для вызова функций в ContractThree.
     */
    fallback() external payable {
        // Логируем вызов fallback функции
        emit FallbackCalled(msg.data); // Отправляем событие о вызове fallback функции

        // Вызов delegatecall
        (bool success, bytes memory data) = contractThree.delegatecall(msg.data); // Вызываем delegatecall
        require(success, "Delegatecall failed"); // Проверяем успешность вызова

        // Логируем результат вызова delegatecall
        emit DelegatecallResult(success, data); // Отправляем событие о результате вызова delegatecall

        // Если функция возвращает результат, декодируем и сохраняем его
        if (data.length > 0) {
            result = abi.decode(data, (uint)); // Декодируем результат и сохраняем в переменную result
        }
    }

    /**
     * @dev Событие для логирования вызова fallback функции.
     * @param data Данные, переданные в fallback функцию.
     */
    event FallbackCalled(bytes data);

    /**
     * @dev Событие для логирования результата delegatecall.
     * @param success Успешность вызова delegatecall.
     * @param data Данные, возвращенные delegatecall.
     */
    event DelegatecallResult(bool success, bytes data);
}

/**
 * @title ContractTwo
 * @author HiH_DimaN
 * @notice Контракт, который вызывается для взаимодействия с ContractOne.
 */
contract ContractTwo {
    /**
     * @dev Функция для вызова fallback функции в ContractOne.
     * @param contractOneAddress Адрес контракта ContractOne.
     * @param a Первое число для вычислений.
     * @param b Второе число для вычислений.
     * @return Данные, возвращенные функцией doCalculation в ContractThree.
     */
    function callContractOne(address contractOneAddress, uint a, uint b) public returns (bytes memory) {
        // Кодируем вызов функции doCalculation с параметрами a и b
        bytes memory payload = abi.encodeWithSignature("doCalculation(uint256,uint256)", a, b); // Кодируем данные для вызова doCalculation
        
        // Вызываем fallback функцию в ContractOne
        (bool success, bytes memory returnData) = contractOneAddress.call{value: 0}(payload); // Вызываем fallback функцию ContractOne
        require(success, "Call to ContractOne failed"); // Проверяем успешность вызова
        
        return returnData; // Возвращаем данные, полученные от ContractOne
    }
}





