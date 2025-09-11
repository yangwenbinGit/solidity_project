// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

// 一个接收方合约（Receiver）可以接收消息和 Ether。
contract Receiver {
    event Received(address caller, uint amount, string message);

    // 1. fallback 函数
    // 当有人向这个合约发送 Ether 或调用一个不存在的函数时，就会进入这里。
    fallback() external payable {
        emit Received(msg.sender, msg.value, "Fallback was called");
    }

    // 2. 这是一个普通函数
    function foo(string memory _message, uint _x) public payable returns (uint) {
        emit Received(msg.sender, msg.value, _message);

        return _x + 1;
    }
}

// 一个发送方合约（Caller）如何在不知道源码的情况下，通过 .call 调用对方函数，甚至触发其 fallback。
contract Caller {
    event Response(bool success, bytes data);


    /**
         智能合约之间如何通过低级函数 .call 进行交互 在Caller这个合约中通过_addr.call(abi.encodeWithSignature("foo(string,uint256)", "call foo", 123))
         调用传入合约的方法,并且可以传递参数
    
    
    */
    // 1. 调用 Receiver 的 foo 函数
    function testCallFoo(address payable _addr) public payable {
        // You can send ether and specify a custom gas amount
        (bool success, bytes memory data) = _addr.call{value: msg.value, gas: 5000}(
            // 这就像你在不知道对方源码的情况下，仅凭函数签名和地址就能调用它！并且可以发送以太币和定义消耗的gas费用
            abi.encodeWithSignature("foo(string,uint256)", "call foo", 123)
        );

        emit Response(success, data);
    }

    // 2. 调用一个不存在的函数 就会触发fallback()方法的执行
    function testCallDoesNotExist(address _addr) public {
        (bool success, bytes memory data) = _addr.call(
            abi.encodeWithSignature("doesNotExist()")
        );

        emit Response(success, data);
    }
}