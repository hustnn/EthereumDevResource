pragma solidity ^0.4.11;

// Two Mappings
// solc --bin --asm --optimize  c-mapping-2.sol

contract C {
    mapping(uint256 => uint256) itemsA;
    mapping(uint256 => uint256) itemsB;
    function C() {
      itemsA[0xAAAA] = 0xAAAA;
      itemsB[0xBBBB] = 0xBBBB;
    }
}