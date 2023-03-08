//
//  PasswordView.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/15/23.
//

import SwiftUI

struct PasswordView: View {

    // MARK: - PROPERTIES
    let email: String
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @ObservedObject var keyboardResponder = KeyboardResponder()


    // MARK: - BODY
    var body: some View {

        ZStack{

            Color(red: 0.167, green: 0.29, blue: 0.933).ignoresSafeArea()

            VStack{

                Spacer()

                VStack(){

                    HStack{

                        Spacer()

                        Text("Enter your password.")
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                            .fontWeight(.heavy)
                            .padding(.bottom, 10)
                            .multilineTextAlignment(.center)

                        Spacer()

                    } //: HSTACK


                    CustomInputTextField(isSecureField: true, placeholderText: "", title: "" , bottomMessage: "Password Strength: Strong", confirmText: false, text: $password, confirmPassword: $password)

                    // Next button
                    Button(action: {
                        viewModel.logIn(withEmail: email, password: password)
                    }, label: {
                        Text("Log In")
                            .font(.title3)
                            .fontWeight(.bold)
                            .modifier(NextButtonModifier())
                    })


                } //: VSTACK


                .padding()
                Spacer(minLength: 200)
            } //: VSTACK
            .navigationTitle("Log In")
            .foregroundColor(Color.white)
            .navigationBarTitleDisplayMode(.inline)
            .accentColor(Color.white)
            .offset(y: -keyboardResponder.currentHeight * 0.1)


        } //: ZSTACK
    }
}


// MARK: - PREVIEW
//struct PasswordView_Previews: PreviewProvider {
//    static var previews: some View {
//        PasswordView()
//    }
//}
