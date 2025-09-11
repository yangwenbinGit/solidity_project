// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract ReceiveEther {
    /*
    Which function is called, fallback() or receive()?

           send Ether
               |
         msg.data is empty?
              / \
            yes  no
            /     \
receive() exists?  fallback()
         /   \
        yes   no
        /      \
    receive()   fallback()
    */

    // Function to receive Ether. msg.data must be empty
    // 触发条件：当合约接收到一笔 纯 Ether 转账，并且 msg.data 完全为空。一般情况正常发送以太币走的都是这个 除非没有这个函数就会走fallback() 可以说是一个兜底
    receive() external payable {}

    // Fallback function is called when msg.data is not empty
    // 触发条件：
    // 1.调用了一个不存在的函数（即函数选择器在合约中找不到对应函数）。
    // 2.向合约发送了 Ether，并且 msg.data 不为空，但又没有匹配到任何已定义的函数。
    // 调用一个拼写错误的函数名。 向合约发送 Ether 并附带了一些无意义的数据。调用一个本应存在但因某种原因无法找到的函数。
    fallback() external payable {}

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract SendEther {
    function sendViaTransfer(address payable _to) public payable {
        // 这个函数不在建议使用去发送以太币
        _to.transfer(msg.value);
    }

    function sendViaSend(address payable _to) public payable {       
        // 这个函数会返回一个bool值 就是发送是否成功  现在不在建议使用去发送以太币
        bool sent = _to.send(msg.value);
        require(sent, "Failed to send Ether");
    }

    function sendViaCall(address payable _to) public payable {        
        // 这种call的方式也会返回一个成功与失败,同时还会返回data，这种方式推荐使用发送以太币
        (bool sent, ) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }
}