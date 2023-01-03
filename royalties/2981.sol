// SPDX-License-Identifier: MIT

// Owner: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
// Wallet1: 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
// Wallet2: 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db

// safeMint(to, amount) // Owner
// safeMint(Wallet1)

// transferWithRoyalties(from, to, tokenId) // Owner
// transferWithRoyalties(Wallet1, // Wallet2
//   Wallet2,
//   0)

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Royalty.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Royalties_2981 is ERC721Royalty, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    address royaltiesAddress = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    constructor() ERC721("MyToken", "MTK") {
        _setDefaultRoyalty(royaltiesAddress, 1000);
    }

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

    function transferWithRoyalties(address from, address to, uint256 tokenId) public payable {
        (address receiver, uint256 royaltyAmount) = royaltyInfo(tokenId, msg.value);

        payable(receiver).transfer(royaltyAmount);
        payable(from).transfer(msg.value - royaltyAmount);
        
        _transfer(from, to, tokenId);
    }
}