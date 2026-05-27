############
# Puzzle 1 #
############
```
00      34      CALLVALUE
01      56      JUMP
02      FD      REVERT
03      FD      REVERT
04      FD      REVERT
05      FD      REVERT
06      FD      REVERT
07      FD      REVERT
08      5B      JUMPDEST
09      00      STOP
```
? Enter the value to send: 8

Puzzle solved!


[Run it in evm.codes](https://www.evm.codes/playground?callValue=8&unit=Wei&callData=&codeType=Bytecode&code=%273456FDFDFDFDFDFD5B00%27_)

## Solution

### The Goal
We need to execute a jump from `01 JUMP` directly to `08 JUMPDEST` to successfully bypass all `REVERT` opcodes.

### Explanation (Guideline)
- Opcode `56 JUMP` changes the execution flow to a valid `5B JUMPDEST` position.
- It requires exactly one value (the first item on top of the stack) to act as the destination coordinate.
- Opcode `34 CALLVALUE` pushes the sent value (`msg.value` in Wei) onto the stack.
- Therefore, the value we send (`CALLVALUE`) dictates the destination position for the `JUMP`. By sending `8`, the execution lands perfectly on `08 JUMPDEST`.