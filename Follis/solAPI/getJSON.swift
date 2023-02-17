//
//  getJSON.swift
//  Follis
//
//  Created by Akhil Maheepathi on 2/17/23.
//

import Foundation

class getData : ObservableObject{
    @Published var balance = 0
    @Published var signature = "No Signature" //used to determine FROM PA
    @Published var fee = 0.0
    @Published var txAmt = 0
    @Published var from = ""
    
    
    //gets balance of associated wallet (JUST Takonako NOW)
    func getBalance(){
        let url = URL(string: "https://public-api.solscan.io/account/tokens?account=5G6NUZ2pjPRMcQcTLpwxELDyhUcLFj416gkAVi1Wjr2w")!
        Foundation.URLSession.shared.fetchData(for: url) { (result: Result<[sol], Error>) in
            switch result {
            case .success(let sols):
                self.balance = sols[0].tokenAmount.uiAmount
            case .failure(let error):
                print(error);
            }
        }
    }
    
    //Does 1 request for most recent transaction
    func getLastTransaction(){
        let url2 = URL(string: "https://public-api.solscan.io/account/splTransfers?account=5G6NUZ2pjPRMcQcTLpwxELDyhUcLFj416gkAVi1Wjr2w&limit=1&offset=0")!
        Foundation.URLSession.shared.fetchData(for: url2) { (result: Result<lastTransaction, Error>) in
            switch result {
            case .success(let transaction):
                self.txAmt = (transaction.data[0].changeAmount) / 1000000
                self.fee = (Double(transaction.data[0].fee) / 1000000000) * 0.26
                self.signature = transaction.data[0].signature[0]
            case .failure(let error):
                print(error);
            }
        }
    }
    
    //Inputs signature to find tx Sender PA
    
    func getSender(signature:String){
        let url3 = URL(string: "https://public-api.solscan.io/transaction/\(signature)")!
        URLSession.shared.fetchData(for: url3) { (result: Result<fromPA, Error>) in
            switch result {
            case .success(let sender):
                //self.from = sender.data[0]
                print(sender)
            case .failure(let error):
                print(error);
            }
        }
    }

    
    
    
}


    
    
