
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract Counter {
    
    // 这个是无符号的 不能表示负数 否则会报错 uint不写长度默认256 不赋值的话默认为0
    uint public count;

    function get() public view returns (uint) {
        return count;
    }

    function incr() public {
        count += 1;
    }

    function desc() public {
        // require的话如果 条件不满足的话  就会抛出后面的报错信息
        // require(count > 0 , "Cannot decrement below zero");

        // TODO 下面的写法和上面的写法是一样的
        if(count <= 0){
            // revert 直接抛出错误信息
            revert("Cannot decrement below zero");
        }
        count -= 1;
    }


}