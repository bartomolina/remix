// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract SolidityByExample {

    // Variables
    // State - stored in the blockchain
    // Local - inside a function
    // Global

    // Data types
    // Value types
    bool public b = true;
    uint public u = 123;
    int public i = -123;
    int public minInt = type(int).min;
    int public maxInt = type(int).min;
    address public addr = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;
    bytes32 public b32 = 0x111122223333444455556666777788889999AAAABBBBCCCCDDDDEEEEFFFFCCCC;
    address public constant MY_ADDRESS = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;

    // Functions
    // external
    // pure - doesn't access blockchain data
    // view - access State and Global variables

    // Global variables
    function globalVars() external view returns (address, uint, uint) {
        address sender = msg.sender; // Caller
        uint timestamp = block.timestamp; // UNIX timestamp when the function was called
        uint blockNum = block.number; // Current block number
        return (sender, timestamp, blockNum);
    }

    // Conditions
    function ifElse(uint _x) external pure returns (uint) {
        if (_x < 10){
            return 1;
        } else if (_x < 20) {
            return 2;
        } else {
            return 3;
        }

        // Ternary operator
        return _x < 10 ? 1 : 2;
    }

    // Loops
    function loops() external pure {
        for (uint i = 0; i < 10; i++) {
            if (i == 3) {
                continue;
            }
            if (i == 5) {
                break;
            }
        }

        uint j = 0;
        while (j < 10) {
            j++;
        }
    }

    // Errors
    // require, revert, assert
    // - gas refund, state updates are reverted
    // - custom error - save gas
    function testRequire(uint _i) public pure {
        // validate inputs, access control
        require(_i <= 10, "i > 10");
    }
    function testRevert(uint _i) public pure {
        // better if the condition is nested in many if statements
    }

    // Overflow
    function underflow() public pure returns (uint){
        uint x = 0;
        unchecked { x--; }
        return x;
    }
}