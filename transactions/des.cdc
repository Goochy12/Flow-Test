// import TestNFT from 0x2c6e02174593e45e

transaction{
    let minterRef: NFTMinter

    prepare(acct: AuthAccount){
        self.minterRef = acct.load<NFTMinter>(from: /storage/NFTMinter)
            ?? panic("Couldn't load")
    }

    execute{
        // self.nftMinter.destroy
    }
}