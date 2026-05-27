############
# Puzzle 5 #
############
```
00      34          CALLVALUE
01      80          DUP1
02      02          MUL
03      610100      PUSH2 0100
06      14          EQ
07      600C        PUSH1 0C
09      57          JUMPI
0A      FD          REVERT
0B      FD          REVERT
0C      5B          JUMPDEST
0D      00          STOP
0E      FD          REVERT
0F      FD          REVERT
```
? Enter the value to send: 16

Puzzle solved!

[Run it in evm.codes](https://www.evm.codes/playground?callValue=16&unit=Wei&callData=&codeType=Bytecode&code=%2734800261010014600C57FDFD5B00FDFD%27_)

## Solution

### The Goal
This puzzle introduces the `57 JUMPI` (Conditional Jump) and `14 EQ` (Equality) opcodes. We need to find a specific `CALLVALUE` that, when multiplied by itself (squared), equals exactly `0x0100` in hex (which is 256 in decimal), so that the conditional jump successfully lands on `0C JUMPDEST`.

### Explanation (Guideline)
* `34 CALLVALUE`: Pushes the value we send (`msg.value`) onto the stack. (Stack state: [`X`])
* `80 DUP1`: Duplicates the top value on the stack. (Stack state: [`X, X`])
* `02 MUL`: Pops the top two values, multiplies them together, and pushes the result back onto the stack. This effectively squares our `CALLVALUE`. (Stack state: [`X * X`])
* `610100 PUSH2 0100`: Pushes the 2-byte hexadecimal value `0x0100` onto the stack. In decimal, `0x0100` equals exactly 256. (Stack state: [`256, X * X`])
* `14 EQ`: Pops the top two values and checks if they are equal. If they match, it pushes a `1` (true) onto the stack. If they do not match, it pushes a `0` (false). We need this to evaluate to `1` to trigger the conditional jump. (Stack state: [`1`])
* `600C PUSH1 0C`: Pushes the hexadecimal value `0x0C` (decimal 12) onto the stack. This is the coordinate for our target `JUMPDEST`. (Stack state: [`12, 1`])
* `57 JUMPI`: The conditional jump opcode. It requires two items from the stack: the destination (`12`) and the condition (`1`). Because the condition is `1` (true), the execution flow jumps safely to `0C`. If the condition were `0`, it would continue to the next line and hit the `REVERT` traps.
* **The Math:** To make `EQ` return `1`, our squared `CALLVALUE` must equal 256.
$X \times X = 256$
$X^2 = 256$
$X = 16$
* Therefore, by sending a `CALLVALUE` of 16, the stack evaluates correctly, bypassing the revert traps and successfully solving the puzzle!