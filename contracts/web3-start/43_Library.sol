// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;


/**
什么是 library？
    在 Solidity 中，library 是一种特殊的合约类型，用于封装可重用的函数，通常用于实现安全的操作或通用工具函数。可以理解为就是工具类
    “一个存放纯函数的工具箱”，它不保存状态，也不拥有 Ether，只提供功能。

*/

// SafeMath 库：防止整数溢出
library SafeMath {
    function add(uint x, uint y) internal pure returns (uint) {
        uint z = x + y;
        require(z >= x, "uint overflow");

        return z;
    }
}

// Math 库：计算平方根
library Math {
    function sqrt(uint y) internal pure returns (uint z) {
        if (y > 3) {
            z = y;
            uint x = y / 2 + 1;
            while (x < z) {
                z = x;
                x = (y / x + x) / 2;
            }
        } else if (y != 0) {
            z = 1;
        }
        // else z = 0 (default value)
    }
}

contract TestSafeMath {
    // “为所有 uint 类型的变量，启用 SafeMath 库中的函数作为‘方法’。”
    using SafeMath for uint;

    uint public MAX_UINT = 2**256 - 1;

    function testAdd(uint x, uint y) public pure returns (uint) {
        // 看起来像 x 调用了 add 方法   x.add(y) 实际上是编译器自动转换为：SafeMath.add(x, y)
        return x.add(y);
    }

    function testSquareRoot(uint x) public pure returns (uint) {
        return Math.sqrt(x);
    }
}

// Array function to delete element at index and re-organize the array
// so that their are no gaps between the elements.
library Array {
    function remove(uint[] storage arr, uint index) public {
        // Move the last element into the place to delete
        require(arr.length > 0, "Can't remove from empty array");
        arr[index] = arr[arr.length - 1];
        arr.pop();
    }
}

contract TestArray {
    // using Array for uint[] 表示：为所有 uint[] 类型的数组启用 Array 库。
    using Array for uint[];

    uint[] public arr;

    function testArrayRemove() public {
        for (uint i = 0; i < 3; i++) {
            arr.push(i);
        }

        // 编译器会转换为: Array.remove(arr, 1)
        arr.remove(1);

        assert(arr.length == 2);
        assert(arr[0] == 0);
        assert(arr[1] == 2);
    }
}