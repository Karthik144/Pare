//
//  OrderItem.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/14/23.
//

import Foundation
import FirebaseFirestoreSwift

struct OrderItem: Identifiable, Decodable, Hashable {

    // Reads doc id from collection without having to duplicate it as a field
    @DocumentID var id: String?
    var name: String
    var order_id: String

}
