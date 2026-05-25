// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MathComparisonSub {
    // 1. High-level
    function subSolidity(uint256 a, uint256 b) public pure returns (uint256) {
        return a - b;
    }

    // 2. Yul (Low-level)
    function subAssembly(
        uint256 a,
        uint256 b
    ) public pure returns (uint256 result) {
        assembly {
            result := sub(a, b)
        }
    }

    // 3. Opcode
    // Example: 6 - 2
    // Bytecode is: 6002600603
    /*
    Step-by-Step Execution:
       60 02 -> PUSH1 0x02 : Push value 2 onto the stack -> [2]
       60 06 -> PUSH1 0x06 : Push value 6 onto the stack (placed on top) -> [6, 2]
       03    -> SUB        : Pop the top 2 values (6 and 2) from the stack, subtract the second from the first (6 - 2), 
                             and push the result (4) back onto the stack -> [4]
    */
}
