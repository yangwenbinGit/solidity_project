// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;


// 默认1就表示1 wei  一个以太为10e18次方  wei 
contract EtherUnits {

    uint public oneWei = 1 wei;

    bool public isTrue = (1 wei == 1); // 1 wei is equal to 1

    uint public oneEth =  1 ether;

    bool public isTrueEth = (1 ether == 1e18 wei);

}