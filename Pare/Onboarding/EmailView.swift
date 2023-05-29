//
//  EmailView.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/14/23.
//

import SwiftUI
import Firebase
import FirebaseFunctions
import MagicSDK


struct EmailView: View {

    // MARK: - PROPERTIES
    let firstName: String
    let lastName: String
    let login: Bool

    let customColor = Color(
        red: Double(0x2B) / 255,
        green: Double(0x4A) / 255,
        blue: Double(0xEE) / 255,
        opacity: 1.0
    )

    @StateObject private var magicSingleton = MagicSingleton.shared
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var isExistingUser = false
    @State private var email = ""
    @State private var textFieldSubmitted = false
    
    @ObservedObject var keyboardResponder = KeyboardResponder()

    // MARK: - BODY
    var body: some View {
        ZStack{

//            Color(red: 0.167, green: 0.29, blue: 0.933).ignoresSafeArea()
            Color(red: 1.0, green: 1.0, blue: 1.0).ignoresSafeArea()

            VStack{

                VStack {

                    Spacer()

                    VStack(spacing: 15){

                        if !login {

                            // Progress View
                            Text("Step 3/3")
                                .font(.subheadline)
        //                        .foregroundColor(Color.white)
                                .foregroundColor(Color.gray)
        //                        .padding(.bottom, 15)
                                .padding()

                            Spacer()

                        }

                        HStack{

                            Spacer()

                            Text("What's your email?")
                                .font(.title)
                                .foregroundColor(customColor)
                                .fontWeight(.heavy)
                                .padding(.bottom, 10)

                            Spacer()

                        }


                        CustomInputTextField(isSecureField: false, placeholderText: "", title: "", bottomMessage: "", confirmText: false, text: $email, confirmPassword: $email)
                            .padding(.bottom, 30)


                        // Submit button
                        Button(action: {

                            // Sign user in using Magic Auth
//                            viewModel.register(firstName: firstName, lastName: lastName, withEmail: email, password: password, isMerchant: isMerchant)

                            if login {

                                print("Button pressed")
                                viewModel.logIn(withEmail: email, password: "", magic: magicSingleton.magic)

                            } else {

                                viewModel.register(firstName: firstName, lastName: lastName, withEmail: email, password: "", magic: magicSingleton.magic)
                            }


                        }, label: {

                            if login {

                                Text("Log In")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .modifier(NextButtonModifier())
                            } else {

                                Text("Sign Up")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .modifier(NextButtonModifier())
                            }

                        })
                        .padding(.top, 20)


                    } //: VSTACK
                    .padding()
                    Spacer(minLength: 240)
                }
            } //: VSTACK
//            .accentColor(Color.white)
            .offset(y: -keyboardResponder.currentHeight * 0.1)

        } //: ZSTACK
//        .tint(Color.white)

    }
}

//struct EmailView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmailView()
//    }
//}
