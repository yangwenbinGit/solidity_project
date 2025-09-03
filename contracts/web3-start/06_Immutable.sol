// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;


// immutable 是 Solidity 语言中的一个关键字，用于声明在合约部署时初始化、之后永远不可更改的变量。 常用在构造函数赋值使用
contract Immutable {

    address public immutable ADDRESS_VALUE;

    uint public immutable UINT_VALUE;

    uint64 public immutable UINT64_VALUE;

    constructor(){
        ADDRESS_VALUE = msg.sender;
        UINT_VALUE = 50900;
        UINT64_VALUE = 1000000000;
    }




}