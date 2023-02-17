//
//  Order.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/16/23.
//

import Foundation


struct Order: Identifiable {
    var id = UUID()
    
    var itemName: String
    var itemQuantity: Int
    var itemPrice: Double
}
