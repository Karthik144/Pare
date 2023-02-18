//
//  transaction.swift
//  Follis
//
//  Created by Akhil Maheepathi on 2/17/23.
//

import Foundation

struct Transaction : Identifiable{
    var txAmt : Double
    var fee : Double
    var from: String
    var id = UUID()
}
