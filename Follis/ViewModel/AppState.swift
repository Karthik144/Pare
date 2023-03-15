//
//  AppState.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/13/23.
//

import Foundation
import Combine

final class AppState : ObservableObject{
    @Published var rootViewId = UUID()
    @Published var moveToDashboard: Bool = false 
}
