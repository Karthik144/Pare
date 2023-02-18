//
//  decodeJSON.swift
//  Follis
//
//  Created by Akhil Maheepathi on 2/17/23.
//

import Foundation

//Struct Types for revenue/total balance
struct sol: Decodable{
    let tokenSymbol: String
    let tokenAmount: TokenAmount
}
struct TokenAmount: Decodable{
    let uiAmount: Int
}


//Struct Types for Signature,Amount, Fee
struct lastTransaction: Decodable{
    let data: [transactionData]
    let total : Int
}

struct transactionData: Decodable{
    let changeAmount: Double
    let fee: Double
    let signature: [String]
}

//Struct Types for From/Sender
struct fromPA: Decodable{
    let signer: [String]
}
