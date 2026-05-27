# EVM Lab 01: Opcodes & Low-Level Execution

Welcome to my deep dive into the Ethereum Virtual Machine (EVM). This repository serves as a personal sandbox and portfolio demonstrating my understanding of low-level EVM operations, bytecode, opcodes, and inline assembly (Yul).

## Repository Structure

This project is divided into two main areas of exploration:

### 1. `evm-puzzles-solutions/`
My detailed, step-by-step solutions to the classic EVM Puzzles. Rather than just providing the answers, I have broken down every puzzle (1-10) instruction by instruction to explain stack manipulation.

### 2. `yul-experiments/`
Smart contracts written to compare high-level Solidity, low-level inline assembly (Yul), and raw opcodes to understand math operations and how Solidity translates to machine code.

Inside this folder, contracts (e.g., `MathComparisonAdd.sol`, `MathComparisonDiv.sol`) break down a specific operation into three parts:
1. **High-level:** Standard Solidity function.
2. **Yul (Low-level):** Inline assembly execution.
3. **Opcode Breakdown:** Step-by-step stack execution logic and bytecodes provided directly in the comments.

**How to run Yul experiments:**
It is highly recommended to paste these contracts directly into [Remix IDE](https://remix.ethereum.org/). You can compile, deploy on the Remix VM, and use the debugger to observe the exact stack changes between standard Solidity and Yul.

## Core Concepts Mastered

Through solving these puzzles and writing Yul, I have gained hands-on experience with the EVM "Engine":
- **Stack Manipulation:** PUSH, POP, DUP, SWAP
- **Control Flow & Execution:** JUMP, JUMPI, calculating JUMPDEST coordinates, and avoiding REVERT traps.
- **Environment & Calldata:** CALLVALUE (msg.value), CALLDATASIZE, CODESIZE.
- **Bitwise & Mathematics:** XOR, SUB, MUL, MOD, EQ, ISZERO.

## How to Run the Puzzles

Each solution inside the `evm-puzzles-solutions/` folder contains a direct link to the [evm.codes playground](https://www.evm.codes/playground). You can simply click the link to see the raw bytecode execute step-by-step in your browser - no local setup required.

---

## Acknowledgments / Credits

A massive thank you to **Franco Victorio (@fvictorio)** for creating the original [EVM Puzzles](https://github.com/fvictorio/evm-puzzles). These puzzles are an absolute masterclass for anyone looking to truly understand how the Ethereum Virtual Machine works under the hood.
