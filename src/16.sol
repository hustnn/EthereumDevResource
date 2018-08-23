pragma solidity ^0.4.24;

// Dynamic Array Packing

contract C {
    uint128[] s;
    
    constructor () public {
        s.length = 4;
        s[0] = 0xAA;
        s[1] = 0xBB;
        s[2] = 0xCC;
        s[3] = 0xDD;
    }
}