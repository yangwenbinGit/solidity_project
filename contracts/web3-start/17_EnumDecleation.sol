// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

// 定义全局的枚举类
enum Status {
    Pending,
    Shipped,
    Accepted,
    Rejected,
    Canceled
}

// 定义全局的结构体
struct Todo {
    string text;
    bool completed;
}