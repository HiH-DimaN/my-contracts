// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.20; // Установка версии компилятора Solidity

import "./IERC165.sol"; // Импорт интерфейса IERC165 для реализации стандартных функций проверки интерфейсов

/**
 * @title ERC165
 * @dev Реализация стандарта ERC165 для проверки поддерживаемых интерфейсов.
 * @author HiH_DimaN
 * Контракт предоставляет функцию для проверки поддерживаемых интерфейсов.
 */
contract ERC165 is IERC165 {
    
    /**
     * @dev Функция для проверки, поддерживает ли контракт указанный интерфейс.
     * @param interfaceId Идентификатор интерфейса для проверки.
     * @return bool Возвращает true, если интерфейс поддерживается, иначе false.
     */
    function supportsInterface(bytes4 interfaceId) public view virtual returns(bool) {
        return interfaceId == type(IERC165).interfaceId; // Проверка, соответствует ли переданный интерфейс интерфейсу IERC165
    }
}
