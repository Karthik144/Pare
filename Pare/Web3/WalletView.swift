//
//  WalletView.swift
//  Pare
//
//  Created by Karthik  Ramu on 5/28/23.
//

import SwiftUI
import MagicSDK
import MagicSDK_Web3


struct WalletView: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var walletViewModel: WalletViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject var magicSingleton = MagicSingleton.shared
    @State private var tokenBalance: BigUInt = 0

    // MARK: - BODY
    var body: some View {

        NavigationView{

            VStack(alignment: .leading){

                // Balance
                VStack(alignment: .leading){

                    Text("Your Balance")
                        .font(.title2)
                        .fontWeight(.light)


                    Text("\(String(describing: walletViewModel.userTokenBalance)) USDC")
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
                        FourStoryView()

                    } label: {
                        WalletOptionCell(title: "Add funds", subTitle: "Buy more USDC", image: "dollar_note")
                        
                    }
                    .buttonStyle(PlainButtonStyle()) // Remove the accent highlight


                    // Option cell #2
                    NavigationLink {
                        
                        // Navigate to wallet info
                        WalletInfoView()

                    } label: {
                        WalletOptionCell(title: "View wallet info", subTitle: "View your public address & more", image: "money_bag")
                    }
                    .buttonStyle(PlainButtonStyle()) // Remove the accent highlight


                    // Options cell #3
                    NavigationLink {

                        // Navigate to learn more
                        LearnMoreView()
                        
                    } label: {
                        WalletOptionCell(title: "Learn more", subTitle: "What is a Wallet? What USDC?", image: "question_mark")
                    }
                    .buttonStyle(PlainButtonStyle()) // Remove the accent highlight


                } //: LAZY VSTACK

                Spacer()

            }
            .navigationTitle("Wallet")
            .navigationBarTitleDisplayMode(.large)
            .onAppear(){

                walletViewModel.getBalance(magic: magicSingleton.magic, userPublicAddress: authViewModel.currentUser?.public_address ?? "") { balance in

                    if let balance = balance {
                        tokenBalance = balance

                    } else {
                        print("Error retrieving balance. - WalletView")
                    }
                }
            } //: ON APPEAR

        } //: NAV VIEW

    } //: BODY
}

// MARK: - PREVIEW 
struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
    }
}
