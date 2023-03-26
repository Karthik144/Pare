//
//  User2.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/15/23.
//

import FirebaseFirestoreSwift

struct UserCheck: Identifiable, Decodable {

    var id: String?
    var email: String
}
