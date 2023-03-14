//
//  Order.swift
//  Follis
//
//  Created by Akhil Maheepathi on 3/14/23.
//

import Foundation


class Order: Hashable, ObservableObject, Identifiable{
    
    //Class properties
    @Published var item: MenuItem
    @Published var requiredSelection: [Required]?
    @Published var modifications: [Modification]?
    @Published var addOns: [Add]?

    
    
    //Initalize Class Object
    init(item: MenuItem,requiredSelection: [Required]? = [], modifications: [Modification]? = [], addOns: [Add]? = []){
        self.item = item
        self.requiredSelection = requiredSelection
        self.modifications = modifications
        self.addOns = addOns
    }
    
    
    //To conform to Equatable protocol, allows us to use '==' operator for Order objects
    static func == (lhs: Order, rhs: Order) -> Bool {
        return lhs.item == rhs.item && lhs.requiredSelection == rhs.requiredSelection && lhs.modifications == rhs.modifications && lhs.addOns == rhs.addOns
    }
    
    //To conform to Hashable protocol
    func hash(into hasher: inout Hasher){
        hasher.combine(item)
        hasher.combine(requiredSelection)
        hasher.combine(modifications)
        hasher.combine(addOns)
    }
    
    //Utility function to retrieve total AddOns value for an the order instance
    func getAddOns() -> String{
        var sum: Double = 0
        for addOn in self.addOns ?? []{
            sum += Double(addOn.price)!
        }
        
        return String(sum)
    }
    
    
    
    
}
