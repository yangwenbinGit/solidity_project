// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract Fallback {
    event Log(uint gas);


    // Fallback function must be declared as external.
    fallback() external payable {
        // send / transfer (forwards 2300 gas to this fallback function)
        // call (forwards all of the gas)
        emit Log(gasleft());
    }

    // Helper function to check the balance of this contract
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}


/**
        在 Solidity 中，有三种常见的向地址发送 Ether 的方式：
        address.transfer(amount)	      ⚠️ 不推荐（已过时）	       只传递 2300 gas，容易失败
        address.send(amount)	          ⚠️ 不推荐（已过时）	       同上，还需手动处理返回值
        address.call{value: amount}("")	  ✅ 推荐	                 灵活、安全、可控

        不推荐的原因:
        1.固定只提供 2300 gas	这是为简单收款设计的 gas 量，不足以触发复杂逻辑
        2.如果接收方合约需要更多 gas 来执行 receive() 或 fallback() 函数，转账就会失败。
        3.Solidity 官方文档从 0.8.x 开始明确建议使用 .call 替代。

        推荐使用call去发送以太币:
        1.默认传递所有可用 gas（除非手动限制）
        2.更灵活，兼容任何接收方（EOA 或合约）

*/
contract SendToFallback {
    function transferToFallback(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    function callFallback(address payable _to) public payable {
        (bool sent, ) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }
}