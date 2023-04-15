//
//  Step3Onboarding4View.swift
//  Pare
//
//  Created by Karthik  Ramu on 4/15/23.
//

import SwiftUI

struct Step2Onboarding4View: View {

    // MARK: - PROPERTIES
    @Binding var isActive: Bool 

    // MARK: - BODY
    var body: some View {

        VStack{

            HStack{

                Text("Select Payment Details & Enter Info")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.top)

                Spacer()

            } //: HSTACK


            HStack{

                Text("Select if you'd like to pay with Apple Pay, Credit Card, or an ACH Transfer")
                    .padding()
                    .font(.title3)

                Spacer()
            } //: HSTACK

            HStack{

                Text("You'll then be prompted to enter personal info to verify your identity. So think of it as setting up a Venmo account.")
                    .padding()
                    .font(.title3)

                Spacer()
            } //: HSTACK


            // Insert image here

            Spacer()

            NavigationLink {

                // Navigate to next view
                Step2CompleteView(isActive: $isActive)
                
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
//struct Step3Onboarding4View_Previews: PreviewProvider {
//    static var previews: some View {
//        Step2Onboarding4View()
//    }
//}
