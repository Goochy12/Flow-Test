pub contract TestNFT {

    pub resource NFT{

        pub let id: UInt64
        pub var metadata: {String: String}

        init(initID: UInt64){
            self.id = initID
            self.metadata = {}
        }
    }

}