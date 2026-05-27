#############
# Puzzle 10 #
#############
```
00      38          CODESIZE
01      34          CALLVALUE
02      90          SWAP1
03      11          GT
04      6008        PUSH1 08
06      57          JUMPI
07      FD          REVERT
08      5B          JUMPDEST
09      36          CALLDATASIZE
0A      610003      PUSH2 0003
0D      90          SWAP1
0E      06          MOD
0F      15          ISZERO
10      34          CALLVALUE
11      600A        PUSH1 0A
13      01          ADD
14      57          JUMPI
15      FD          REVERT
16      FD          REVERT
17      FD          REVERT
18      FD          REVERT
19      5B          JUMPDEST
1A      00          STOP
```
? Enter the value to send: 15
? Enter the calldata: 0x000000

Puzzle solved!

[Run it in evm.codes](https://www.evm.codes/playground?callValue=15&unit=Wei&callData=0x000000&codeType=Bytecode&code=%2738349011600857FD5B3661000390061534600A0157FDFDFDFD5B00%27_)

## Solution

### The Goal
This puzzle brings together several new opcodes: `90 SWAP1`, `11 GT` (Greater Than), `06 MOD` (Modulo), and `15 ISZERO`. We need to pass a two-part validation: first ensuring our `CALLVALUE` is strictly less than the contract's code size, and second ensuring our `CALLDATASIZE` is a multiple of 3. Finally, our `CALLVALUE` acts as the missing mathematical variable to calculate the exact destination coordinate of our final jump.

### Explanation (Guideline)
This puzzle is broken into three distinct phases:

**Phase 1: The Size Check**

* `38 CODESIZE`: Pushes the total length of the bytecode onto the stack. By counting from `00` to `1A`, the total size is 27 bytes (hex `0x1B`). (Stack state: [`27`])
* `34 CALLVALUE`: Pushes the value we send (`msg.value`). (Stack state: [`callvalue, 27`])
* `90 SWAP1`: Swaps the top two items on the stack. (Stack state: [`27, callvalue`])
* `11 GT`: The "Greater Than" opcode checks if the first item is greater than the second (`27 > callvalue`). If true, it pushes `1`.
* `6008 PUSH1 08` and `57 JUMPI`: Safely jumps to `08 JUMPDEST` as long as `GT` evaluated to `1`.
* **Rule 1:** Our `CALLVALUE` must be less than 27.

**Phase 2: The Modulo Check**

* `36 CALLDATASIZE`: Pushes the length of our calldata. (Stack state: [`calldatasize`])
* `610003 PUSH2 0003`: Pushes the number 3. (Stack state: [`3, calldatasize`])
* `90 SWAP1`: Swaps the top two items. (Stack state: [`calldatasize, 3`])
* `06 MOD`: Pops the top two items and performs a modulo operation (`calldatasize % 3`), pushing the remainder back onto the stack.
* `15 ISZERO`: Checks if the top value on the stack is `0`. If `remainder == 0`, it pushes `1` (true). This `1` sits on the stack and will serve as the condition for our final jump. (Stack state: [`1`])
* **Rule 2:** To make `ISZERO` true, our calldata size must be a multiple of 3. A 3-byte payload like `0x000000` satisfies this perfectly.

**Phase 3: Calculating the Destination**

* `34 CALLVALUE`: Pushes our value again. (Stack state: [`callvalue, 1`])
* `600A PUSH1 0A`: Pushes hex `0x0A` (decimal 10) onto the stack. (Stack state: [`10, callvalue, 1`])
* `01 ADD`: Pops the top two items and adds them together. (Stack state: [`callvalue + 10, 1`])
* `57 JUMPI`: Executes the final jump. We know our condition is `1` from Phase 2, but we need the destination calculation to exactly match our safe landing spot: `19 JUMPDEST`.
* **The Math:** The destination coordinate is `0x19`, which is 25 in decimal.
`CALLVALUE + 10 = 25`
`CALLVALUE = 15`

By sending a `CALLVALUE` of 15 (which safely passes the Phase 1 check since 15 < 27) and a 3-byte `CALLDATASIZE` like `0x000000` (which passes the Phase 2 modulo check), the final jump calculates exactly to 25 (`0x19`), successfully solving the puzzle!