//
//  SignUpViewOne.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/13/23.
//

import SwiftUI

struct SignUpViewOne: View {

    // MARK: - PROPERTIES
    @State private var firstName = ""
    @ObservedObject var keyboardResponder = KeyboardResponder()

    let customColor = Color(
        red: Double(0x2B) / 255,
        green: Double(0x4A) / 255,
        blue: Double(0xEE) / 255,
        opacity: 1.0
    )



    // MARK: - BODY
    var body: some View {

        ZStack{

//            Color(red: 0.167, green: 0.29, blue: 0.933).ignoresSafeArea()
            Color(red: 1.0, green: 1.0, blue: 1.0).ignoresSafeArea()

            VStack{

                Spacer()

                VStack(spacing: 15){

                    // Progress View
                    Text("Step 1/3")
                        .font(.subheadline)
//                        .foregroundColor(Color.white)
                        .foregroundColor(Color.gray)
//                        .padding(.bottom, 15)
                        .padding()

                    Spacer()

                    HStack{

                        Spacer()

                        Text("What's your first name?")
                            .font(.title)
                            .foregroundColor(customColor)
                            .fontWeight(.heavy)
                            .padding(.bottom)
                            .padding(.top)
                            .multilineTextAlignment(.center)

                        Spacer()

                    } //: HSTACK


                    CustomInputTextField(isSecureField: false, placeholderText: "", title: "", bottomMessage: "", confirmText: false, text: $firstName, confirmPassword: $firstName)
                        .padding(.bottom, 30)



                    // Next button
                    NavigationLink(destination: {
                        SignUpViewTwo(firstName: firstName)

                    }, label: {

                        Text("Next")
                            .font(.title3)
                            .fontWeight(.bold)
                            .modifier(NextButtonModifier())
                            .frame(width:200)
                    })

                } //: VSTACK
                .padding()
                Spacer(minLength: 240)

            } //: VSTACK
            .tint(Color.white)
            .foregroundColor(.white)
            .navigationBarTitleDisplayMode(.inline)
            .accentColor(Color.white)
            .offset(y: -keyboardResponder.currentHeight * 0.1)
        } //: ZSTACK
//        .tint(Color.white)

    }
}

//struct SignUpViewOne_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpViewOne()
//            .environmentObject(AuthViewModel())
//
//    }
//}
