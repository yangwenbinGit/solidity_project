// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract FunctionSelector {
    /*
    "transfer(address,uint256)"
    0xa9059cbb
    "transferFrom(address,address,uint256)"
    0x23b872dd
    */


    // 计算并返回一个函数签名（function signature）对应的函数选择器

    /**
        第一步：bytes(_func)
            将输入的字符串 _func 转换为一个字节序列（bytes 类型）。
            例如，如果 _func = "transfer(address,uint256)"，那么 bytes(_func) 就是这个字符串的 UTF-8 编码字节。
        第二步：keccak256(...)
            对上一步得到的字节序列进行哈希运算，使用以太坊的标准哈希函数 keccak256。结果是一个 32 字节（256 位）的哈希值。
        第三步：bytes4(...)
             从上面得到的 32 字节哈希值中，取前 4 个字节。这 4 个字节就是所谓的 函数选择器（Function Selector）。   

        函数选择器（Function Selector）是什么？
        在以太坊中，当你调用一个智能合约的函数时，交易的 calldata 中会包含：
        前 4 字节：函数选择器（由函数签名的 keccak256 哈希的前 4 字节决定）。
        后续字节：编码后的函数参数（使用 ABI 编码）。
        EVM 通过这前 4 字节来判断你想要调用的是哪个函数。
    */
    function getSelector(string calldata _func) external pure returns (bytes4) {
        return bytes4(keccak256(bytes(_func)));
    }
}