//
//  PendingOrder.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/12/23.
//

import Foundation
import FirebaseFirestoreSwift

struct PendingOrder: Identifiable, Decodable {

    // Reads doc id from collection without having to duplicate it as a field
    @DocumentID var id: String?
    var date_ordered: Date
    var shop_id: String
    var total_items: String
    var user_who_ordered: String
    var pending: Bool
    var complete: Bool
    var subtotal: Double
    var total: Double

}
