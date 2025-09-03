// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

// 类似于java中的map结构
contract Mapping {

    // 直接返回mapping类型是不支持的
    mapping (address => uint) public myMap;

    // 获取值
    function get(address add) public view returns (uint){
        return myMap[add];
    }

    // 设置值
    function set(address add, uint value) public {
        myMap[add] = value;
    }

    // 删除值
    function remove(address add) public {
        delete myMap[add];
    }   
   
}

contract NestedMapping {
    mapping(address => mapping(uint => bool)) public nested;

    function get(address add, uint indexKey) public view returns (bool){
        return nested[add][indexKey];
    }

    function set(address add, uint indexKey, bool value) public {
        nested[add][indexKey] =  value;
    }

    function remove(address add, uint indexKey) public {
        delete nested[add][indexKey];
    }


}