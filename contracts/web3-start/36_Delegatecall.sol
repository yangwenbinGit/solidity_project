// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

// NOTE: Deploy this contract first
contract B {
    // NOTE: storage layout must be the same as contract A
    uint public num;
    address public sender;
    uint public value;

    function setVars(uint _num) public payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}

// _contract.delegatecall  是以太坊智能合约中一个非常强大且需要谨慎使用的低级函数，它用于在当前合约的上下文中执行另一个合约的代码。
// 要理解 delegatecall，关键在于它与普通调用（如 call）的区别：

// 核心区别：执行上下文

// 普通调用 (call):
// 目标合约（被调用者）在它自己的上下文中执行。
// 它可以读取和修改它自己的存储（storage）变量。
// msg.sender 变为发起调用的合约（A 的地址），msg.value 是发送的 ETH 数量。

// 委托调用 (delegatecall):
// 目标合约的代码在调用者的上下文中执行。
// 这意味着：
// 代码来自 _contract：执行的是 _contract 合约中指定函数的字节码。
// 状态存储在 A 中：所有对存储（storage）的读写操作都发生在调用者合约 A 的存储空间里，而不是 _contract 的。
// msg.sender, msg.value 等保持不变（仍然是原始调用者的信息）。

// 说明: 如果使用_contract.delegatecall 他的所有操作其实是操作他自己合约内的变量,比如我们在A合约中执行setVars 传入参数(0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8,500)
// 地址是B合约的地址,值是500, 按照正常的理解他会调用B合约的方法 然后修改B合约对应的值 这种是错误的,call是这样的,但是delegatecall修改的是他自己合约的值,
// 所以当你执行完成A合约的方法后,num的值从原来的0变为了500


/**
你可以把它想象成“代理”或“委托”：
合约 A 说：“嘿，合约 B，我信任你，请B帮A运行B的 setVars 逻辑。” 
合约 B 的代码被执行了，但它操作的是 A 的“身体”（存储空间）。
A 委托 B 来执行任务，但任务的结果影响的是 A 自己。所以最终执行完成 B执行任务 操作A的身体 最终改变的值只有A的值和状态会发生改变  B的不会
*/

contract A {
    uint public num;
    address public sender;
    uint public value;

    function setVars(address _contract, uint _num) public payable {
        // A's storage is set, B is not modified.
        (bool success, bytes memory data) = _contract.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );
    }
}