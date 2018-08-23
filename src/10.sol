pragma solidity ^0.4.11;

// Breaking The Optimizer, Again
// solc --bin --asm --optimize c-static-array--packing.sol | grep -E 

contract C {
    uint64[4] numbers;
    constructor () public {
        numbers[0] = 0x0;
        numbers[1] = 0x1111;
        numbers[2] = 0x2222;
        numbers[3] = 0x3333;
    }
}

//To summarize the packing behaviour we’ve seen so far:

//Store variables: yes.
//Struct fields: yes.
//Fixed-length arrays: yes.