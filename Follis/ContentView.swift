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
    @State private var selection = 2


    // MARK: - BODY
    var body: some View {

        TabView(selection: $selection) {

            SettingsView().tabItem({
                Image(systemName: "gearshape")
                Text("Settings")
            })
            .tag(1)

            TransactionView().tabItem({
                Image(systemName: "cart.circle")
                Text("Order")
            })
            .tag(2)

            FundsView().tabItem({
                Image(systemName: "dollarsign.circle")
                Text("Share")
            })
            .tag(3)

        }




    }
}


// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

