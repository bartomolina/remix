// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Royalty.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import {DefaultOperatorFilterer} from "./opensea/OperatorFilterer.sol";

/**
 * @title  ExampleERC721
 * @notice This example contract is configured to use the DefaultOperatorFilterer, which automatically registers the
 *         token and subscribes it to OpenSea's curated filters.
 *         Adding the onlyAllowedOperator modifier to the transferFrom and both safeTransferFrom methods ensures that
 *         the msg.sender (operator) is allowed by the OperatorFilterRegistry. Adding the onlyAllowedOperatorApproval
 *         modifier to the approval methods ensures that owners do not approve operators that are not allowed.
 */
contract OpenSeaEnforced is ERC721Royalty, Ownable, OperatorFilterer {

    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    address royaltiesAddress = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    constructor() ERC721("OSEnforcedDefault", "OSED") {
        _setDefaultRoyalty(royaltiesAddress, 2200);
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

    function setApprovalForAll(address operator, bool approved) public override onlyAllowedOperatorApproval(operator) {
        super.setApprovalForAll(operator, approved);
    }

    function approve(address operator, uint256 tokenId) public override onlyAllowedOperatorApproval(operator) {
        super.approve(operator, tokenId);
    }

    function transferFrom(address from, address to, uint256 tokenId) public override onlyAllowedOperator(from) {
        super.transferFrom(from, to, tokenId);
    }

    function safeTransferFrom(address from, address to, uint256 tokenId) public override onlyAllowedOperator(from) {
        super.safeTransferFrom(from, to, tokenId);
    }

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data)
        public
        override
        onlyAllowedOperator(from)
    {
        super.safeTransferFrom(from, to, tokenId, data);
    }
}