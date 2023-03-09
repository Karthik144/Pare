//
//  ContentView.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/13/23.
//

import SwiftUI

struct ContentView: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var router: Router
    
//    @State private var selection = 2

    
    // MARK: - BODY
    var body: some View {

        TabView(selection: $router.selectedTab) {
            ProfileView().tabItem({
                Image(systemName: "gearshape")
                Text("Settings")
            })
            .tag(1)

            ShopsView().tabItem({
                Image(systemName: "cart.circle")
                Text("Order")
            })
            .tag(2)

            WalletView().tabItem({
                Image(systemName: "dollarsign.circle")
                Text("Funds")
            })
            .tag(3)
        }

    }

}


// MARK: - PREVIEW
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

