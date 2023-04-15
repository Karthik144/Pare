//
//  Step1Onboarding4View.swift
//  Pare
//
//  Created by Karthik  Ramu on 4/14/23.
//

import SwiftUI

struct Step1Onboarding4View: View {

    // MARK: - PROPERTIES

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
            .padding(.bottom, 70)

            Image("TrustCreateWallet")
                .resizable()
                .frame(width: UIScreen.main.bounds.width - 50, height: 300)
                .scaledToFit()
                .cornerRadius(10)
                .padding()



            NavigationLink {

                // Navigate to next view
                Step1Onboarding5View()

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
                .padding(.bottom)

            }

            Spacer()




        } //: VSTACK
    }
}


// MARK: - PREVIEW 
struct Step1Onboarding4View_Previews: PreviewProvider {
    static var previews: some View {
        Step1Onboarding4View()
    }
}
