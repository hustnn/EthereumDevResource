pragma solidity ^0.4.24;

// Byte Arrays & String
// Remix

contract C {
    bytes s;

    constructor () public {
        s.push(0xAA);
        s.push(0xBB);
        s.push(0xCC);
        s.push(0xDD);
    }
}