pub contract FullNFT {

    pub resource NFT{

        pub let id: UInt64
        pub var metadata: {String: String}

        init(initID: UInt64, initMetadata: {String: String}){
            self.id = initID
            self.metadata = initMetadata  //initialise as empty - could test differnet parameters
        }

        pub fun getID(): UInt64{
            return self.id
        }
    }

    pub resource interface NFTReceiver{

        pub fun deposit(token: @NFT)    //do we need a deposit function?

        pub fun getIDs(): [UInt64]  //return a list of IDs

        pub fun idExists(id: UInt64): Bool  //check if an id exists
    }

    pub resource Collection: NFTReceiver{

        pub var ownedNFTs: @{UInt64: NFT}

        init(){
            self.ownedNFTs <- {}
        }

        pub fun withdraw(withdrawID: UInt64): @NFT{
            let token <- self.ownedNFTs.remove(key: withdrawID)!

            return <- token
        }

        pub fun deposit(token: @NFT){
            self.ownedNFTs[token.id] <-! token
        }

        pub fun getIDs(): [UInt64]{
            return self.ownedNFTs.keys
        }

        pub fun idExists(id: UInt64): Bool{
            return self.ownedNFTs[id] != nil
        }

        destroy(){
            destroy self.ownedNFTs
        }
    }

    pub fun createEmptyCollection(): @Collection{
        return <- create Collection()
    }

    pub resource NFTMinter{
        pub var idCount: UInt64

        init(){
            self.idCount = 1
        }

        pub fun mintNFT(): @NFT {
            var newNFT <- create NFT(initID: self.idCount, initMetadata: {"TestKey": "TestValue"})

            self.idCount = self.idCount + 1 as UInt64

            return <- newNFT
        }
    }

    init(){
        self.account.save(<-self.createEmptyCollection(), to: /storage/NFTCollection)

        self.account.link<&{NFTReceiver}>(/public/NFTReceiver, target: /storage/NFTCollection)

        self.account.save(<-create NFTMinter(), to: /storage/NFTMinter)
    }

}