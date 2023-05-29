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
                        AddFundsView()

                    } label: {
                        WalletOptionCell(title: "Add funds", subTitle: "Buy more USDC")
                    }
                    .buttonStyle(PlainButtonStyle()) // Remove the accent highlight


                    // Option cell #2
                    NavigationLink {
                        
                        // Navigate to wallet info
                        WalletInfoView()

                    } label: {
                        WalletOptionCell(title: "View wallet info", subTitle: "View your public address & more")
                    }
                    .buttonStyle(PlainButtonStyle()) // Remove the accent highlight


                    // Options cell #3
                    NavigationLink {

                        // Navigate to learn more
                        LearnMoreView()
                        
                    } label: {
                        WalletOptionCell(title: "Learn more", subTitle: "What is a Wallet? What USDC?")
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
