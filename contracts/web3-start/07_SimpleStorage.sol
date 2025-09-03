// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract SimpleStorage {

    /**
    Solidity 中的 4 种可见性修饰符
    修饰符	          谁能调用？	                              说明
    public	         ✅ 内部、✅ 外部、✅ 其他合约	           默认最开放，常用于接口函数
    internal	     ✅ 内部、✅ 继承的子合约	                只能在本合约或子合约中访问（默认）
    private	         ✅ 内部（仅本合约）	                      外部和子合约都不能访问
    external	     ❌ 内部（直接）、✅ 外部、✅ 其他合约	    只能从外部调用，不能内部直接调用（除非用 this.）


    3种函数行为修饰符
    修饰符	           作用	                              是否消耗 Gas
    view	          函数不修改状态，只读不写             ❌ 不消耗（外部调用）
    pure	          函数不读也不写状态（完全独立）	    ❌ 不消耗
    payable	          函数可以接收 ETH	                  ✅ 消耗（如果转账）


    */

    uint private data = 100;

    function f1() public view returns (uint){
        return data;
    }

    function f2() internal  view  returns (uint){
        return data;
    }

    function f3() private view returns(uint){
        return data;
    }

    function f4() external view returns (uint){
        return data;
    }
}

contract childContract is SimpleStorage{

    function test() public view returns (uint){
        f1();
        f2();
        // f3()就会报错只能在合约内部被调用
        // f3();
        // f4()也会报错 不能在合约内部调用  只能被外部合约调用
        // f4();

        // 通过 this 调用 external
        this.f4();
       
    }
}