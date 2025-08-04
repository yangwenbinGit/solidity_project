
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract Counter {
    
    // 这个是无符号的 不能表示负数 否则会报错
    uint public count;

    function get() public view returns (uint) {
        return count;
    }

    function incr() public {
        count += 1;
    }

    function desc() public {
        require(count > 0 , "Cannot decrement below zero");
        count -= 1;
    }


}