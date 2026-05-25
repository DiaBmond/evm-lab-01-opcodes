// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MathComparisonDiv {
    // 1. High-level
    function divSolidity(uint256 a, uint256 b) public pure returns (uint256) {
        return a / b;
    }

    // 2. Yul (Low-level)
    function divAssembly(
        uint256 a,
        uint256 b
    ) public pure returns (uint256 result) {
        assembly {
            result := div(a, b)
        }
    }

    // 3. Opcode
    // Example: 6 / 2
    // Bytecode is: 6002600604
    /*
    Step-by-Step Execution:
       60 02 -> PUSH1 0x02 : Push value 2 (denominator) onto the stack -> [2]
       60 06 -> PUSH1 0x06 : Push value 6 (numerator) onto the stack (placed on top) -> [6, 2]
       04    -> DIV        : Pop the top 2 values (6 and 2) from the stack, divide the first by the second (6 / 2), 
                             and push the result (3) back onto the stack -> [3]
    */
}
