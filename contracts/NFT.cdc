pub contract TestNFT {

    pub resource NFT{

        pub let id: UInt64
        pub var metadata: {String: String}

        init(initID: UInt64){
            self.id = initID
            self.metadata = {}  //initialise as empty - could test differnet parameters
        }
    }

    pub resource interface NFTReceiver{

        pub fun deposit(token: @NFT)    //do we need a deposit function?

        pub fun getIDs(): [UInt64]  //return a list of IDs

        pub fun idExists(id: UInt64): Bool  //check if an id exists
    }

    // pub resource Collection: NFTReceiver{

    // }

    pub resource NFTMinter{
        pub var idCount: UInt64

        init(){
            self.idCount = 1
        }

        pub fun mintNFT(): @NFT {
            var newNFT <- create NFT(initID: self.idCount)

            self.idCount = self.idCount + 1 as UInt64

            return <- newNFT
        }
    }

    init(){
        // self.account.save(<-self.createEmptyCollection(), to: /storage/NFTCollection)

        // self.account.link<&{NFTReceiver}>(/public/NFTReceiver, target: /storage/NFTCollection)

        self.account.save(<-create NFTMinter(), to: /storage/NFTMinter)
    }

}