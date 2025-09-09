// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract A{
    event Log(string message);


    function foo() public virtual {
        emit Log("A.foo called");
    }

    function bar() public virtual {
        emit Log("A.bar called");
    }
}


contract B is A {
    function foo() public virtual override {
        emit Log("B.foo called");
        A.foo();
    }

    function bar() public virtual override {
        emit Log("B.bar called");
        super.bar();
    }
}


contract C is A {
    function foo() public virtual override {
        emit Log("C.foo called");
        A.foo();
    }

    function bar() public virtual override {
        emit Log("C.bar called");
        super.bar();
    }
}


contract D is B, C {
    // Try:
    // - Call D.foo and check the transaction logs.
    //   Although D inherits A, B and C, it only called C and then A.
    // - Call D.bar and check the transaction logs
    //   D called C, then B, and finally A.
    //   Although super was called twice (by B and C) it only called A once.

    function foo() public override(B, C) {
        super.foo();
    }

    function bar() public override(B, C) {
        super.bar();
    }
}

/**
  1.这里面有难理解的2个点：
     第一: 为什么在D合约中 执行super.foo(); 他打印结果是:  C.foo called  A.foo called
        当 D.foo() 调用 super.foo() 时，会沿着线性化顺序调用 C.foo()（因为 C 在 B 前面）。
        C.foo() 执行，打印 "C.foo called"，然后直接调用 A.foo()。
        此时流程跳到了 A，完全跳过了 B.foo()！
        所以你看不到 "B.foo called"。
        🔴 foo() 调用链：D → C → A

    第二: 为什么在D合约中执行super.bar();  他打印结果是:  C.bar called   B.bar called  A.bar called
        super.bar() 不是指向某个特定父类，而是指向 C3 线性化顺序中的下一个合约。
        当 D.bar() 调用 super.bar()：
        根据 lin(D) = [D, C, B, A]，下一步是 C.bar()
        C.bar() 执行，打印 "C.bar called"
        C.bar() 中的 super.bar() → 下一步是 B.bar()
        B.bar() 执行，打印 "B.bar called"
        B.bar() 中的 super.bar() → 下一步是 A.bar()
        A.bar() 执行，打印 "A.bar called"
        ✅ bar() 调用链：D → C → B → A

        ✔️ 每个合约都被正确调用，且 A.bar() 只执行一次（因为线性化保证唯一路径）。



*/

