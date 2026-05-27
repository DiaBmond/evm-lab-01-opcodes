############
# Puzzle 4 #
############
```
00      34      CALLVALUE
01      38      CODESIZE
02      18      XOR
03      56      JUMP
04      FD      REVERT
05      FD      REVERT
06      FD      REVERT
07      FD      REVERT
08      FD      REVERT
09      FD      REVERT
0A      5B      JUMPDEST
0B      00      STOP
```
? Enter the value to send: 6

Puzzle solved!

[Run it in evm.codes](https://www.evm.codes/playground?callValue=6&unit=Wei&callData=&codeType=Bytecode&code=%2734381856FDFDFDFDFDFD5B00%27_)

## Solution

### The Goal
This puzzle introduces the `18 XOR` (Exclusive OR) opcode, a bitwise operation. We need to find the correct `CALLVALUE` so that when it is XOR with the `CODESIZE`, the result points to `0A JUMPDEST` (decimal 10).

### Explanation (Guideline)
- `38 CODESIZE`: Pushes the total length of the bytecode. By counting from `00` to `0B`, we find the size is 12 bytes (hex `0x0C`)
- `18 XOR`: Pops the top two values, performs a bitwise XOR operation on them, and pushes the result back onto the stack.
- The Math (Bitwise XOR):
    We need the result to be `10` (hex `0x0A`) to safely jump to `JUMPDEST`.
    The equation is: `12 ^ X = 10`

    A unique property of XOR is that if `A ^ B = C`, then `A ^ C = B`.
    So, we can solve for X by doing: `12 ^ 10 = X`
```
Let's convert to binary:
12 in binary: 1 1 0 0
10 in binary: 1 0 1 0
Result:       0 1 1 0 
```
Which is exactly 6 in decimal