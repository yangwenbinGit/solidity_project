// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

/**
Interface

cannot have any functions implemented
can inherit from other interfaces
all declared functions must be external
cannot declare a constructor
cannot declare state variables

*/
// 定义一个接口
interface IERC20 {
    // 函数：只声明，不实现
    function transfer(address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);

    // 事件也可以在接口中定义
    event Transfer(address indexed from, address indexed to, uint256 value);
}

//1. 合约实现接口
contract MyToken is IERC20 {
    mapping(address => uint256) private _balances;

    // 必须实现接口中的所有函数
    function transfer(address to, uint256 amount) external override returns (bool) {
        // require(_balances[msg.sender] >= amount);
        _balances[msg.sender] -= amount;
        _balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function balanceOf(address account) external view override returns (uint256) {
        return _balances[account];
    }

    function approve(address, uint256) external pure override returns (bool) {
        // 简化实现
        return true;
    }

    function mint(address to, uint256 amount) public {
        _balances[to] += amount;
        emit Transfer(address(0), to, amount);
    }
}


// 使用场景 2：与其他合约交互（最常用！）
contract TokenSwapper {
    // 接收一个代币地址，调用其 balanceOf
    /**
        tokenAddress：你想查询的代币合约的地址（比如 USDT 合约的地址）
        user：你想查谁的余额（比如用户的钱包地址）

    */

    function checkBalance(address tokenAddress, address user) public view returns (uint256) {
        // 将地址转成 IERC20 类型 这样就可以调用它里面的函数方法
        IERC20 token = IERC20(tokenAddress);
        return token.balanceOf(user);
    }

    function transferToken(address tokenAddress, address to, uint256 amount) public {
        IERC20 token = IERC20(tokenAddress);
        token.transfer(to, amount); // 调用外部合约的 transfer
    }
}


// ✅ 使用场景 3：定义回调接口（如闪电贷、授权）

interface IFlashLoanReceiver {
    // 定义一个回调函数，放款方会调用它
    function executeOperation(
        address asset,
        uint256 amount,
        uint256 fee,
        address initiator,
        bytes calldata params
    ) external returns (bool);
}

// 你的合约实现这个接口，就能接收闪电贷
contract FlashLoanUser is IFlashLoanReceiver {
    function executeOperation(
        address asset,
        uint256 amount,
        uint256 fee,
        address,
        bytes calldata
    ) external override returns (bool) {
        // 在这里使用贷款做交易...
        // 最后归还 amount + fee
        IERC20(asset).transfer(msg.sender, amount + fee);
        return true;
    }
}


// 使用场景 4：接口继承接口
interface IERC165 {
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

// IERC721 继承 IERC165
interface IERC721 is IERC165 {
    function ownerOf(uint256 tokenId) external view returns (address);
    function safeTransferFrom(address from, address to, uint256 tokenId) external;
}

// 实现 NFT 的合约必须同时满足这两个接口

/**
    转账这个非常简单 
    1.区分账户地址和合约地址：
        账户就是测试环境里面的，account 为我们生成很多的测试账户
        合约就是部署之后生成的合约地址。
    2.要进行转账的话：
        1.先用两个账户地址进行测试  比如地址分别为:
        0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
        0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
        切换到0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 这个账户调用mint给
        0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2这个账户进行充值，
        因为有钱才可以转账

        比如给它充值这么多钱:
        mint 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2, 10000000000000000

        充值完成后,通过balanceOf获取这个 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
        账户的钱，发现uint256: 10000000000000000  有这么多,就是我们刚才充的。


        // 然后切换到0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2这个账户,给0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
        这个账户转钱,调用transfer方法转钱

        transfer  0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, 10000

        然后在查询余额,发现钱少了:
        uint256: 9999999999990000

*/
