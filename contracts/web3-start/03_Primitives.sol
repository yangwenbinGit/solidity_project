
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract Primitives {
    
    // bool类型定义 类型 访问权限变量  字段名  = 值
    bool public boo = false;

   // 无符号的整数类型的定义 
    uint8 public u8 = 10;
    uint256 public u256 = 456;
    uint16 public udefault = 8;

    // 可以带符号的
    int8 public i8 = -10;
    int256 public i256 = 90;
    int public i = -9000;

    // int类型的最小值和最大值
    int public min = type(int).min;
    int public max = type(int).max;

    // 地址类型的标识
    address public add = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;


    // bytes
    bytes public by = "123456";
    bytes1 public b1 = 0x56;  // 这个是一个16进制的


    // 默认值
    bool public boo1; // false
    uint public u; // 0
    int public ab; // 0
    address public add1; // 0x0000000000000000000000000000000000000000
    bytes public by1; // 0x 


}