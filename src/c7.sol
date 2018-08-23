pragma solidity ^0.4.24;

// Fixed Length Array
// solc --bin --asm --optimize c-static-array.sol
// solc --bin --asm c-static-array.sol for Array Bound Checking

contract C {
    uint256[6] numbers;

    constructor () public {
        numbers[5] = 0xC0FEFE;
    }
}