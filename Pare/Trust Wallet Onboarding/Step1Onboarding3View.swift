//
//  Step1Onboarding3View.swift
//  Pare
//
//  Created by Karthik  Ramu on 4/14/23.
//

import SwiftUI

struct Step1Onboarding3View: View {

    // MARK: - PROPERTIES
    @Binding var isActive: Bool 

    // MARK: - BODY
    var body: some View {
        VStack{

            HStack{

                Text("Install TrustWallet")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.top)

                Spacer()

            } //: HSTACK

            HStack{

                Text("Search TrustWallet on the AppStore & install")
                    .padding(.leading)
                    .padding(.trailing)
                Spacer()
            } //: HSTACK
            .padding(.bottom, 70)

            Image("Trust")
                .resizable()
                .frame(width: UIScreen.main.bounds.width - 50, height: 200)
                .scaledToFit()
                .cornerRadius(10)
                .padding()


            NavigationLink {

                // Navigate to next view
                Step1Onboarding4View(isActive: $isActive)

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

            }

            Spacer()




        } //: VSTACK
    }
}

//struct Step1Onboarding3View_Previews: PreviewProvider {
//    static var previews: some View {
//        Step1Onboarding3View()
//    }
//}
