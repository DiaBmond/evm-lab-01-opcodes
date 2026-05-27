############
# Puzzle 7 #
############
```
00      36        CALLDATASIZE
01      6000      PUSH1 00
03      80        DUP1
04      37        CALLDATACOPY
05      36        CALLDATASIZE
06      6000      PUSH1 00
08      6000      PUSH1 00
0A      F0        CREATE
0B      3B        EXTCODESIZE
0C      6001      PUSH1 01
0E      14        EQ
0F      6013      PUSH1 13
11      57        JUMPI
12      FD        REVERT
13      5B        JUMPDEST
14      00        STOP
```
? Enter the calldata: 0x60016000f3

Puzzle solved!

[Run it in evm.codes](https://www.evm.codes/playground?callValue=0&unit=Wei&callData=0x60016000f3&codeType=Bytecode&code=%2736600080373660006000F03B600114601357FD5B00%27_)

## Solution

### The Goal
This puzzle introduces the `37 CALLDATACOPY`, `F0 CREATE`, and `3B EXTCODESIZE` opcodes. Our goal is to provide calldata that acts as the **creation bytecode** (init code) for a new smart contract. To satisfy the condition and execute the jump, the newly deployed contract must produce a runtime bytecode that is exactly 1 byte in size.

### Explanation (Guideline)
* `36 CALLDATASIZE`, `6000 PUSH1 00`, and `80 DUP1`: These setup the stack for copying data. `DUP1` duplicates the `0`, resulting in a stack state of: [`0, 0, calldatasize`].
* `37 CALLDATACOPY`: Pops the top three values (`destOffset, offset, size`) and copies our transaction's calldata into EVM memory starting at position `0`.
* `36 CALLDATASIZE`, `6000 PUSH1 00`, `6000 PUSH1 00`: Sets up the parameters for contract creation. (Stack state: [`0, 0, calldatasize`]) representing `value` in wei, memory `offset`, and `size`.
* `F0 CREATE`: Takes the top three values, creates a new smart contract using the memory we just populated as its initialization code, and pushes the new contract's `address` onto the stack.
* `3B EXTCODESIZE`: Takes the `address` from the stack and returns the size of its deployed **runtime bytecode**. (Stack state: [`extcodesize`])
* `6001 PUSH1 01` and `14 EQ`: Checks if the `extcodesize` is exactly 1 byte. If it is, it pushes `1` (true) onto the stack. (Stack state: [`1`])
* `6013 PUSH1 13` and `57 JUMPI`: If the condition is `1`, it safely jumps to `13 JUMPDEST`, bypassing the `REVERT`.

* **The Logic (Writing the Calldata):** Since our calldata is executed as the EVM initialization code during `CREATE`, we must write a mini-program that returns exactly 1 byte to be saved as the contract's permanent runtime code.
* To return data, we use the `F3 RETURN` opcode, which requires two values on the stack: `offset` and `size`.
* We need the `size` to be 1, so we use `6001 PUSH1 01`.
* We need the memory `offset` to start at 0, so we use `6000 PUSH1 00`.
* Finally, we call `F3 RETURN`.

* **Compiling the Bytecode:** Putting those opcodes together in hexadecimal format gives us `6001` (PUSH1 01) + `6000` (PUSH1 00) + `f3` (RETURN).
* Therefore, sending the calldata `0x60016000f3` executes this exact sequence, deploying a contract that returns a 1-byte runtime code, perfectly satisfying the `EXTCODESIZE == 1` condition!