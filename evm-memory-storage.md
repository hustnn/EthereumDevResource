# The Ethereum Virtual Machine has three areas where it can store items.
# Ethereum Virtual Machine (EVM)

The Ethereum Virtual Machine (EVM) is the runtime environment for smart contracts in Ethereum. The EVM runs smart-contracts that are built up from bytecodes. Bytecodes are identied by a 160-bit address, and stored in the blockchain, which is also known as "accounts". The EVM operates on 256-bit pseudo registers. Which means that the EVM does not operate via registers. But, through an expandable stack which is used to pass parameters not only to functions/instructions, but also for memory and other algorithmic operations. The following excerpt is taken from the Solidity documentation, and it is also worth mentioning:

There are two kinds of accounts in Ethereum which share the same address space: External accounts that are controlled by public-private key pairs (i.e. humans) and contract accounts which are controlled by the code stored together with the account.

The address of an external account is determined from the public key while the address of a contract is determined at the time the contract is created (it is derived from the creator address and the number of transactions sent from that address, the so-called “nonce”).

Regardless of whether or not the account stores code, the two types are treated equally by the EVM.


# Memory Management

## (Persistent)
The Storage is a persistent key-value storage mapping (256-to-256-bit integers). And is documented as below:

Every account has a persistent key-value store mapping 256-bit words to 256-bit words called storage. Furthermore, every account has a balance which can be modified by sending transactions.

Each account has a persistent memory area which is called storage. Storage is a key-value store that maps 256-bit words to 256-bit words. It is not possible to enumerate storage from within a contract and it is comparatively costly to read and even more so, to modify storage. A contract can neither read nor write to any storage apart from its own.

The storage memory is the memory declared outside of the user-defined functions and within the Contract context. For instance, in listing 1, the userBalances and withdrawn will be in the memory storage. This can also be identied by the SSTORE / SLOAD instructions.

'
contract SendBalance {
    mapping ( address => uint ) userBalances ;
    bool withdrawn = false ;
(...)
}'

Storage contains all the contract state variables reside. Every contract has its own storage and it is persistent between function calls and quite expensive to use.

## Memory (Volatile)
This memory is mainly used when calling functions or for regular memory operations. The ocial documentation explicitly indicates that the EVM does not have traditional registers. Which means that the virtual stack previously discussed will be used primarily to push arguments to the instructions. The following is the excerpt explaining such behavior:

The second memory area is called memory, of which a contract obtains a freshly cleared instance for each message call. Memory is linear and can be addressed at byte level, but reads are limited to a width of 256 bits, while writes can be either 8 bits or 256 bits wide. Memory is expanded by a word (256-bit), when accessing (either reading or writing) a previously untouched memory word (ie. any offset within a word). At the time of expansion, the cost in gas must be paid. Memory is more costly the larger it grows (it scales quadratically).

Traditionally the MSTORE instruction is what we would generally consider to be the instruction responsible for adding data to the stack in any typical x86/x64 system. Therefore, the instructions MSTORE / MLOAD could be identied as such with respect to the x86/x64 system. Consequently, both mstore(where, what) and mload(where) are frequently used.
The second is “memory”, this is used to hold temporary values. It is erased between (external) function calls and is cheaper to use.

## Stack
It does not have the concept of registers. A virtual stack is being used instead for operations such as parameters for the opcodes. The EVM uses 256-bit values from that virtual stack. It has a maximum size of 1024 elements.

Stack is used to hold small local variables. It is almost free to use, but can only hold a limited amount of values.

For almost all types, you cannot specify where they should be stored, because they are copied everytime they are used.

The types where the so-called storage location is important are structs and arrays. If you e.g. pass such variables in function calls, their data is not copied if it can stay in memory or stay in storage. This means that you can modify their content in the called function and these modifications will still be visible in the caller.

There are defaults for the storage location depending on which type of variable it concerns:

state variables are always in storage
function arguments are in memory by default
local variables of struct, array or mapping type reference storage by default
local variables of value type (i.e. neither array, nor struct nor mapping) are stored in the stack
