// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Todos {


    //Создание структуры
    struct Todo {
        string text;
        bool completed;
    }

    // Установка структуры в массив
    Todo[] public todos;

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
}