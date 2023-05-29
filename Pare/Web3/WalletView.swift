//
//  WalletView.swift
//  Pare
//
//  Created by Karthik  Ramu on 5/28/23.
//

import SwiftUI


// MARK: - PROPERTIES

struct WalletView: View {

    // MARK: - BODY
    var body: some View {

        NavigationView{

            VStack(alignment: .leading){

                // Balance
                VStack(alignment: .leading){

                    Text("Your Balance")
                        .font(.title2)
                        .fontWeight(.light)

                    Text("45.00 USDC")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.accentColor)

                }
                .padding()
                .padding(.bottom, 20)

                LazyVStack{

                    // Option Cell #1
                    NavigationLink {

                        // Navigate to add funds view

                    } label: {
                        WalletOptionCell()

                    }
                    .buttonStyle(PlainButtonStyle()) // Remove the accent highlight


                    // Option cell #2
                    NavigationLink {
                        
                        // Navigate to wallet info

                    } label: {
                        WalletOptionCell()
                    }
                    .buttonStyle(PlainButtonStyle()) // Remove the accent highlight


                    // Options cell #3
                    NavigationLink {

                        // Navigate to learn more

                    } label: {
                        WalletOptionCell()
                    }
                    .buttonStyle(PlainButtonStyle()) // Remove the accent highlight


                } //: LAZY VSTACK

                Spacer()

            }
            .navigationTitle("Wallet")
            .navigationBarTitleDisplayMode(.large)

        } //: NAV VIEW

    } //: BODY
}

// MARK: - PREVIEW 
struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
    }
}
