//
//  Step1CompleteView.swift
//  Pare
//
//  Created by Karthik  Ramu on 4/15/23.
//

import SwiftUI

struct Step1CompleteView: View {

    // MARK: - PROPERTIES
    @Binding var isActive: Bool
    let trust: Bool

    
    // MARK: - BODY
    var body: some View {


        ZStack{

            Color(red: 0.167, green: 0.29, blue: 0.933).ignoresSafeArea()

            VStack{

                Spacer()

                Image(systemName: "party.popper.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 85, height: 85)
                    .foregroundColor(Color.white)
                    .padding()

                Text("You're done with Step 1!")
                    .font(.title)
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)

                NavigationLink {

                    if trust == true{
                        // Navigate to next view
                        Step2Onboarding1View(isActive: $isActive, trust: trust)
                    } else {

                        // Navigate to next view
                        Step2Onboarding1_0View(isActive: $isActive)
                    }

                    
                } label: {

                    Text("Continue to Step 2")
                        .foregroundColor(Color.accentColor)
                        .fontWeight(.semibold)
                        .frame(width: 300, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 8,  style: .continuous)
                                .fill(Color.white)
                                .frame(width: 300, height: 50)
                        )

                } //: NAV LINK
                .padding() 

                Spacer()


            } //: VSTACK

        } //: ZSTACK
    }
}


// MARK: - PREVIEW 
//struct Step1CompleteView_Previews: PreviewProvider {
//    static var previews: some View {
//        Step1CompleteView()
//    }
//}
