pragma solidity ^0.4.24;

// multiple variable, Storage Packing
// solc --bin --asm c3.sol
// solc --bin --asm --optimize c3.sol

contract C {

    uint128 a;
    uint128 b;

    constructor () public {
        a = 1;
        b = 2;
    }
}

// EVM is a 256bit machine. It is most natural to manipulate data in chunks of 32 bytes.
// Persistent storage is quite expensive.
// The Solidity compiler makes interesting choices in order to minimize gas usage.