pragma solidity ^0.4.11;

// Dynamic Arrays Are Mappings++


contract C {
    uint256[] chunks;

    constructor () public {
        chunks.push(0xAA);
        chunks.push(0xBB);
        chunks.push(0xCC);
    }
}