//
//  ShopViewModel.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/8/23.
//

import Foundation


class ShopViewModel: ObservableObject {

    // MARK: - PROPERTIES
    @Published var shops = [Shop]()
    let service = ShopService()

    init(){
        fetchShops()
    }


    func fetchShops(){

        service.fetchShops { shops in

            // Store all the shops from Firebase into published array 
            self.shops = shops
        }

        
    }
}
