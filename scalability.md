https://medium.com/coinmonks/these-three-projects-are-shaping-the-future-of-ethereum-778ab41b34b5

# Casper

Arguably the most famous and widely expected Ethereum project, Casper presents an alternative to Ethereum’s traditional proof of work(PoW) algorithm with a modern proof-of-stake(PoS) model that can drastically speed up the transaction commit times in the network. A lot has been written about Casper so I am not planning to bore you with the details but there are a couple of things that are worth recapping. First, let’s take a high level at how Casper works. The PoS protocol is based on traditional Byzantine Fault Tolerance (BFT) models and can be summarize in these simple steps.

Its important to understand that Casper is not a single project. Instead, Casper can be seem as a collection of projects. The Casper the Friendly Finality Gadget (FFG) is a hybrid POW/POS consensus mechanism. This is the version of Casper that is going to be implemented first. This is pretty much designed to ease the transition into proof of stake. The way it is designed is that there is a proof-of-stake protocol overlaying on top of the normal ethash proof of work protocol. So while blocks are still going to be mined via POW, every 50th block is going to be a POS checkpoint where finality is assessed by a network of validators.

The other Casper project is known as Casper CBC as it uses the correct-by-construction (CBC) protocol. Casper CBC differs in approach from traditional protocol design:

(1) the protocol is partially specified in the beginning

(2) the rest of the protocol is derived in a way that is proven to satisfy the desired/requisite properties (typically protocol is fully defined then tested to satisfy the said properties).

# Plasma

Ethereum Plasma is another one of the soon to be released projects that can result very influential in the future of Ethereum. The origins of Plasma date back to August 11 2017, when Vitalik Buterin and Joseph Poon released a paper titled Plasma: Autonomous Smart Contracts. The main idea behind Plasma is to provide a model that enables the execution of off-chain transactions while relying on the underlying ethereum blockchain to ground its security. The desigm of Plasma borrows some of the ideas from the Lightning Network but it expand the concept by allowing for the creation of “child” blockchains attached to the “main” Ethereum blockchain.

In the Plasma model, complex transactions cane be executed in child-blockchains, running entire applications with many thousands of users, with only minimal interaction with the Ethereum main-chain. A Plasma child-chain can move faster, and charge lower transaction fees, because operations on it do not need to be replicated across the entire Ethereum blockchain.

# Sharding

My third favorite Ethereum layer 2 scaling solution is Sharding. As it names indicates, Ethereum sharing borrows a few concepts from the scaling architectures of modern NoSQL databases. In essence, Ethereum sharing splits the entire state of the network into a bunch of partitions called shards that contain their own independent piece of state and transaction history. In this system, certain nodes would process transactions only for certain shards, allowing the throughput of transactions processed in total across all shards to be much higher than having a single shard do all the work as the mainchain does now.

# A Better Ethereum

So there you have it, while the scalability concerns of Ethereum are certainly serious, you can argue that the layer 2 solutions produced by the Ethereum Foundation are among the most advanced scalability solutions in the crypto space. Certainly, Casper, Plasma and Sharding and a trio that promises to address the fundamental scalability challenges of Ethereum and pave the way for more innovative and scalable protocols.
