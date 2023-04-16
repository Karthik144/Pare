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

    // MARK: - BODY
    var body: some View {
        VStack{

            HStack{

                Text("Select 'Back up manually'")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.top)

                Spacer()

            } //: HSTACK
            HStack{

                Text("We've found this to be the fastest and safest way. But you're open to backup to iCloud.")
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.top)

                Spacer()

            } //: HSTACK
            .padding()


            // Insert image here
            Image("TrustBackUp")
                .resizable()
                .frame(width: UIScreen.main.bounds.width - 50, height: 360)
                .scaledToFit()
                .cornerRadius(10)
                .padding()

            Spacer()

            NavigationLink {

                // Navigate to next view
                Step1Onboarding6View(isActive: $isActive)

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


// MARK: - PREVIEW
//struct Step1Onboarding5View_Previews: PreviewProvider {
//    static var previews: some View {
//        Step1Onboarding5View()
//    }
//}
