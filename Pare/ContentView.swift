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
    @StateObject var walletViewModel : web3ViewModel
//    @EnvironmentObject var router: Router
    @State private var selection = 2
    
    @State var setupActive : Bool = true

    
    // MARK: - BODY
    var body: some View {

        TabView(selection: $selection) {

            ProfileView().tabItem({
                Image(systemName: "person.circle")
                Text("Profile")
            })
            .tag(1)

            ShopsView(setupActive: $setupActive).tabItem({
                Image(systemName: "cart.circle")
                Text("Order")
            })
            .tag(2)

            /*
            WalletView().tabItem({
                Image(systemName: "wallet.pass.fill")
                Text("Wallet")
            })
            .tag(3)
             */

        } //: TAB VIEW

    } //: BODY VIEW

} //: CONTENT VIEW


// MARK: - PREVIEW
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

