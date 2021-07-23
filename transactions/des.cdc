import TestNFT from 0x2c6e02174593e45e

transaction{
    let minterRef: &TestNFT.NFTMinter
    let nftRef: &TestNFT

    prepare(acct: AuthAccount){
        self.minterRef = acct.borrow<&TestNFT.NFTMinter>(from: /storage/NFTMinter)
            ?? panic("Couldn't borrow")
    }

    execute{
        // self.nftMinter.destroy
    }
}