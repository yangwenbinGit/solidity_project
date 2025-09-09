// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

// 异常处理 一共有3种  require revert  assert断言
contract ErrorX{

    // require 是满足条件才会继续往下执行 否则就会报错
    function testRequire(uint _i) public pure {
        require(_i > 10, "Input must be greater than 10");
    }

    function testRevert(uint _j) public  pure {
        if(_j <= 10){
            revert("Input must be greater than 10");
        }
    }

    uint internal  num;

    function testAssert() public  view {
        assert(num == 0);
    }

    // 自定义错误
    error InsufficientBalance(uint balance, uint withdrawAmount);

    function testCustomError(uint _withdrawAmount) public  view {
        uint bal = address(this).balance;
        if (bal < _withdrawAmount) {
            revert InsufficientBalance({balance: bal, withdrawAmount: _withdrawAmount});
        }
    }
}


contract Account {
    uint public balance;
    uint public constant MAX_UINT = 2**256 - 1;

    // 收款函数(先收款)
    function deposit(uint _amount) public {
        uint oldBalance = balance;
        uint newBalance = balance + _amount;

        // balance + _amount does not overflow if balance + _amount >= balance
        require(newBalance >= oldBalance, "Overflow");

        balance = newBalance;

        assert(balance >= oldBalance);
    }


    // 转账函数(再转账)
    function withdraw(uint _amount) public {
        uint oldBalance = balance;

        // balance - _amount does not underflow if balance >= _amount
        require(balance >= _amount, "Underflow");

        if (balance < _amount) {
            revert("Underflow");
        }

        balance -= _amount;

        assert(balance <= oldBalance);
    }
}