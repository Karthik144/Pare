//
//  Step1Onboarding4View.swift
//  Pare
//
//  Created by Karthik  Ramu on 4/14/23.
//

import SwiftUI

struct Step1Onboarding4View: View {

    // MARK: - PROPERTIES
    @Binding var isActive: Bool

    // MARK: - BODY
    var body: some View {

        VStack{

            HStack{

                Text("Select 'Create a New Wallet'")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.top)

                Spacer()

            } //: HSTACK


            Spacer()

            Image("TrustCreateWallet")
                .resizable()
                .frame(width: UIScreen.main.bounds.width - 50, height: 315)
                .scaledToFit()
                .cornerRadius(10)
                .padding()


            Spacer()

            NavigationLink {

                // Navigate to next view
                Step1Onboarding5View(isActive: $isActive)

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

            }
            .padding() 

            Spacer()


        } //: VSTACK
    }
}


// MARK: - PREVIEW 
//struct Step1Onboarding4View_Previews: PreviewProvider {
//    static var previews: some View {
//        Step1Onboarding4View()
//    }
//}
