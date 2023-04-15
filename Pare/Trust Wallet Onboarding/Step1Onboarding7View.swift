//
//  Step1Onboarding6View.swift
//  Pare
//
//  Created by Karthik  Ramu on 4/14/23.
//

import SwiftUI

struct Step1Onboarding7View: View {

    // MARK: - PROPERTIES

    // MARK: - BODY
    var body: some View {
        VStack{

            HStack{

                Text("Verify Secret Phrase")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.top)

                Spacer()

            } //: HSTACK

            HStack{

                Text("Tap each word from your secret phrase in order")
                    .padding(.leading)
                    .padding(.trailing)
                Spacer()
            } //: HSTACK

            HStack{

                Text("Think of this as confirming your password.")
                    .padding()
                    .font(.title3)

                Spacer()
            } //: HSTACK


            Image("TrustVerifyPhrase")
                .resizable()
                .frame(width: UIScreen.main.bounds.width - 50, height: 360)
                .scaledToFit()
                .cornerRadius(10)
                .padding()

            Spacer()

            NavigationLink {

                // Navigate to next view
                Step1CompleteView()

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
struct Step1Onboarding7View_Previews: PreviewProvider {
    static var previews: some View {
        Step1Onboarding7View()
    }
}
