pragma solidity ^0.4.24;

// Reading Zero
// solc --bin --asm --optimize c-zero-value.sol

contract C {
    uint256 a;
    uint256 b;

    constructor () public {
        a = b + 2;
    }
}