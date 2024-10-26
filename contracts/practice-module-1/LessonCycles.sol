// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Cycles
 * @author HiH_DimaN
 * @notice Контракт для демонстрации работы с циклами в Solidity.
 */
contract Cycles {
    /**
     * @dev Переменная для хранения значения.
     */
    uint public i; // Переменная для хранения значения

    /**
     * @dev Функция для демонстрации циклов for и while.
     */
    function setNumber() public pure {
        // Цикл for
        for (uint x; x < 10; x++) {
            if (x == 3) {
                continue; // Пропускаем итерацию, если x равен 3
            }
            if (x == 5) {
                break; // Прерываем цикл, если x равен 5
            }
        }

        // Цикл while
        uint j = 0; // Инициализируем счетчик
        
        while (j < 10) { // Выполняем цикл, пока j меньше 10
            j++; // Увеличиваем счетчик
        }
    }
}