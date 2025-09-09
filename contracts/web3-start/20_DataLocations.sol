// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

// 数据位置  calldate memory  storage 

/**
        Solidity 中的数据位置（Data Location）有哪几种?
        
        数据位置	         说明
        storage	          永久存储在区块链上（昂贵，持久）  状态变量（默认就是 storage）函数中引用状态变量的引用类型（如 mapping, array, struct）
        memory	          临时内存，函数执行期间存在（便宜，短暂）    函数内部的局部变量（特别是数组、字符串等引用类型）
        calldata	      用于函数参数，只读，不复制数据（最便宜）     外部函数（external）的参数  推荐用于大数组或字符串，避免复制到 memory
        stack             这种对于变量unit bool 一般就在栈上 这个是系统帮我们自动管理

        特性	             storage	              memory	                calldata
        是否持久	         ✅是（上链）	         ❌ 否（临时）	           ❌ 否（临时）
        是否可修改	         ✅ 可读写	             ✅ 可读写	              ❌ 只读
        成本	             ⛽️⛽️⛽️ 高	              ⛽️⛽️ 中	                ⛽️ 低
        使用位置	         状态变量、局部引用	        局部变量、参数、返回值	    外部函数参数
        是否复制数据		 -                         ✅ 会复制	                ❌ 不复制（引用）

        区块链（持久化）
│
└── storage
    ├── arr        → 动态数组
    ├── map        → 映射
    └── myStructs  → 映射（值为结构体）

内存（临时，函数执行期间）
└── memory
    └── 函数内声明的 array/string/struct（需显式指定）

调用数据（只读，函数输入）
└── calldata
    └── external 函数参数

栈（EVM 内部管理）
└── stack
    └── uint, bool, address 等值类型局部变量
    */

contract DataLocations{
    uint[] internal arr;
    mapping (uint => address) map;
    struct MyStruct {
        uint foo;
    }

    mapping (uint => MyStruct) structMap;


    function f() public {
        // 注意这个地方不能直接用MyStruct(10) 这样会有问题 因为struct是在memroy里面 不能传给storage类型 从map获取
        f1_storage(arr, map, structMap[5]);

        MyStruct storage myStruct = structMap[10];

        MyStruct memory myMemStruct = MyStruct(20);

    }

    function f1_storage(
        uint[] storage _arr,
        mapping (uint => address) storage _storageMap,
        MyStruct storage _myStruct
        ) internal  {
        
    }

    function f2_memory(uint[] memory arr) internal   view returns (uint[] memory){

    }

    function f3_calldate(uint[] calldata _arr) external {

    }    
}