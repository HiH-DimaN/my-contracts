// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (utils/Counters.sol)

pragma solidity ^0.8.20; /// @notice Указываем версию компилятора

/**
 * @title Counters
 * @dev Библиотека для управления счетчиками, которые можно увеличивать, уменьшать или сбрасывать. 
 * Подходит для использования с уникальными идентификаторами, такими как идентификаторы токенов или запросов.
 */
library Counters {
    /// @dev Структура, представляющая счетчик.
    struct Counter {
        uint256 _value; /// @notice Внутреннее значение счетчика.
    }

    /**
     * @notice Возвращает текущее значение счетчика.
     * @param counter Счетчик, значение которого нужно получить.
     * @return Текущее значение счетчика.
     */
    function current(Counter storage counter) internal view returns (uint256) {
        return counter._value; // Возвращает текущее значение счетчика.
    }

    /**
     * @notice Увеличивает значение счетчика на 1.
     * @param counter Счетчик, который нужно увеличить.
     */
    function increment(Counter storage counter) internal {
        unchecked { // Отключаем проверку на переполнение.
            counter._value += 1; // Увеличиваем значение счетчика на 1.
        }
    }

    /**
     * @notice Уменьшает значение счетчика на 1.
     * @param counter Счетчик, который нужно уменьшить.
     * @dev Генерирует ошибку, если текущее значение равно 0, чтобы избежать переполнения.
     */
    function decrement(Counter storage counter) internal {
        uint256 value = counter._value; // Сохраняем текущее значение для проверки.
        require(value > 0, "Counter: decrement overflow"); // Проверяем, что значение больше 0.
        unchecked { // Отключаем проверку на переполнение.
            counter._value = value - 1; // Уменьшаем значение счетчика на 1.
        }
    }

    /**
     * @notice Сбрасывает значение счетчика до 0.
     * @param counter Счетчик, который нужно сбросить.
     */
    function reset(Counter storage counter) internal {
        counter._value = 0; // Устанавливаем значение счетчика в 0.
    }
}
