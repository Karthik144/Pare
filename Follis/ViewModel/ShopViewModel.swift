//
//  ShopViewModel.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/8/23.
//

import Foundation
import Firebase


class ShopViewModel: ObservableObject {


    // MARK: - PROPERTIES
    @Published var shops = [Shop]()
    let service = ShopService()


    init(){
        fetchShops()
    }


//    func fetchShops() {
//
//        Firestore.firestore().collection("shops").addSnapshotListener { (querySnapshot, error) in
//
//            guard let documents = querySnapshot?.documents else {
//                print("No documents in this collection.")
//                return
//
//            }
//
//
//            self.shops = documents.compactMap({ try? $0.data(as: Shop.self) })
//
//
//        }
//
//        print("Count: " + String(shops.count))
//
//    }

    func fetchShops(){

        Firestore.firestore().collection("shops").addSnapshotListener{ (querySnapshot, error) in

            guard let documents = querySnapshot?.documents else{
                print("No Documents")
                return
            }

            self.shops = documents.map{ (queryDocumentSnapshot) -> Shop in

                let data = queryDocumentSnapshot.data()

                let address = data["address"] as? String ?? ""
                let cuisine = data["cuisine"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let rating = data["rating"] as? String ?? ""
                let type = data["type"] as? String ?? ""
                let uid = queryDocumentSnapshot.documentID

                return Shop(id: uid, address: address, name: name, rating: rating, type: type, cuisine: cuisine)

            }
        }

    } //: FUNC GET ORDER DATA


}
