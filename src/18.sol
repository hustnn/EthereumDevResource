pragma solidity ^0.4.11;

// A Long Byte Array
//Run in Remix, and we see that four slots are used in storage:

contract C {
    bytes s;
    
    constructor () public {
        s.length = 32 * 4;
        s[31] = 0x1;
        s[63] = 0x2;
        s[95] = 0x3;
        s[127] = 0x4;
    }
}

//Arrays are like mappings, not very efficient.
//More complex assembly code than mappings.
//Better storage efficiency than mapping for smaller types (byte, uint8, string).
//Assembly not optimized very well. Even with packing, there’s one sstore per assignment.