// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import { ERC1155 } from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { ERC1155Burnable } from "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import { ERC1155Supply } from "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";

import { SuperTokenV1Library } from "@superfluid-finance/ethereum-contracts/contracts/apps/SuperTokenV1Library.sol";
import { SuperAppBaseCFA } from "@superfluid-finance/ethereum-contracts/contracts/apps/SuperAppBaseCFA.sol";
import { ISuperfluid, ISuperToken, ISuperApp } from "@superfluid-finance/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol";

/// @dev Thrown when the receiver is the zero adress.
error InvalidReceiver();

/// @dev Thrown when receiver is also a super app.
error ReceiverIsSuperApp();

// fDAIx: 0x5D8B4C2554aeB7e86F387B4d6c00Ac33499Ed01f
// Host: 0xEB796bdb90fFA0f28255275e16936D25d3418603

// Contract: 0x0b673caa19b5bc8b55ff5a0a681334965058dda9

contract Mosaic is ERC1155, Ownable, ERC1155Burnable, ERC1155Supply, SuperAppBaseCFA {

    error InvalidTransfer();
    error InvalidStages();

    /// @dev super token library
    using SuperTokenV1Library for ISuperToken;

    /// @dev Super token that may be streamed to this contract
    ISuperToken public immutable acceptedToken;

    string public userData;

    constructor(
        ISuperToken _acceptedToken,
        ISuperfluid host
    ) ERC1155("") SuperAppBaseCFA(
        host,
        true,
        false,
        true
    ) {
        acceptedToken = _acceptedToken;
    }

    // ---------------------------------------------------------------------------------------------
    // MODIFIERS

    ///@dev checks that only the acceptedToken is used when sending streams into this contract
    ///@param superToken the token being streamed into the contract
    function isAcceptedSuperToken(ISuperToken superToken) public view override returns (bool) {
        return superToken == acceptedToken;
    }

    // ---------------------------------------------------------------------------------------------
    // CALLBACK LOGIC

    function onFlowCreated(
        ISuperToken /*superToken*/,
        address sender,
        bytes calldata ctx
    )
        internal
        override
        returns (bytes memory /*newCtx*/)
    {
        if (balanceOf(sender, 123) == 0) {
            _mint(sender, 123, 1, "");
        }

        ISuperfluid.Context memory decompiledContext = host.decodeCtx(ctx);
        userData = abi.decode(decompiledContext.userData, (string));

        return ctx;
    }

    function onFlowDeleted(
        ISuperToken /*superToken*/,
        address sender,
        address /*receiver*/,
        int96 /*previousFlowRate*/,
        uint256 /*lastUpdated*/,
        bytes calldata ctx
    )
        internal
        override
        returns (bytes memory /*newCtx*/)
    {
        if (balanceOf(sender, 123) == 0) {
            _burn(sender, 123, 1);
        }

        return ctx;
    }

    // ---------------------------------------------------------------------------------------------
    // ERC1155

    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    )
        internal
        override(ERC1155, ERC1155Supply)
    {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }
}