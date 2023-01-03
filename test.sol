// SPDX-License-Identifier: MIT
// 0x7604f88dB852329FA0FcBE17D71C844105c83686
pragma solidity ^0.8.7;

contract Test {

    address nftContract = 0x7604f88dB852329FA0FcBE17D71C844105c83686;
    uint tokenId = 0;
    uint price = 100;

    struct ListedToken {
        address payable seller;
        uint256 price;
    }

    mapping(address => mapping(uint256 => ListedToken) ) private contractToToken;

    constructor() {}

    function addListing() public {
        ListedToken memory token = ListedToken(
            payable(nftContract),
            price
        );

        contractToToken[nftContract][tokenId] = token;
        tokenId++;
    }

    function deleteListing() public {
        delete contractToToken[nftContract][0];
    }

    function test() public view returns (ListedToken memory) {
        return contractToToken[nftContract][0];
    }
}