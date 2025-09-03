// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

// 循环的写法
contract Loop {
    
    function loop() public pure returns (uint) {
        uint i = 0;
        for(;i <= 10; i++){
            if(i == 5){
                continue;
            }
            if(i == 8){
                break ;
            }
        }
        return i;
    }

    function whileTest() public pure returns (uint) {
        uint j = 0;
        while ( j <= 10){
            j++;
        }
        return j;
    }
}