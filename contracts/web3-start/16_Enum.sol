// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

// 枚举
contract Enum{
    enum Status {
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Canceled
    }

    // 默认就是枚举中的第一个元素 Pending
    Status public status;

     // Returns uint
    // Pending  - 0
    // Shipped  - 1
    // Accepted - 2
    // Rejected - 3
    // Canceled - 4
    function get() public view  returns (Status){
        return status;
    }

    // // Update status by passing uint into input
    function set(Status _status) public{
        status = _status;
    }


    function cancel() public {
        status = Status.Canceled;
    }

    function reset() public {
        delete status;
    }



}