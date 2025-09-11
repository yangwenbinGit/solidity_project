// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

// 在智能合约之间进行函数调用以及如何传递 Ether
contract Callee {
    uint public x;
    uint public value;

    function setX(uint _x) public returns (uint) {
        x = _x;
        return x;
    }

    function setXandSendEther(uint _x) public payable returns (uint, uint) {
        x = _x;
        value = msg.value;

        return (x, value);
    }
}

contract Caller {
    // 调用 Callee 实例的 setX 函数
    // 知识点：
    //     _callee 是一个 Callee 类型的合约实例。
    //     直接调用 _callee.setX(_x)，就像调用对象方法一样。
    //     接收返回值 uint x（虽然这里没做其他操作）。
    //     不涉及 Ether 转移。
    function setX(Callee _callee, uint _x) public {
        uint x = _callee.setX(_x);
    }


    // 通过一个原始地址 _addr 来调用 Callee 的函数。
    // 知识点：
    //     Callee(_addr) 是一种类型转换（type casting），告诉编译器“这个地址指向的是一个 Callee 合约”。
    //     这在你只知道合约地址但没有直接引用时非常有用（例如，在前端或通用合约中）。
    //     安全性依赖于传入的地址确实是合法的 Callee 合约。
    function setXFromAddress(address _addr, uint _x) public {
        Callee callee = Callee(_addr);
        callee.setX(_x);
    }

    // 作用: 调用一个 payable 函数并向目标合约发送 Ether。
    // 知识点：
    //     函数本身是 payable，意味着调用者可以发送 ETH 给 Caller。
    //     {value: msg.value} 是关键！这是 Solidity 中指定发送多少 Ether 给被调用合约的语法。
    //     msg.value 是调用此函数时发送到 Caller 的 ETH 数量。
    //     {value: ...} 选项将这些 ETH 转发给 Callee 合约。
    //     (uint x, uint value) = ...：接收多返回值。
    //     这是实现“代理转账”或“中继调用”的基础。
    function setXandSendEther(Callee _callee, uint _x) public payable {
        (uint x, uint value) = _callee.setXandSendEther{value: msg.value}(_x);
    }
}