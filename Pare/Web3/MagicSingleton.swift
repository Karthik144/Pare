//
//  MagicSingleton.swift
//  Pare
//
//  Created by Karthik  Ramu on 5/28/23.
//

import Foundation
import MagicSDK
import MagicSDK_Web3

class MagicSingleton : ObservableObject {

    static let shared = MagicSingleton()
    @Published var magic: Magic

    private init() {
        
        // Test network
//        let config = CustomNodeConfiguration(rpcUrl: "https://rpc-mumbai.maticvigil.com/", chainId: 80001)
        let config = CustomNodeConfiguration(rpcUrl: "https://polygon-rpc.com/", chainId: 137)

        self.magic = Magic(apiKey: "pk_live_477976071EF69C48", customNode: config)

    }

}
