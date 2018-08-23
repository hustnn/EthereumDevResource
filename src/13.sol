pragma solidity ^0.4.24;

// Mapping Large Values
// 3 sstore instructions

contract C {
    mapping(uint256 => Tuple) tuples;
    struct Tuple {
        uint256 a;
        uint256 b;
        uint256 c;
    }
    constructor () public {
        tuples[0x1].a = 0x1A;
        tuples[0x1].b = 0x1B;
        tuples[0x1].c = 0x1C;
    }
}