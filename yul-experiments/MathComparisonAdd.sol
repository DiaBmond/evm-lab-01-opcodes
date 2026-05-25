// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MathComparisonAdd {
    // 1. High-level
    function addSolidity(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }

    // 2. Yul (Low-level)
    function addAssembly(
        uint256 a,
        uint256 b
    ) public pure returns (uint256 result) {
        assembly {
            result := add(a, b)
        }
    }

    // 3. Opcode
    // Example: 6 + 2
    // Bytecode is: 6002600601
    /*
    Step-by-Step Execution:
       60 02 -> PUSH1 0x02 : Push value 2 onto the stack -> [2]
       60 06 -> PUSH1 0x06 : Push value 6 onto the stack (placed on top) -> [6, 2]
       01    -> ADD        : Pop the top 2 values (6 and 2) from the stack, add them together, 
                             and push the result (8) back onto the stack -> [8]
    */
}
