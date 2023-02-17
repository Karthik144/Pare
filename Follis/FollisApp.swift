//
//  FollisApp.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/13/23.
//

import SwiftUI
import Firebase

@main
struct FollisApp: App {

    init(){
        FirebaseApp.configure()
    }

    @StateObject var viewModel = AuthViewModel()
    @ObservedObject var appState = AppState()



    var body: some Scene {
        WindowGroup {
            WelcomeView()
                .environmentObject(viewModel)
                .environmentObject(appState)
                .environmentObject(Router.shared)
        }
    }
}
