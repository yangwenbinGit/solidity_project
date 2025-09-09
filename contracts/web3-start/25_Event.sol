// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

// 事件
contract Event {
    
    // 定义事件
    // 在 Solidity 智能合约中，indexed 是一个关键字，用于修饰 event（事件）中的参数。
    /**
    indexed 参数：
        1.被 indexed 修饰的参数（如 address indexed sender），其值的哈希（hash） 会被存储在日志的“topics”（主题）区域。
        2.优点：外部应用（如 web3.js、ethers.js）可以通过这个 indexed 字段高效地过滤日志。
        3.限制：每个事件最多只能有 3 个 indexed 参数。
        4.类型限制：只能用于 bytes、string、address、uint 等值类型（不能是动态数组或结构体）。
    */

    event Log(address indexed sender, string message);

    event AnotherLog();

    function test() public {
        // 触发事件
        emit Log(msg.sender, "Hello World");
        emit Log(msg.sender, "Hello EVM");
        emit AnotherLog();
    }
}
