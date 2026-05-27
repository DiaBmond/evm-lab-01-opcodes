############
# Puzzle 8 #
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
0B      6000      PUSH1 00
0D      80        DUP1
0E      80        DUP1
0F      80        DUP1
10      80        DUP1
11      94        SWAP5
12      5A        GAS
13      F1        CALL
14      6000      PUSH1 00
16      14        EQ
17      601B      PUSH1 1B
19      57        JUMPI
1A      FD        REVERT
1B      5B        JUMPDEST
1C      00        STOP
```
? Enter the calldata: 0x60fd60005360016000f3

Puzzle solved!

[Run it in evm.codes](https://www.evm.codes/playground?callValue=0&unit=Wei&callData=0x60fd60005360016000f3&codeType=Bytecode&code=%2736600080373660006000F0600080808080945AF1600014601B57FD5B00%27_)

## Solution

### The Goal
This puzzle introduces the `F1 CALL` opcode. Building on Puzzle 7, we must deploy a new smart contract using `CREATE`. However, this time the puzzle actually executes a `CALL` to our newly deployed contract. To bypass the revert traps, we must ensure the call **fails**, forcing the `CALL` opcode to return `0`.

### Explanation (Guideline)
* **Lines `00` to `0A` (Contract Creation):** Just like the previous puzzle, this copies our calldata to memory and uses `F0 CREATE` to deploy a new contract. The address of the new contract is pushed onto the stack. (Stack state: [`address`])
* **Lines `0B` to `12` (Stack Setup for CALL):** - `6000 PUSH1 00` and the four `80 DUP1` instructions push five zeros onto the stack. (Stack state: [`0, 0, 0, 0, 0, address`])
* `11 SWAP5` swaps the top item (`0`) with the 6th item (`address`). (Stack state: [`address, 0, 0, 0, 0, 0`])
* `12 GAS` pushes the remaining available gas onto the stack. (Stack state: [`gas, address, 0, 0, 0, 0, 0`])


* **`13 F1 CALL`:** This opcode consumes 7 items from the stack to execute a message call to another contract. The parameters are: `gas`, `address`, `value` (0), `argsOffset` (0), `argsSize` (0), `retOffset` (0), and `retSize` (0).
* **Crucial detail:** If a `CALL` succeeds, it pushes `1` onto the stack. If it fails (reverts), it pushes `0`.


* **`14 6000 PUSH1 00` and `16 14 EQ`:** This checks if the result of our `CALL` is equal to `0`. If `call_result == 0`, it pushes `1` (true) onto the stack, which allows the `57 JUMPI` to safely jump to `1B JUMPDEST`.
* **The Logic (Writing the Calldata):** - To make the `CALL` fail, our deployed contract must execute a `REVERT` instruction when it is called. The opcode for `REVERT` is `FD`.
* Therefore, our initialization calldata needs to deploy a contract whose runtime bytecode is exactly 1 byte: `FD`.
* To achieve this, the init code must write `FD` into memory and then return it:
1. `60FD`: PUSH1 `FD` (The revert opcode)
2. `6000`: PUSH1 `00` (Memory offset 0)
3. `53`: MSTORE8 (Store the 1-byte `FD` at memory position 0)
4. `6001`: PUSH1 `01` (Size of the code to return: 1 byte)
5. `6000`: PUSH1 `00` (Memory offset to return from: 0)
6. `F3`: RETURN (Return 1 byte starting at memory offset 0)




* **Compiling the Bytecode:** Stringing these instructions together gives us `60fd60005360016000f3`. When sent as calldata, this successfully deploys a "reverting" contract, causing the `CALL` to fail, passing the `EQ 0` check, and solving the puzzle!