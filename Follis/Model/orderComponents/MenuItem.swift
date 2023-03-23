//
//  MenuItem.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/9/23.
//

import Foundation
import FirebaseFirestoreSwift

struct MenuItem: Identifiable, Decodable, Hashable{
    

    // Reads doc id from collection without having to duplicate it as a field
    @DocumentID var id: String?

    var description: String
    var name: String
    var price: String
    var rewards: String
    var type: String
    var quantity: Int?
    var hash: Int?
    //var image: String



}
