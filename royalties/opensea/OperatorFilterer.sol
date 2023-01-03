// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {DefaultOperatorFilterer} from "./DefaultOperatorFilterer.sol";

/**
 * @title  OperatorFilterer
 * @notice Inherits from OperatorFilterer and automatically subscribes to the default OpenSea subscription.
 */
abstract contract OperatorFilterer is DefaultOperatorFilterer {
    address constant DEFAULT_SUBSCRIPTION = address(0x3cc6CddA760b79bAfa08dF41ECFA224f810dCeB6);

    constructor() DefaultOperatorFilterer(DEFAULT_SUBSCRIPTION, true) {}
}