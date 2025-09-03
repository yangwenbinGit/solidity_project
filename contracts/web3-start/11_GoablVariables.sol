// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract GoablVariables{

    function goablVar() external view returns (address, uint,uint){
        address add = msg.sender;
        uint timestamp = block.timestamp;
        uint blokNum  = block.number;
        return(add, timestamp, blokNum);
    }


}

