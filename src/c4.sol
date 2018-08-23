pragma solidity ^0.4.24;

// The storage is initially blank, defaulting to zero. It doesn’t cost you anything to have an infinite tape.
// solc --bin --asm --optimize c-many-variables.sol


contract C {

    uint256 a;
    uint256 b;
    uint256 c;
    uint256 d;
    uint256 e;
    uint256 f;

    constructor () public {
        f = 0xc0fefe;
    }
}