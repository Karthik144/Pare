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
    var name: String
    var pay_pal_link: String
}
