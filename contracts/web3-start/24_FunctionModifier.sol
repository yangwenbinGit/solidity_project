// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

// 函数修改
contract FunctionModifier {
    address public  owner;
    uint public x =10;
    bool public  locked;

    constructor(){
        owner = msg.sender;
    }


    /**
        modifier 是什么？
        modifier（修饰器）是 Solidity 中一种可重用的代码块，用于在函数执行前（有时也在执行后）添加一些条件检查或前置逻辑。

        你可以把它理解为：给函数“加个标签”或“加个守门员”，只有通过检查的调用才能继续执行函数体。

        想象一个 VIP 俱乐部：
        门口有个保安（modifier onlyOwner）
        每个人想进去（调用函数），都必须先过保安这关
        保安检查：你是老板吗？不是？滚！是？放行！
    
    */
    modifier onlyOwner(){
        require(owner == msg.sender, "Not owner"); // 保安检查
        _;  // 通过放行, _;Solidity 中专用于修饰器（modifier）的特殊占位符。 表示继续执行原函数的代码的指令
    }

    modifier vaildAddress(address addr){
        require(addr != address(0), "Not vaild address");
        _;
    }

    function changeOwner(address _newOwner) public onlyOwner vaildAddress(_newOwner){
        owner = _newOwner;
    }

    modifier noReentrancy(){
        require(!locked, "No reentrancy");

        // 进来以后加锁 执行后续函数 执行完成后释放锁定
        locked = true;
        _;
        locked = false;
    }

    function decrement(uint i) public noReentrancy{
        x -= i;
        if(x >1){
            decrement(i -1);
        }
    }


}