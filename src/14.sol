pragma solidity ^0.4.24;

// Mappings Don’t Pack

contract C {
    mapping(uint256 => uint8) items;

    constructor () public {
        items[0xA] = 0xAA;
        items[0xB] = 0xBB;
    }
}