############
# Puzzle 3 #
############
```
00      36      CALLDATASIZE
01      56      JUMP
02      FD      REVERT
03      FD      REVERT
04      5B      JUMPDEST
05      00      STOP
```
? Enter the calldata: 0x00000000

Puzzle solved!

[Run it in evm.codes](https://www.evm.codes/playground?callValue=0&unit=Wei&callData=0x00000000&codeType=Bytecode&code=%273656FDFD5B00%27_)

## Solution

### The Goal
This puzzle introduces the `CALLDATASIZE` opcode. The goal is to manipulate the length of the calldata we send so that its size exactly matches the destination coordinate of the `JUMPDEST` (`04`).

### Explanation (Guideline)
- `36 CALLDATASIZE`: Reads the size (in bytes) of the transaction data (calldata) sent to the contract and pushes that number onto the stack.
- To safely jump to `04 JUMPDEST`, the top value on the stack before the `JUMP` instruction must be exactly `4`. Thus, we need to send exactly 4 bytes of calldata.
- Hexadecimal to Bytes: In hex format, every 2 characters represent 1 byte. Therefore, 4 bytes require exactly 8 hex characters (excluding the `0x` prefix).
- The Answer: As you correctly pointed out, any 4-byte calldata will solve this puzzle! Examples include `0x00000000`, `0x01010101`, `0x10101010`, or `0x11111111`. All of them return a `CALLDATASIZE` of 4.