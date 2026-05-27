############
# Puzzle 2 #
############
```
00      34      CALLVALUE
01      38      CODESIZE
02      03      SUB
03      56      JUMP
04      FD      REVERT
05      FD      REVERT
06      5B      JUMPDEST
07      00      STOP
08      FD      REVERT
09      FD      REVERT
```
? Enter the value to send: 4

Puzzle solved!

[Run it in evm.codes](https://www.evm.codes/playground?callValue=4&unit=Wei&callData=&codeType=Bytecode&code=%2734380356FDFD5B00FDFD%27_)

## Solution

### The Goal
Similar to Puzzle 1, we need to safely execute a jump to land on 06 JUMPDEST. However, this time we must provide a specific value so that the mathematical subtraction (SUB) results exactly in our target destination (6).

### Explanation (Guideline)
- `34 CALLVALUE`: Pushes the value we send (`msg.value`) onto the stack.
- `38 CODESIZE`: Measures the total length of this smart contract's bytecode and pushes that number onto the stack. By counting the instructions from `00` to `09`, we know the total size is 10 bytes. (Stack state: [`10, msg.value`])
- `03 SUB`: Pops the top two items from the stack and subtracts the second item from the first (`CODESIZE - CALLVALUE`). The result is pushed back onto the stack to act as the coordinate for `JUMP`.
- The Math: To land on `06 JUMPDEST`, the result of the subtraction must be exactly 6.
    `10 (CODESIZE) - X (CALLVALUE) = 6`
    `X = 4`
- Therefore, by sending a `CALLVALUE` of 4, the stack evaluates to `6`, allowing the `JUMP` instruction to safely bypass the `REVERT` trap.