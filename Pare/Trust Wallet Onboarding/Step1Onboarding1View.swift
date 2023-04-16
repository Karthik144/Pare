//
//  Step1Onboarding1View.swift
//  Pare
//
//  Created by Karthik  Ramu on 4/14/23.
//

import SwiftUI

struct Step1Onboarding1View: View {

    // MARK: - PROPERTIES

    // MARK: - BODY
    var body: some View {

        VStack{


            VStack {
                HStack{
                    Text("Step 1 - Set up your wallet")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding()
                        .padding(.bottom, 0)

                    Spacer()

                } //: HSTACK

                HStack{

                    Text("Think of your wallet like Venmo. You can load money into it.")
                        .font(.title3)
                        .padding()

                    Spacer()

                } //: HSTACK


                HStack{

                    Text("When you load money into it, you're purchasing a stable coin called USDC. Each USDC coin is equal to $1.")
                        .font(.title3)
                        .padding()

                    Spacer()


                } //: HSTACK

                HStack{

                    Text("It's like digital cash and it allows us to offer you the higest rewards and the lowest prices.")
                        .font(.title3)
                        .padding()

                    Spacer()

                } //: HSTACK

                HStack{

                    Text("Once you set up your wallet and load money into it, you can start spending on Pare and earning rewards.")
                        .font(.title3)
                        .padding()

                    Spacer()
                }



            } //: VSTACK


            Spacer()

            NavigationLink {

                // Navigate to next view
                Step1Onboarding2View()

            } label: {
                Text("Get started")
                    .foregroundColor(Color.white)
                    .fontWeight(.semibold)
                    .frame(width: 300, height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 8,  style: .continuous)
                            .fill(Color.accentColor)
                            .frame(width: 300, height: 50)
                    )
            }

            Spacer()


        } //: VSTACK


    }
}


// MARK: - PREVIEW
struct Step1Onboarding1View_Previews: PreviewProvider {
    static var previews: some View {
        Step1Onboarding1View()
    }
}