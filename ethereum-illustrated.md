The document (https://github.com/takenobu-hs/ethereum-evm-illustrated) is very helpful during my ethereum learning process. I follow the flow of this slides and give more detailed introduction for my study. 

# Introduction

## Blockchain

Ethereum can be considerred as a transaction-based state machine. The state for the ethereum is called the world state and the transaction is the state transition function. The world state transite from state S(t) to S(t+1) by taking one transaction. Transactions are collated into blocks. A block contains a list of transactions. From the viewpoint of the states, ethereum can be seen as a state chain and the transactions in one block decide the state transition together. From the viewpoint of the implementation, ethereum can also been considerred as chain of blocks, so it is BLOCKCHAIN. From the viewpoint of the leger, ethereum can also be seen as a stack of transactions (from genesis block to the latest block). 

## World State

The state we metioned above is called World State. The world state is a mapping between address and account state. Each account is an object in the world state. An account state contains nonce, balance, account storage and EVM code. 

![ethereum internal](https://i.stack.imgur.com/afWDt.jpg)

## Account

There are two practical types of account: External owned account (EOA) and Contract account. EOA is controlled by a private key and it has nonce and balance fields. In addition to nonce and balance fields, contract account has storage hash and code hash that point to storage and evm code, respectively. The account address is identified by a 160-bit code. The address of EOA is generated by private key and public key. The address of contract account is the generated by sender address and nonce. 

## Transaction

A transaction is a single cryptographically-signed instruction. A transaction is submitted to the ethereum world by external actor who can be a person or other entity. There are two practical types of transaction, contract creation and message call. Contract creation message creates a new contract account address with the initial code. The message call message invokes a function in an address with the input data as the parameter of the function call and update the state of the corresponding address. A transaction contains nonce, gasPrice, gasLimit, to (160 bits address or 0 if contract creation), value (transferred wei), (v,r,s) and init or data (contract creation or message call). 

## Message

Message is passed between two Accounts. Message is Data (as a set of bytes) and Value (specified as Ether). Message can be triggerred a normal EOA or an EVM code. There are 4 cases of message in total. 2 are from EOA and the other 2 are from contract address. They are all can be sent to both EOA and contract address. 

## Decentralized database

A blockchain is a globally shared, decentralized, highly duplicated and transactional database. Decentralized nodes constitute Ethereum P2P network. External actors access the Ethereum world through Ethereum nodes and each node has a copy of world state. 

## Atomicity and order

A transaction is an atomic operation. Can't divide or interrupt. That is, All (complete done) or Nothing (zero effect). In implementation, transactions cannot be overlapped which means transactions mush be executed sequentially. However, I think the transactions without dependency actually can be executed concurrently. This maybe the optimization anyway. The transaction order happend outsides the ethereum world cannot be guaranteed as the sequence is determined by the miner. The miner chooses the transactions from the transaction pool and adds them into the block. Every miner has the oppotunity to decide the sequence the transactions in the generated block and the minning winner is decided by a consensus algorithm such as PoW.

# Virtual Machine

## Ethereum virtual machine (EVM)

EVM code is executed on Ethereum virtual machine (EVM). Transaction of message call invokes the contract code in the contract address with the parameters in the input data of message. The contract execution updates the state in the storage of the contract address. The Ethereum Virtual Machine is the runtime environment for smart contracts in Ethreum. The EVM is a simple stack-based architecture. It consists of 3 parts: EVM code (immutable), Machine state (volatile), World state (persistent). The machine state is similar to the program execution environme of normal os. It has the Program counter (PC), Stack, Memory and Gas. The gas here is a special component in ethereum to support the execution of EVM code. The world state is actually the persistent state of account. 

There are several storage resources inside EVM: stack, memory and account storage. Stack has 1024 elements and each element consists 256 bits. Memory is byte addressing and the address is increasing linearly.  Account storage is 256 bits to 256 bits key-value store.

For the stack, all operations (256-bit read/right) on the stack are performed on the stack top and the stack can be accessed with many instructions such as PUSH/POP/COPY/SWAP and et al. 

Memory is linear and can be addressed at byte level. Access with MSTORE/MSTORE8/MLOAD instructions. All locations in memory are well-defined initially as zero.

Storage is a key-value store that maps 256-bit words to 256-bit words. Access with SSTORE/SLOAD instructions. All locations in storage are well-defined initially as zero.

EVM Code is the bytecode that the EVM can natively execute. You can also get the assembly view of the bytecode. The evm instruction is converted to operations. The operations can perform push/pop operations from the stack and set the PC which is specified the next instruction of the evm code. The stack has limited space and it can randomly access the storage space in memory as well as storage.

## Message Call



# Implementation
