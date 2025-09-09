// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract X {
    string public name;

    constructor(string memory _name){
        name = _name;
    }
}

contract Y {

    string public text;

    constructor(string memory _text){
        text = _text;
    }
}

// 合约B 继承了合约X Y
contract B is X("Input to X"), Y("Input to Y") {
    
}

// 合约C 继承了合约X Y 在构造函数中传值
contract C is X, Y{
    constructor(string memory _name, string memory _text) X(_name) Y(_text){

    }
}

contract D is X,Y{
    constructor() X("Input to X") Y("Input to Y"){}
}


contract E is X,Y {
    constructor() Y("Y was called") X("X was called"){}
}

