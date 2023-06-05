//
//  OrderItem.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/14/23.
//

import Foundation
import FirebaseFirestoreSwift

struct OrderItem: Identifiable, Decodable {

    // Reads doc id from collection without having to duplicate it as a field
    @DocumentID var id: String?
    var order_id: String
    var name: String
    var price: String
    var rewards: String
    var quantity: Int
    var type: String?


}
