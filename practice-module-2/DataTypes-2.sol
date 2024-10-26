// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Todos {

    // Создание enum с опциями для "Доставки"
    enum Status {
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Canceled
    }

    // Значение по умолчанию - первый элемен в enum - Pending

    // Установка enum в переменную
    Status public status;


    //Создание структуры
    struct Todo {
        string text;
        bool completed;
    }

    // Установка структуры в массив
    Todo[] public todos;

     // Способы создания массивов
    uint[] public arr;
    uint[] public arr2 = [1, 2, 3];
    // Массив с фиксированной длинной, где все значения = 0
    uint[10] public myFixedSizeArr;


    function create(string calldata _text) public {
        // Три способа установки значение в struct в массив
        // - через вызов push
        todos.push(Todo(_text, false));

        // - через вызов push с указание ключей
        todos.push(Todo({text: _text, completed: false}));

        // - инициализация struct в памяти функции
        Todo memory todo;
        todo.text = _text; //установка значений напрямую
        // todo.completed уже будет установлено по умолчанию на false

        todos.push(todo); // помещение в массив для сохранения
    }

    // Обновление одного из значений в struct
    function updateText(uint _index, string calldata _text) public {
        Todo storage todo = todos[_index]; //вначале нужно достать его из памяти контракта
        todo.text = _text; // затем обновить значение
    }

    // Установка completed на true (альтернативный способ вместо todo.completed = true)
    function toggleCompleted(uint _index) public {
        Todo storage todo = todos[_index];
        todo.completed = !todo.completed;
    }

    function get() public view returns (Status) {
        //Получение значения переменной
        return status;
    }

    // Update status by passing uint into input
    function set(Status _status) public {
        //Установка опций в переменную
        status = _status;
    }

    // Обновление опции в переменной напрямую
    function cancel() public {
        status = Status.Canceled;
    }

    // Обнуление переменной - установка опции по умолчанию - Pending
    function reset() public {
        delete status;
    }

    function getArrIndex(uint i) public view returns (uint) {
        return arr[i];
    }

    // Так можно получить весь массив. 
    // Однако нужно избегать такого решения со слишком большими массивами,
    // так как они могут использовать весь газ и обвалить транзакцию
    function getArr() public view returns (uint[] memory) {
        return arr;
    }

    function push(uint i) public {
        // Добавление значения в массив. 
        // В данном случае можно добавить число
        arr.push(i);
    }

    function pop() public {
        // Удаление последнего элемента из массива
        // Также уменьшает его длину
        arr.pop();
    }

    //Получение длины массива
    function getLength() public view returns (uint) {
        return arr.length;
    }

    function remove(uint index) public {
        // Обнуление значения по индексу
        // Не изменяет длину массива
        delete arr[index];
    }

    function examples() external pure{
        // Так создаются массивы с фиксированной длиной в функциях
        // Массив с динамической длиной в функции создать невозможно
        uint[] memory a = new uint[](5);
    }
}