//
//  Step3Onboarding3View.swift
//  Pare
//
//  Created by Karthik  Ramu on 4/15/23.
//

import SwiftUI

struct Step2Onboarding3View: View {

    // MARK: - PROPERTIES
    @Binding var isActive: Bool
    let trust: Bool 

    // MARK: - BODY
    var body: some View {

        ScrollView{

            HStack{

                Text("Enter amount to buy")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.top)

                Spacer()

            } //: HSTACK

            HStack{

                Text("Each USDC coin equals one dollar")
                    .padding(.leading)
                    .padding(.trailing)
                Spacer()

            } //: HSTACK

            HStack{

                Text("The amount you purchase will be slightly less since there's a purchasing fee. This should decrease over time.")
                    .padding()

                Spacer()
            } //: HSTACK


            if trust == true {

                Image("TrustPurchaseAmount")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width - 50, height: 360)
                    .scaledToFit()
                    .cornerRadius(10)
                    .padding()
            } else {

                Image("MetaPurchaseAmount")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width - 50, height: 360)
                    .scaledToFit()
                    .cornerRadius(10)
                    .padding()
            }


            Spacer()

            NavigationLink {

                // Navigate to next view
                Step2Onboarding4View(isActive: $isActive, trust: trust)

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

            Spacer()




        } //: SCROLL VIEW
    }
}


// MARK: - PREVIEW
//struct Step3Onboarding3View_Previews: PreviewProvider {
//    static var previews: some View {
//        Step2Onboarding3View()
//    }
//}
