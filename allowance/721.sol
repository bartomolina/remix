// SPDX-License-Identifier: MIT

// Owner: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
// Wallet1: 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
// Wallet2: 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db

// safeMint(to, amount) // Owner
// safeMint(Wallet1)

// setApprovalForAll(operator, approved) // Wallet1
// setApprovalForAll(Owner
//   true)

// safeTransferFrom(from, to, tokenId) // Owner
// safeTransferFrom(Wallet1,
//   Wallet2,
//   0)

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Allowance_721 is ERC721, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("MyToken", "MTK") {}

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }
}