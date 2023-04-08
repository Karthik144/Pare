//
//  WalletView.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/7/23.
//

import SwiftUI

struct WalletView: View {

    // MARK: - PROPERTIES

    // MARK: - BODY
    var body: some View {

        NavigationView{

            Form {

                Text("Public address")

            } //: FORM
            .navigationTitle("Wallet")
            .navigationBarTitleDisplayMode(.large)


        } //: NAV VIEW
            
    }
}


// MARK: - PREVIEW
struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
    }
}
