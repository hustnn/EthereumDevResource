pragma solidity ^0.4.24;

// Packing Behaviour 
// solc --bin --asm --optimize c-many-variables--packing.sol

contract C {
    uint64 a;
    uint64 b;
    uint64 c;
    uint64 d;

    constructor () public {
        a = 0xaaaa;
        b = 0xbbbb;
        c = 0xcccc;
        d = 0xdddd;
    }
}