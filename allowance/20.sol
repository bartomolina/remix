// SPDX-License-Identifier: MIT

// Owner: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
// Wallet1: 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
// Wallet2: 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db

// mint(to, amount) // Owner
// mint(Wallet1,
//   100)

// approve(spender, amount) // Wallet1
// approve(Owner,
//   100)

// transferFrom(from, to, amount) // Owner
// transferFrom(Wallet1,
//   Wallet2,
//   100)

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Allowance_20 is ERC20, Ownable {
    constructor() ERC20("MyToken", "MTK") {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}