// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract Caller {
    constructor() {}

    function approve(address operator) public {
        IERC721 NFTContract = IERC721(0xd9145CCE52D386f254917e481eB44e9943F39138);
        NFTContract.setApprovalForAll(operator, true);
    }
}