pragma solidity ^0.4.24;

// Representing Struct
// solc --bin --asm --optimize c-struct-fields.sol

contract C {
    struct Tuple {
        uint256 a;
        uint256 b;
        uint256 c;
        uint256 d;
        uint256 e;
        uint256 f;
    }

    Tuple t;

    constructor () public {
        t.f = 0xC0FEFE;
    }
}