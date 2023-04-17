//
//  PayOptionView.swift
//  Pare
//
//  Created by Karthik  Ramu on 4/10/23.
//

import SwiftUI

struct PayOptionView: View {

    // MARK: - PROPERTIES
    let shop: Shop
    let rewards: Bool
    @Binding var rootIsActive: Bool
    let noteText: String

    // MARK: - BODY
    var body: some View {

        VStack{

            HStack{
                Text("How would you like to pay?")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding()

                Spacer()

            } //: HSTACK

            VStack(spacing: 5){

                NavigationLink {

                    // Navigate to trust wallet view
                    PaySubView(shop: shop, rewards: rewards, rootIsActive: $rootIsActive, noteText: noteText)
                } label: {
                    HStack{

                        HStack {
                            Image(systemName: "wallet.pass")
                                .foregroundColor(Color.accentColor)
                            Text("TrustWallet")
                                .foregroundColor(Color.black)

                        } //: HSTACK
                        .padding()


                        Spacer()

                        Image(systemName: "chevron.right")
                            .foregroundColor(Color.black)
                        .padding()

                    } //: HSTACK
                    .padding()
                } //: NAV LINK



                NavigationLink {

                    PayWithMetaMaskView(shop: shop, rewards: rewards, rootIsActive: $rootIsActive, noteText: noteText)

//                    PaySubView(shop: shop, rewards: rewards, rootIsActive: $rootIsActive, noteText: noteText)
                } label: {
                    HStack{

                        HStack {
                            Image(systemName: "bitcoinsign.circle.fill")
                                .foregroundColor(Color.orange)
                            Text("MetaMask")
                                .foregroundColor(Color.black)

                        } //: HSTACK
                        .padding()


                        Spacer()

                        Image(systemName: "chevron.right")
                            .foregroundColor(Color.black)
                        .padding()

                    } //: HSTACK
                    .padding()

                }





            } //: VSTACK


            Spacer()


        } //: VSTACK

    }
}


// MARK: - PREVIEW
//struct PayOptionView_Previews: PreviewProvider {
//    static var previews: some View {
//        PayOptionView()
//    }
//}
