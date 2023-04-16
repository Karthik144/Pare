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

    // MARK: - BODY
    var body: some View {

        VStack{

            HStack{

                Text("Search USD Coin (PoS)")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.top)

                Spacer()

            } //: HSTACK

            HStack{

                Text("Select the 'USD Coin (PoS)'")
                    .padding(.leading)
                    .padding(.trailing)
                Spacer()
                
            } //: HSTACK


            Image("TrustSelectUSDC")
                .resizable()
                .frame(width: UIScreen.main.bounds.width - 50, height: 360)
                .scaledToFit()
                .cornerRadius(10)
                .padding()

            Spacer()

            NavigationLink {

                // Navigate to next view
                Step2Onboarding3View(isActive: $isActive)

            } label: {



                VStack{

                    Text("Select Next only if you finished this step.")
                        .foregroundColor(Color.black)
                        .padding()
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

            Spacer()




        } //: VSTACK
    }
}


// MARK: - PREVIEW
//struct Step2Onboarding2View_Previews: PreviewProvider {
//    static var previews: some View {
//        Step2Onboarding2View()
//    }
//}
