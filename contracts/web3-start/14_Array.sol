// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

// 数组
contract Array{
    uint[] public arr;
    uint[] public arr2 = [1,2,3];
    uint[10] public myFixedSizeArr;

    

    // 获取数组中的元素
    function get(uint i) public  view  returns (uint){
        return arr[i];
    }

    // 获取这个数组直接返回
    function getArr() public  view returns (uint[] memory){
        return  arr;
    }

    // 往数组中放入元素
    function push(uint value) public{
        arr.push(value);
    } 

    // 移除元素
    function pop() public {
        arr.pop();
    }

    // 获取数组的长度
    function getLength() public view returns (uint){
        return arr.length;
    }

    // 根据下标移除元素
    function remove(uint index) public {
        delete arr[index];
    }

    function examples() external pure returns (uint[] memory){
        // create array in memory, only fixed size can be created
        uint[] memory a = new uint[](5);
        a[0] = 42;
        a[1] = 50;
        return a;
    }
}