//
//  User.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/13/23.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {

    // Reads doc id from collection without having to duplicate it as a field
    @DocumentID var id: String?
    var email: String
    var first_name: String
    var public_address: String
    var is_merchant: Bool
    var last_name: String
    var cart_active: Bool
    var rewards: Double
    var wallet: Bool?
    var used_promo_code: Bool? 
}
