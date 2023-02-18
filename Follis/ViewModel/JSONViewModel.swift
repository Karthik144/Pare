//
//  getJSON.swift
//  Follis
//
//  Created by Akhil Maheepathi on 2/17/23.
//

import Combine
import Foundation
import Firebase
import FirebaseFirestoreSwift

class JSONViewModel : ObservableObject{
    //Firebase vars
    @Published var balance = 0.00
    @Published var feeSum = 0.00
    @Published var orderNum = 0
    @Published var transactions = [Transaction]()
    
    //API vars
    @Published var txAmt = 0.00
    @Published var reqOrderNum = 0
    @Published var fee = 0.00
    @Published var signature = "No Signature" //used to determine FROM PA
    @Published var from = ""
    
    func getAPITransactions(){
        guard let url = URL(string: "https://public-api.solscan.io/account/splTransfers?account=5G6NUZ2pjPRMcQcTLpwxELDyhUcLFj416gkAVi1Wjr2w&limit=1&offset=0") else {return}
        
        let request = URLRequest(url: url)


        URLSession.shared.dataTask(with: request){ (data,response,error) in
            guard error == nil else {print(error!.localizedDescription); return }
            let theData = try! JSONDecoder().decode(lastTransaction.self, from: data!)
                        DispatchQueue.main.async {
                            self.reqOrderNum = theData.total
                            self.txAmt = theData.data[0].changeAmount / 1000000
                            self.fee = (theData.data[0].fee / 1000000000) * 0.26
                            self.signature = theData.data[0].signature[0]
                            print(self.signature)
                        }
        }
        .resume()
    }
    
    
    func getSender(){
        guard let url = URL(string: "https://public-api.solscan.io/transaction/\(self.signature)") else {return}
        
        let request = URLRequest(url: url)


        URLSession.shared.dataTask(with: request){ (data,response,error) in
            guard error == nil else {print(error!.localizedDescription); return }
            let theData = try! JSONDecoder().decode(fromPA.self, from: data!)
                        DispatchQueue.main.async {
                            self.from = theData.signer[0]
                        }
        }
        .resume()
    }
    
    
    
    func getSummary(){
        Firestore.firestore().collection("Funds").document("rbS7KAdOMhyFqslKiNlC")
            .addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                guard let data = document.data() else {
                    print("Document data was empty.")
                    return
                }
                self.balance = data["Balance"] as? Double ?? 0
                self.feeSum = data["Fees"] as? Double ?? 0
                self.orderNum = data["orderNum"] as? Int ?? 0                
            }
        
    }
    
    func addTransaction(){
        //getSender()
        let uid = UUID()
        Firestore.firestore().collection("Funds").document("rbS7KAdOMhyFqslKiNlC").collection("Transactions").document("\(uid)").setData(["From": self.signature, "fee": self.fee, "txAmt": self.txAmt]){ _ in
            print("User data successfully uploaded.")
        }
        
        Firestore.firestore().collection("Funds").document("rbS7KAdOMhyFqslKiNlC").setData(["Balance": self.balance + self.txAmt, "Fees": self.feeSum + self.fee, "orderNum": (self.orderNum + 1)]){ _ in
            print("User data successfully uploaded.")
        }
        
        
        
    }
    
    func getTransactions(){
        Firestore.firestore().collection("Funds").document("rbS7KAdOMhyFqslKiNlC").collection("Transactions").addSnapshotListener{ (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else{
                print("No Documents")
                return
            }
            
            self.transactions = documents.map{ (queryDocumentSnapshot) -> Transaction in
                let data = queryDocumentSnapshot.data()
                
                
                let from = data["From"] as? String ?? ""
                let fee = data["fee"] as? Double ?? 0
                let txAmt = data["txAmt"] as? Double ?? 0
                
                return Transaction(txAmt: txAmt, fee: fee, from: from)
                
            }
        }
    }
        
        //gets balance of associated wallet (JUST Takonako NOW)
    /*
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
        }*/
    
    
    
    
        
        //Does 1 request for most recent transaction
    /*
        func getLastTransaction() -> AnyPublisher<lastTransaction,Error>{
            let url2 = URL(string: "https://public-api.solscan.io/account/splTransfers?account=5G6NUZ2pjPRMcQcTLpwxELDyhUcLFj416gkAVi1Wjr2w&limit=1&offset=0")!
            Foundation.URLSession.shared.fetchData(for: url2) { (result: Result<lastTransaction, Error>) in
                switch result {
                case .success(let transaction):
                    print(transaction)
                    self.reqOrderNum = transaction.total
                    self.txAmt = (transaction.data[0].changeAmount) / 1000000
                    self.fee = (Double(transaction.data[0].fee) / 1000000000) * 0.26
                    self.signature = transaction.data[0].signature[0]
                case .failure(let error):
                    print("FAILURE")
                    print(error);
                }
            }
        }*/
        
        //Inputs signature to find tx Sender PA
        /*
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
        */
        
        
        
}
    
    

    
