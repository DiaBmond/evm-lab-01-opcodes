############
# Puzzle 9 #
############
```
00      36        CALLDATASIZE
01      6003      PUSH1 03
03      10        LT
04      6009      PUSH1 09
06      57        JUMPI
07      FD        REVERT
08      FD        REVERT
09      5B        JUMPDEST
0A      34        CALLVALUE
0B      36        CALLDATASIZE
0C      02        MUL
0D      6008      PUSH1 08
0F      14        EQ
10      6014      PUSH1 14
12      57        JUMPI
13      FD        REVERT
14      5B        JUMPDEST
15      00        STOP
```
? Enter the value to send: 2
? Enter the calldata: 0x00000000

Puzzle solved!

[Run it in evm.codes](https://www.evm.codes/playground?callValue=2&unit=Wei&callData=0x00000000&codeType=Bytecode&code=%2736600310600957FDFD5B343602600814601457FD5B00%27_)

## Solution

### The Goal
This puzzle introduces the `10 LT` (Less Than) opcode and requires us to pass **two** conditional checks. We must find a combination of `CALLDATASIZE` and `CALLVALUE` where the size of our calldata is strictly greater than 3 bytes, and the product of the value and the size equals exactly 8.

### Explanation (Guideline)
This puzzle is split into two distinct stages, each protected by a `REVERT` trap.

**Stage 1: The Length Check**

* `36 CALLDATASIZE`: Pushes the length of our transaction data onto the stack. (Stack state: [`calldatasize`])
* `6003 PUSH1 03`: Pushes the number 3 onto the stack. (Stack state: [`3, calldatasize`])
* `10 LT`: The "Less Than" opcode. It pops the top two items (`a` and `b`) and checks if `a < b`. In this case, it evaluates if `3 < calldatasize`. If true, it pushes `1` (true).
* `6009 PUSH1 09` and `57 JUMPI`: To safely jump to `09 JUMPDEST`, the result of `LT` must be `1`. This gives us our first rule: **Our calldata must be greater than 3 bytes (at least 4 bytes long).**

**Stage 2: The Math Check**

* `34 CALLVALUE`: Once we land safely on `09 JUMPDEST`, this pushes the value we sent onto the stack. (Stack state: [`callvalue`])
* `36 CALLDATASIZE`: Pushes the length of our calldata again. (Stack state: [`calldatasize, callvalue`])
* `02 MUL`: Pops the top two items and multiplies them. (Stack state: [`calldatasize * callvalue`])
* `6008 PUSH1 08` and `14 EQ`: Checks if the result of our multiplication is exactly 8. If so, it pushes `1`.
* `6014 PUSH1 14` and `57 JUMPI`: If the `EQ` evaluates to `1`, the execution safely jumps to `14 JUMPDEST` (which is decimal 20).

**The Logic & Math:**
We have a system of two conditions to satisfy:

1. `CALLDATASIZE > 3`
2. `CALLVALUE * CALLDATASIZE = 8`

Because `CALLDATASIZE` must be a whole number greater than 3, and must be a factor of 8, the most logical choice is exactly 4.

* If `CALLDATASIZE = 4` bytes (which is 8 hex characters, like `0x00000000`)
* Then the equation becomes: `CALLVALUE * 4 = 8`
* Solving for `CALLVALUE` gives us exactly 2.

Therefore, by sending a `CALLVALUE` of 2 and a 4-byte calldata payload like `0x00000000`, both conditional jumps are satisfied and the puzzle is solved!

*(Note: You could also solve this by sending a `CALLDATASIZE` of 8 bytes like `0x0000000000000000` and a `CALLVALUE` of 1!)*