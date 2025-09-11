// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "./42_Foo.sol";

// import {symbol1 as alias, symbol2} from "filename";
import {Unauthorized, add as func, Point} from "./42_Foo.sol";

contract Import {
    // Initialize Foo.sol
    Foo public foo = new Foo();

    // Test Foo.sol by getting it's name.
    function getFooName() public view returns (string memory) {
        // 解释这里为啥name需要加括号  
        // 因为 name 是一个 public 状态变量，Solidity 编译器会自动为它生成一个同名的 public getter 函数。
        // function name() public view returns (string memory) {
        //     return name;
        // }
        // 这个函数的作用就是读取并返回 name 变量的值。
        // 当你在另一个合约中访问 foo.name()：你实际上是在调用这个自动生成的 getter 函数。通过它获取name属性的值
        return foo.name();
    }
}