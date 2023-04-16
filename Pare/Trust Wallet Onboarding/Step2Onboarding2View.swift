//
//  Step2Onboarding2View.swift
//  Pare
//
//  Created by Karthik  Ramu on 4/15/23.
//

import SwiftUI

struct Step2Onboarding2View: View {

    // MARK: - PROPERTIES
    @Binding var isActive: Bool
    let trust: Bool 

    // MARK: - BODY
    var body: some View {

        ScrollView{

            HStack{

                Text("Search USDC")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.top)

                Spacer()

            } //: HSTACK

            HStack{

                if trust == true {
                    Text("Select the 'USD Coin (PoS)'")
                        .padding(.leading)
                        .padding(.trailing)
                } else {

                    Text("Select 'You want to buy' dropdown and select the 'USD Coin (PoS)'")
                        .padding(.leading)
                        .padding(.trailing)
                }

                Spacer()
                
            } //: HSTACK

            HStack{

                Text("It's important that you select this exact version of USDC.")
                    .padding()
                
                Spacer()

            } //: HSTACK

            HStack{

                Text("It's what offers no transaction fees for you and the merchant.")
                    .padding()
                
                Spacer()

            }

            Spacer()
            
            Image("usdcStep")
                .resizable()
                .frame(width: UIScreen.main.bounds.width - 50, height: 100)
                .scaledToFit()
                .cornerRadius(10)
                .padding()

            Spacer()

            NavigationLink {

                // Navigate to next view
                Step2Onboarding3View(isActive: $isActive, trust: trust)

            } label: {

                VStack(spacing: 5){

                    Text("Select Next only if you finished this step.")
                        .foregroundColor(Color.black)
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.top)
                        .font(.callout)

                    Text("Next")
                        .foregroundColor(Color.white)
                        .fontWeight(.semibold)
                        .frame(width: 300, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 8,  style: .continuous)
                                .fill(Color.accentColor)
                                .frame(width: 300, height: 50)
                        )

                } //: VSTACK

            } //: NAV LINK
            .padding()



        } //: SCROLL VIEW
    }
}


// MARK: - PREVIEW
//struct Step2Onboarding2View_Previews: PreviewProvider {
//    static var previews: some View {
//        Step2Onboarding2View()
//    }
//}
