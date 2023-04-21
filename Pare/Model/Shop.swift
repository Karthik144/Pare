//
//  Shop.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/8/23.
//


import Foundation
import FirebaseFirestoreSwift

struct Shop: Identifiable, Decodable, Equatable{

    // Reads doc id from collection without having to duplicate it as a field
    @DocumentID var id: String?

    var address: String
    var name: String
    var rating: String
    var type: String
    var cuisine: String
    var merchant_id: String?
    var image: String
    
}
