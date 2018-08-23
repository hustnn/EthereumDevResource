pragma solidity ^0.4.24;

// sstore is very expensive
// solc --bin --asm c1.sol
// sstore costs 20000 gas for first write to a new position.
// sstore costs 5000 gas for subsequent writes to an existing position.
// sload costs 500 gas.
// Most instructions costs 3~10 gases.

contract C {

    uint256 a;

    constructor () public {
        a = 1;
    }
}