pragma solidity ^0.4.11;

// uint256 => uint256 mapping:
// solc --bin --asm --optimize c-mapping.sol

contract C {
    mapping(uint256 => uint256) items;

    constructor () public {
        items[0xC0FEFE] = 0x42;
        items[0xC0FDFD] = 0x42;
    }
}