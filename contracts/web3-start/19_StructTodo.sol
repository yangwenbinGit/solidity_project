// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

// 结构体 struct  todoList
contract StructTodo{
    
    struct Todo{
        string text;
        bool complete;
    }

    Todo[] internal  todoList;

    // 创建任务
    function create(string memory _text) public {
        // 第一种添加的方式
        // todoList.push(Todo(_text, false));

        // 第二种写法
        // todoList.push(Todo({text : _text, complete : false}));

        // 第三种写法
        Todo memory todo;
        todo.text = _text;
        todo.complete =  false;
        todoList.push(todo);
    }


    // 获取数组中的数据
    function get(uint _index) public view returns (string memory text, bool complete){
        Todo storage todo = todoList[_index];
        return (todo.text, todo.complete);
    }


    // 修改数据
    function update(uint _index, string memory _text) public{
        Todo storage todo = todoList[_index];
        todo.text = _text;
    }


    function toggleCompleted(uint _index) public {
        Todo storage todo = todoList[_index];
        todo.complete = !todo.complete;
    }
}