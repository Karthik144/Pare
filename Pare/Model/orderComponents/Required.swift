//
//  Required.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/9/23.
//

import Foundation
import FirebaseFirestoreSwift


struct Required: Identifiable, Decodable, Hashable{

    // Reads doc id from collection without having to duplicate it as a field
    @DocumentID var id: String?

    var option: String


}
