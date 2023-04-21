//
//  Step1Onboarding3View.swift
//  Pare
//
//  Created by Karthik  Ramu on 4/14/23.
//

import SwiftUI

struct Step1Onboarding3View: View {

    // MARK: - PROPERTIES
    let trust: Bool
    @Binding var isActive: Bool 

    // MARK: - BODY
    var body: some View {
        VStack{

            HStack{

                if trust == true{

                    Text("Install TrustWallet")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.top)

                } else {

                    Text("Install MetaMask")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.top)
                }


                Spacer()

            } //: HSTACK

            HStack{

                if trust == true {

                    Text("Search TrustWallet on the AppStore & install")
                        .padding(.leading)
                        .padding(.trailing)
                } else {

                    Text("Search MetaMask on the AppStore & install")
                        .padding(.leading)
                        .padding(.trailing)

                }

                Spacer()
            } //: HSTACK
//            .padding(.bottom, 70)

            Spacer()

            if trust == true {

                Image("Trust")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width - 50, height: 240)
                    .scaledToFit()
                    .cornerRadius(10)
                    .padding()

            } else {

                Image("MetaMask")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width - 50, height: 240)
                    .scaledToFit()
                    .cornerRadius(10)
                    .padding()
            }


            Spacer() 


            NavigationLink {

                // Navigate to next view
                Step1Onboarding4View(isActive: $isActive, trust: trust)

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

//struct Step1Onboarding3View_Previews: PreviewProvider {
//    static var previews: some View {
//        Step1Onboarding3View()
//    }
//}
