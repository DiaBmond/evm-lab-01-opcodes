// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MathComparisonMul {
    // 1. High-level
    function mulSolidity(uint256 a, uint256 b) public pure returns (uint256) {
        return a * b;
    }

    // 2. Yul (Low-level)
    function mulAssembly(
        uint256 a,
        uint256 b
    ) public pure returns (uint256 result) {
        assembly {
            result := mul(a, b)
        }
    }

    // 3. Opcode
    // Example: 6 * 2
    // Bytecode is: 6002600602
    /*
    Step-by-Step Execution:
       60 02 -> PUSH1 0x02 : Push value 2 onto the stack -> [2]
       60 06 -> PUSH1 0x06 : Push value 6 onto the stack (placed on top) -> [6, 2]
       02    -> MUL        : Pop the top 2 values (6 and 2) from the stack, multiply them together, 
                             and push the result (12) back onto the stack -> [12]
    */
}
