//
//  SignUpViewThree.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/14/23.
//

import SwiftUI

struct SignUpViewThree: View {

    // MARK: - PROPERTIES
    let firstName: String
    let lastName: String
    let email: String

    @EnvironmentObject var viewModel: AuthViewModel

    @ObservedObject var keyboardResponder = KeyboardResponder()

    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var strongPassword = false
    @State private var samePassword = false

    var body: some View {

        ZStack{

            Color(red: 0.167, green: 0.29, blue: 0.933).ignoresSafeArea()

            VStack{

                Spacer()

                VStack(){

                    // Progress View
                    HStack{
                        Text("Step 3/3")
                            .font(.subheadline)
                            .foregroundColor(Color.white)
                            .padding(.bottom, 15)
                    }
                    .offset(y:-keyboardResponder.currentHeight)

                    HStack{

                        Spacer()

                        Text("Create a password.")
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                            .fontWeight(.heavy)
                            .padding(.bottom, 10)
                            .multilineTextAlignment(.center)


                        Spacer()

                    } //: HSTACK

                    CustomInputTextField(isSecureField: true, placeholderText: "", title: "New Password" , bottomMessage: "", confirmText: false, text: $password, confirmPassword: $confirmPassword)
                        .padding(.bottom, 30)


                    Button {
                        viewModel.register(firstName: firstName, lastName: lastName, withEmail: email, password: password, isMerchant: false)
                    } label: {
                        Text("Sign Up")
                            .font(.title3)
                            .fontWeight(.bold)
                            .modifier(NextButtonModifier())
                    }




//                    if samePassword == true && strongPassword == true {
//                        // Next button
//                        NavigationLink(destination: {
//                            SignUpViewFour(firstName: firstName, lastName: lastName, email: email, password: password)
//
//                        }, label: {
//
//                            Text("Next")
//                                .font(.title3)
//                                .fontWeight(.bold)
//                                .modifier(NextButtonModifier())
//                        })

//                        Button {
//                            viewModel.register(firstName: firstName, lastName: lastName, withEmail: email, password: password, isMerchant: false)
//                        } label: {
//                            Text("Sign Up")
//                                .font(.title3)
//                                .fontWeight(.bold)
//                                .modifier(NextButtonModifier())
//                        }


//                    }

                } //: VSTACK


                .padding()
                Spacer(minLength: 240)
            } //: VSTACK
            .offset(y: -keyboardResponder.currentHeight * 0.1)


        } //: ZSTACK


    }


    func checkPasswordStrength(password: String) -> Bool {
        let passwordLength = password.count
        let letters = CharacterSet.letters
        let digits = CharacterSet.decimalDigits
        let lowercaseLetters = CharacterSet.lowercaseLetters
        let uppercaseLetters = CharacterSet.uppercaseLetters

        // Check length
        if passwordLength < 8 {
            return false
        }

        // Check for letters and digits
        if password.rangeOfCharacter(from: letters) == nil || password.rangeOfCharacter(from: digits) == nil {
            return false
        }

        // Check for lowercase and uppercase letters
        if password.rangeOfCharacter(from: lowercaseLetters) == nil || password.rangeOfCharacter(from: uppercaseLetters) == nil {
            return false
        }

        // Strong password
        return true
    }

    func checkPasswordsMatch(_ password1: String, _ password2: String) -> Bool {
        if password1 == password2 {
            return true
        } else {
            return false
        }
    }
}


//struct SignUpViewThree_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpViewThree()
//    }
//}
