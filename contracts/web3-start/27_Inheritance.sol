// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

// is关键字相当于继承  相当于java的extend
// virtual表示函数可以被子合约重写  重写的函数需要加上override 表明重写了函数

/* Graph of inheritance
    A
   / \
  B   C
 / \ /
F  D,E

Solidity 支持多重继承。合约可以通过使用 is 关键字来继承其他合约。
将要被子合约重写的函数，必须声明为 virtual。
将要重写父函数的函数，必须使用 override 关键字。
继承顺序很重要。
你必须按照从“最基础的”到“最派生的”（即从父类到子类）的顺序列出父合约。
继承不能顺序颠倒, 否则会报错。比如 is A,C 这样肯定是错误的 继承逻辑不对


*/

contract A{
    function foo() public pure virtual  returns (string memory){
        return "A";
    }   
}

contract B is A{
    function foo() public pure virtual override returns (string memory){
        return "B";
    }
}

contract C is A{
     function foo() public pure virtual override returns (string memory){
        return "C";
    }
}


// contract D is B,C{
//     function foo() public  pure override (B, C) returns  (string memory){
//         // B,C 谁在最后 调用的就是谁  C
//         return super.foo(); 
//     }
// }


contract E is C, B {
    // E.foo() returns "B"
    // since B is the right most parent contract with function foo()
    function foo() public pure override(C, B) returns (string memory) {
        return super.foo();
    }
}


contract F is A, B {
    function foo() public pure override(A, B) returns (string memory) {
        return super.foo();
    }
}


// 注意顺序：C 在 B 前面
/**
    为什么是 C 而不是 B？
    这完全取决于 Solidity 的 C3 线性化算法 如何解析 contract D is B, C 的继承顺序。
    最终线性化顺序是：D -> B -> C -> A
    因为 C 在继承链中“遮蔽”了 B 的实现（C3 线性化决定） 最终执行的是C的代码 B的被抛弃不会执行
    记住永远调用最后一个
*/


// 调用的是C    I am G, C
contract D is B, C {
    function foo() public pure override(B, C) returns(string memory) {
        return string(abi.encodePacked("I am D, ", super.foo()));
    }
}


// 这个时候调用的是B   I am G, B
contract G is C,B {
    function foo() public pure override(C,B) returns(string memory) {
        return string(abi.encodePacked("I am G, ", super.foo()));
    }
}