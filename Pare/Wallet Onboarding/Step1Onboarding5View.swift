//
//  Step1Onboarding5View.swift
//  Pare
//
//  Created by Karthik  Ramu on 4/14/23.
//

import SwiftUI

struct Step1Onboarding5View: View {

    // MARK: - PROPERTIES
    @Binding var isActive: Bool
    let trust: Bool 

    // MARK: - BODY
    var body: some View {

        ScrollView{

            HStack{

                if trust == true{

                    Text("Select 'Back up manually'")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.top)
                } else {

                    Text("Hit 'Start' to secure your wallet")
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

                } else {

                    Text("This increases the security of your wallet.")
                        .lineLimit(3)
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.top)
                }


                Spacer()

            } //: HSTACK


            Spacer()


            if trust == true {

                // Insert image here
                Image("TrustBackUp")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width - 50, height: 360)
                    .scaledToFit()
                    .cornerRadius(10)
                    .padding()

            } else {

                // Insert image here
                Image("MetaBackUp")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width - 50, height: 360)
                    .scaledToFit()
                    .cornerRadius(10)
                    .padding()

            }



            Spacer()

            NavigationLink {

                // Navigate to next view
                Step1Onboarding6View(isActive: $isActive, trust: trust)

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


        } //: SCROLL VIEW
    }
}


// MARK: - PREVIEW
//struct Step1Onboarding5View_Previews: PreviewProvider {
//    static var previews: some View {
//        Step1Onboarding5View()
//    }
//}
