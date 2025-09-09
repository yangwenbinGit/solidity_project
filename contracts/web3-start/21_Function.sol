// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

// 函数
contract Function {
    
    // 多返回值的函数
    function refunMany() public pure returns (uint, bool, uint){
        return (1, true, 20);
    }

    // 返回值被命名的
    function named() public  pure returns (uint x, bool b, uint y){
        return(10, false, 30);
    }

    // 直接带上变量名进行赋值
    function assigned() public  pure returns (uint x, bool b, uint y){
        return (x = 30, b = true, y = 50);
    }


    function destructuringAssignments() public pure returns ( uint,
            bool,
            uint,
            uint,
            uint){
                (uint x, bool b, uint y) = refunMany();
                (uint a, , uint c) = (4, 5, 6);
                return (x,b ,y, a, c);
    }
 

    uint[] internal  arr;

    function arrayOutput() public view returns (uint[] memory) {
        return arr;
    }

    function arrayInput(uint[] memory _arr) public {}

}