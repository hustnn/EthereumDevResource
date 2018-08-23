pragma solidity ^0.4.11;

// Breaking The Optimizer
// solc --bin --asm --optimize c-many-variables--packing-helpers.sol

contract C {
    uint64 a;
    uint64 b;
    uint64 c;
    uint64 d;

    constructor () public {
        setAB();
        setCD();
    }

    function setAB() internal {
        a = 0xaaaa;
        b = 0xbbbb;
    }

    function setCD() internal {
        c = 0xcccc;
        d = 0xdddd;
    }
}