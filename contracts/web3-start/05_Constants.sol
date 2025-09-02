// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract  Constants {

    // constant表示是一个常量 不能被更改和赋值的 一般用于常量
    address public constant owner = 0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc;

    // 还有一个运行时候可以更改的 immutable 默认就是这个也可以不写
    address public owner1 = msg.sender;


    uint public constant MAX_SUPPLY = 10000;      // 1000000 tokens
}