############
# Puzzle 6 #
############
```
00      6000      PUSH1 00
02      35        CALLDATALOAD
03      56        JUMP
04      FD        REVERT
05      FD        REVERT
06      FD        REVERT
07      FD        REVERT
08      FD        REVERT
09      FD        REVERT
0A      5B        JUMPDEST
0B      00        STOP
```
? Enter the calldata: 0x000000000000000000000000000000000000000000000000000000000000000a

Puzzle solved!

[Run it in evm.codes](https://www.evm.codes/playground?callValue=0&unit=Wei&callData=0x000000000000000000000000000000000000000000000000000000000000000a&codeType=Bytecode&code=%2760003556FDFDFDFDFDFD5B00%27_)

## Solution

### The Goal
This puzzle introduces the `35 CALLDATALOAD` opcode. Unlike `CALLDATASIZE` which just measures the length, `CALLDATALOAD` reads the actual data sent in the transaction. Our goal is to craft a specific 32-byte calldata payload that evaluates to the exact destination coordinate `0x0A` (decimal 10) to safely execute the jump.

### Explanation (Guideline)
* `6000 PUSH1 00`: Pushes the hexadecimal value `0x00` (decimal 0) onto the stack. This acts as the offset (starting position) for reading the data. (Stack state: [`0`])
* `35 CALLDATALOAD`: Pops the top value (`0`) to use as the memory offset. It then reads exactly 32 bytes (one full EVM word) of the transaction's calldata starting from that offset, and pushes the result onto the stack. (Stack state: [`calldata[0:32]`])
* `56 JUMP`: Pops the top item from the stack and changes the execution flow to that exact destination coordinate.
* **The Logic:** To successfully land on `0A JUMPDEST`, the value pushed onto the stack by `CALLDATALOAD` must be `0x0A` (decimal 10).
* **Hexadecimal to Bytes:** Because `CALLDATALOAD` strictly reads 32 bytes (which is 64 hexadecimal characters), we cannot simply send `0x0a`. If we did, the EVM would pad it with zeros at the end (right-padding), completely changing the value. We must explicitly provide a 32-byte word representing the number 10.
* To do this, we take the hexadecimal value for 10 (`a`) and pad it with 63 leading zeros.
* Therefore, the correct calldata to send is `0x000000000000000000000000000000000000000000000000000000000000000a`, which perfectly resolves to `0x0A` on the stack and allows the jump to bypass the reverts.