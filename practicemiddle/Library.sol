// Structure Mapping Contract.
// Write a contract that uses structure mapping to store data.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/* @title Контракт для хранения данных о книгах в библиотеке
 * @author HiH_DimaN
 * @notice Этот контракт демонстрирует использование маппинга структур для хранения данных
 */
contract Library {

    /* @notice Структура для хранения информации о книге
     */
    struct Book {
        string title; // Название книги
        string author; // Автор книги
        uint256 year; // Год издания
        bool available; // Доступность книги (true - доступна, false - нет)
    }

    /* @notice Маппинг для хранения данных о книгах. 
     * @dev Ключ - ISBN книги (строка), значение - структура Book
     */
    mapping (string => Book) public books;

    /* @notice Функция для добавления новой книги в библиотеку
     * @param _isbn ISBN книги
     * @param _title Название книги
     * @param _author Автор книги
     * @param _year Год издания
     */
    function addBook(string memory _isbn, string memory _title, string memory _author, uint256 _year) public {
       books[_isbn] = Book(_title, _author, _year, true);
    }

    /* @notice Функция для получения информации о книге по ISBN
     * @param _isbn ISBN книги
     * @return title Название книги
     * @return author Автор книги
     * @return year Год издания
     * @return available Доступность книги
     */
    function getBook(string memory _isbn) public view returns(string memory title, string memory author, uint256 year, bool available){
        Book memory book = books[_isbn];
        return (book.title, book.author, book.year, book.available); 
    }

    /* @notice Функция для изменения статуса доступности книги
     * @param _isbn ISBN книги
     * @param _available Новый статус доступности книги
     */
    function setBookAvailability(string memory _isbn, bool _avialable) public {
        books[_isbn].available = _avialable; 
    }
}