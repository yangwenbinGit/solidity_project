// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;


contract Payable {
    // 如果被payable修饰可以接收以太币
    address payable public owner;

    // Payable 修改的构造函数也可以接收以太币 msg.sender就是当前账户的地址
    constructor() payable {
        owner = payable(msg.sender);
    }

    // 这个可以接收以太币
    function deposit() public payable {}


    // 你要调用这个函数发送以太币会报错 因为他没有加payable属性 不能接收以太币
    function notPayable() public {}


    // 相当于将这个合约的余额全部转给合约账户 提现完成后余额为0了
    function withdraw() public {
        // 获取这个合约的余额
        uint amount = address(this).balance;
        
        // 发送所有的以太币给自己 owner能够接收以太币从这个合约  因为他是被payable修饰的
        (bool success, ) = owner.call{value: amount}("");
        require(success, "Failed to send Ether");
    }

     // 这个函数可以转账以太币给别的地址 (0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2, 50000)
    function transfer(address payable _to, uint _amount) public {
        // Note that "to" is declared as payable
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Failed to send Ether");
    }
}