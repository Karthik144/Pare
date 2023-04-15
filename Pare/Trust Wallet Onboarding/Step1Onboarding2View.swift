//
//  Step1Onboarding2View.swift
//  Pare
//
//  Created by Karthik  Ramu on 4/14/23.
//

import SwiftUI

struct Step1Onboarding2View: View {
    var body: some View {

        VStack {
            VStack(alignment: .leading){

                HStack{

                    Text("Select a wallet")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.leading)

                    Spacer()
                } //: HSTACK
                .padding(.top)

                HStack{

                    Text("Choose a wallet to use with Pare.")
                        .padding(.leading)

                    Spacer()
                } //: HSTACK

                Group(){

                    HStack{

                        Text("Trust Wallet")
                            .fontWeight(.bold)
                            .padding(.top)
                            .padding(.leading)
                            .padding(.trailing)

                        Spacer()

                    } //: HSTACK

                    HStack{

                        Text("Requires you to load a minimum of $30. But will integrate well with Pare in 3 days.")
                            .padding(.leading)
                            .padding(.trailing)


                        Spacer()

                    } //: HSTACK

                    NavigationLink {

                        Step1Onboarding3View()
                        
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

                } //: GROUP

                Group{

                    HStack{

                        Text("MetaMask Wallet")
                            .fontWeight(.bold)
                            .padding(.top)
                            .padding(.leading)
                            .padding(.trailing)

                        Spacer()

                    } //: HSTACK

                    HStack{

                        Text("Requires you to load a minimum of $20.")
                            .padding(.leading)
                            .padding(.trailing)


                        Spacer()

                    } //: HSTACK

                    NavigationLink {
                        //                    PaySubView(shop: shop, rewards: rewards, rootIsActive: $rootIsActive, noteText: noteText)
                    } label: {
                        HStack{

                            HStack {
                                Image(systemName: "bitcoinsign.circle.fill")
                                    .foregroundColor(Color.orange)
                                Text("Meta Mask")
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

                } //: GROUP

            } //: VSTACK

            Spacer()


        } //: VSTACK
    }
}

struct Step1Onboarding2View_Previews: PreviewProvider {
    static var previews: some View {
        Step1Onboarding2View()
    }
}
