// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract IfElse {
    function foo(uint _x) public pure returns (uint) {
        if(_x < 10){
            return  1;
        }else if(_x > 20){
            return  2;
        }else {
            return  0;
        }
    }

    function simpleFoo(uint _x) public pure  returns (uint){
        return _x > 20? 1: 0;
    }
}