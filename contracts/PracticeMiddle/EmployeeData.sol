// Contract with Array of Structures.
// Create a contract that uses an array of structures to store data.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/* @title Контракт для хранения данных о сотрудниках компании
 * @author HiH_DimaN
 * @notice Этот контракт демонстрирует использование массива структур для хранения данных
 */
contract EmployeeData {
    
    /* @notice Структура для хранения информации о сотруднике
     */
    struct Employee {
        uint256 id; // ID сотрудника
        string name; // Имя сотрудника
        uint256 salary; // зарплата сотрудника
    }

    /* @notice Массив для хранения данных о сотрудниках
     */
    Employee[] public employees;

    /* @notice Функция для добавления нового сотрудника
     * @param _id ID сотрудника
     * @param _name Имя сотрудника
     * @param _salary Зарплата сотрудника
     */
    function addEmploye(uint256 _id, string memory _name, uint256 _salary) public {
        employees.push(Employee(_id, _name, _salary));
    }

    /* @notice Функция для получения данных о сотруднике по его индексу в массиве
     * @param _index Индекс сотрудника в массиве
     * @return id ID сотрудника
     * @return name Имя сотрудника
     * @return salary Зарплата сотрудника
     */
    function getEmployee(uint256 _index) public view returns(uint256 id, string memory name, uint256 salary) {
        require(_index <= employees.length, "Invalid employee index");
        Employee memory employee = employees[_index];
        return(employee.id, employee.name, employee.salary);
    }

    /* @notice Функция для получения количества сотрудников
     * @return Количество сотрудников в массиве
     */
    function getEmployeeCount() public view returns(uint256) {
        return employees.length;
        
    }




    
}