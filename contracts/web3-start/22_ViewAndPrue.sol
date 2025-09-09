// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

// 还是对那个view和prue的一个练习 读取外部状态变量就要用view view只能读取不能写 prue不读也不写
contract ViewAndPrue {
    
    uint private  x = 10;

    function addToY(uint y) public view returns (uint){
        return x+y;
    }

    function add(uint a,  uint b) public pure returns (uint){
        return  a*b ;
    }
}