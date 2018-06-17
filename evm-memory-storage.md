To understand EVM and smart contract better
# Ethereum Virtual Machine (EVM)

The Ethereum Virtual Machine (EVM) is the runtime environment for smart contracts in Ethereum. The EVM runs smart-contracts that are built up from bytecodes. Bytecodes are identied by a 160-bit address, and stored in the blockchain, which is also known as "accounts". The EVM operates on 256-bit pseudo registers. Which means that the EVM does not operate via registers. But, through an expandable stack which is used to pass parameters not only to functions/instructions, but also for memory and other algorithmic operations. The following excerpt is taken from the Solidity documentation, and it is also worth mentioning:

There are two kinds of accounts in Ethereum which share the same address space: External accounts that are controlled by public-private key pairs (i.e. humans) and contract accounts which are controlled by the code stored together with the account.

The address of an external account is determined from the public key while the address of a contract is determined at the time the contract is created (it is derived from the creator address and the number of transactions sent from that address, the so-called “nonce”).

Regardless of whether or not the account stores code, the two types are treated equally by the EVM.

Every node runs the interpreter for every transaction. It's just like bitcoin. Every node runs the little script that executes when you try to spend from a previously unspent output (assuming you know about bitcoin). The hash of the transaction isn't relevant until it is being stuffed into a merkle tree. When running the execution, all we care about is the amount of gas, the data being passed in, and the code of the contract that's being called. When the execution completes, the storage tree of the contract may be updated, so we recompute the merkle root hash of that tree (and any other contract which may have been called by that one!)

The state transition function has a series of parts. There's the part that updates account balances and nonces (the simple part), the part that handles gas and gas refunds, the part that executes EVM byte code (which can cause account balances and storage values to change), and the part that pays miners for mining blocks and uncles. This "function" is defined in detail in the yellow paper and implemented independently in each of the ethereum clients (c++, go, python, etc). The EVM, or what I'm calling the interpreter, is typically just a for loop that increments a program counter and has a big switch statement telling it what to do for each operation in the byte code (pop/push the stack, load/store memory, load/store storage, call another contract, suicide, etc.)


# Memory Management 

The Ethereum Virtual Machine has three areas where it can store items.

## (Persistent)
The Storage is a persistent key-value storage mapping (256-to-256-bit integers). And is documented as below:

Every account has a persistent key-value store mapping 256-bit words to 256-bit words called storage. Furthermore, every account has a balance which can be modified by sending transactions.

Each account has a persistent memory area which is called storage. Storage is a key-value store that maps 256-bit words to 256-bit words. It is not possible to enumerate storage from within a contract and it is comparatively costly to read and even more so, to modify storage. A contract can neither read nor write to any storage apart from its own.

The storage memory is the memory declared outside of the user-defined functions and within the Contract context. For instance, in following example, the userBalances and withdrawn will be in the memory storage. This can also be identied by the SSTORE / SLOAD instructions.

`contract SendBalance {
    mapping ( address => uint ) userBalances ;
    bool withdrawn = false ;
(...)
}`

Storage contains all the contract state variables reside. Every contract has its own storage and it is persistent between function calls and quite expensive to use.

The storage is persistented in every account state. A contract is just an account in ethereum's state tree. Every account has a balance, a nonce, bytecode, and the root hash of a storage tree. For normal accounts, the byte code and storage hash are empty. For contracts, the bytecode is the contract's code and the storage hash is the merkle root hash of all the key-value pairs in the contract's storage. The only thing that goes in the block are the transactions themselves, and the merkle root hash of the entire state tree. To be a full node tho, you must keep all the key-value pairs for the state tree (where keys are addresses and values are serialized accounts) and for the storage trees for each contract account (where the keys are storage locations and values are storage values).

## Memory (Volatile)
This memory is mainly used when calling functions or for regular memory operations. The ocial documentation explicitly indicates that the EVM does not have traditional registers. Which means that the virtual stack previously discussed will be used primarily to push arguments to the instructions. The following is the excerpt explaining such behavior:

The second memory area is called memory, of which a contract obtains a freshly cleared instance for each message call. Memory is linear and can be addressed at byte level, but reads are limited to a width of 256 bits, while writes can be either 8 bits or 256 bits wide. Memory is expanded by a word (256-bit), when accessing (either reading or writing) a previously untouched memory word (ie. any offset within a word). At the time of expansion, the cost in gas must be paid. Memory is more costly the larger it grows (it scales quadratically).

Traditionally the MSTORE instruction is what we would generally consider to be the instruction responsible for adding data to the stack in any typical x86/x64 system. Therefore, the instructions MSTORE / MLOAD could be identied as such with respect to the x86/x64 system. Consequently, both mstore(where, what) and mload(where) are frequently used.
The second is “memory”, this is used to hold temporary values. It is erased between (external) function calls and is cheaper to use.

## Stack
It does not have the concept of registers. A virtual stack is being used instead for operations such as parameters for the opcodes. The EVM uses 256-bit values from that virtual stack. It has a maximum size of 1024 elements.

Stack is used to hold small local variables. It is almost free to use, but can only hold a limited amount of values.

EVM memory is transient. The EVM is not really a virtual machine (VM has a strong connotation for many) - it's just an interpreter for the EVM assembly language. As the interpreter runs, it maintains a stack (where each element is 32 bytes) and a memory byte-array, and has access to the contract's storage tree. The stack and memory byte-array are dropped when the execution completes. But yes, every single node runs the transaction - at any point in the execution, the state of the stack, the memory-byte array, the program counter, and the storage should be identical on each node.

## Some notes
For almost all types, you cannot specify where they should be stored, because they are copied everytime they are used.

The types where the so-called storage location is important are structs and arrays. If you e.g. pass such variables in function calls, their data is not copied if it can stay in memory or stay in storage. This means that you can modify their content in the called function and these modifications will still be visible in the caller.

There are defaults for the storage location depending on which type of variable it concerns:

state variables are always in storage
function arguments are in memory by default
local variables of struct, array or mapping type reference storage by default
local variables of value type (i.e. neither array, nor struct nor mapping) are stored in the stack

# updradable Ethereum Contract

One method is to use a System of Contracts as outlined below:

Contract "Register" - will contain pairs "name - address" for all contracts of your system;

Contract Backend;

Contract Frontend using Backend;

Deploy Register & get address of it;

Deploy Backend & register address of Backend into already deployed Register;

Hardcode the address of Register into source of Backend. Before any call Backend from Frontend you should call your Register and get the actual address of Backend.

Then you can update your Backend contract any time - simply deploy the new one and re-register them in the Register.

Calling external contract: https://solidity.readthedocs.io/en/latest/control-structures.html?highlight=extends#external-function-calls

# EVM Design philosophy

## Determinism

Ethereum, like all blockchains, is a trustless and decentralized network. Each node in the network must be able to validate all transactions and their code execution on their own. They have to do this to determine how much Ether each address owns after each transaction, and to decide whether or not to relay a transaction to other nodes. To accomplish this, all nodes have to agree with eachother what the exact execution flow of a contract execution was and what the state of the blockchain is.

For example, in the JVM you can request a random number, read a file or load data from the internet. These operations can return completely different results depending on which computer is executing them. They are therefore not deterministic. The JVM was not designed with determinism in mind. Most existing virtual machines do not guarantee determinism.

It is less work to write a new virtual machine from scratch than it would be to modify an existing virtual machine to fit the strict and precise requirements of Ethereum.

## Execution speed

As mentioned before, something like the JVM comes loaded with lots of features that aren't really useful in the case of Ethereum. This can only serve to slow down the execution of smart contracts. The execution speed of smart contracts is crucial to make the network affordable to use. If a contract executes twice as slowly, it would cost twice the transaction fees to use it.

## Security

The Ethereum virtual machine needs perfect security in very specific ways. For example, one contract should not be able to change the state of another contract. Using an existing virtual machine would be dubious because they were not written with Ethereum's special requirements in mind.

## Measuring execution effort

In a system like Ethereum, one would like small transactions that take very few CPU cycles to have small transaction fees. Large transactions that do a lot of computation should cost more, proportionally. To accomplish this, you need to measure how much effort it took to execute a contract code. You can't just measure time or CPU cycles, because those are implementation and machine-dependent. We want all the nodes on the network to agree on exactly how much effort it took.

Therefore, Ethereum uses the unit gas to measure the effort it took to execute a transaction. Each opcode in the EVM takes a certain universally agreed-upon amount of gas.

This dynamic transaction fee system provides the necessary economic incentive to senders of transactions and writers of contracts to reduce the use of storage space and CPU time on all nodes.

Pretty much no existing virtual machines come with such a counter.

## Binary size

Having less opcodes (only the ones needed for this specific purpose) means programs can be packed more tightly. This reduces blockchain size and transaction fees.
