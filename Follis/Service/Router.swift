//
//  Router.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/17/23.
//

import Foundation


class Router: ObservableObject {

    static let shared = Router()

    @Published var selectedTab = 1
}
