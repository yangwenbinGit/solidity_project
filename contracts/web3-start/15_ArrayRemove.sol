// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import './16_Enum.sol';

// 移除数组元素
contract ArrayRemove{

    uint[] internal  arr;


    // 这个时间复杂度比较高 需要每一个元素前后换一遍 再删除
    function removeArr(uint _index) internal {
        // 判断下是否越界 require是为true时继续执行后续的代码 否则报错
        require(_index < arr.length, "index out of bound");
        for(uint i = _index; i < arr.length -1; i++){
            arr[i] = arr[i+1];
        }
        // 最后一个元素弹出去
        arr.pop();
    }


    // 这种时间复杂度为1 最后一个元素和要移除的元素 调换位置  然后在移除
    function remove(uint index) internal {
        require(index < arr.length, "index out of bounds"); // 检查索引有效
        // Move the last element into the place to delete
        arr[index] = arr[arr.length - 1];
        // Remove the last element
        arr.pop();
    }


    function getArr() external  view returns(uint[] memory){
        return arr;
    }

    function test() external {
        arr = [1, 2, 3, 4, 5];    
        removeArr(2);
        // [1, 2, 4, 5]
        // 使用断言判断
        assert(arr[0] == 1);
        assert(arr[1] == 2);
        assert(arr[2] == 4);
        assert(arr[3] == 5);
        assert(arr.length  == 4);

        arr = [0];
        remove(0);
        assert(arr.length  == 0);
    }


    function test2() external {
        arr = [1, 2, 3, 4];

        remove(1);
        // [1, 4, 3]
        assert(arr.length == 3);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
        assert(arr[2] == 3);

        remove(2);
        // [1, 4]
        assert(arr.length == 2);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
    }
}