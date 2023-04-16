//
//  Step2Onboarding1View.swift
//  Pare
//
//  Created by Karthik  Ramu on 4/15/23.
//

import SwiftUI

struct Step2Onboarding1View: View {

    // MARK: - PROPERTIES
    @Binding var isActive: Bool
    let trust: Bool

    // MARK: - BODY
    var body: some View {

        VStack{

            HStack{

                Text("Purchase USDC")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.top)

                Spacer()

            } //: HSTACK

            HStack{

                Text("Select the 'Buy' button")
                    .padding(.leading)
                    .padding(.trailing)
                Spacer()
            } //: HSTACK

            HStack{

                Text("Think of this as loading in money into your account.")
                    .padding()

                Spacer()
            } //: HSTACK

            Spacer()

            Image("TrustBuy")
                .resizable()
                .frame(width: UIScreen.main.bounds.width - 50, height: 100)
                .scaledToFit()
                .cornerRadius(10)
                .padding()


            Spacer()

            NavigationLink {

                // Navigate to next view
                Step2Onboarding2View(isActive: $isActive, trust: trust)

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




        } //: VSTACK
    }
}


// MARK: - PREVIEW
//struct Step2Onboarding1View_Previews: PreviewProvider {
//    static var previews: some View {
//        Step2Onboarding1View()
//    }
//}
