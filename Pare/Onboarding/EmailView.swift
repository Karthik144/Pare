//
//  EmailView.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/14/23.
//

import SwiftUI

struct EmailView: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var isExistingUser = false
    @State private var email = ""
    @State private var textFieldSubmitted = false
    
    @ObservedObject var keyboardResponder = KeyboardResponder()
    let login: Bool


    // MARK: - BODY
    var body: some View {
        ZStack{

            Color(red: 0.167, green: 0.29, blue: 0.933).ignoresSafeArea()
            VStack{

                VStack {

                    Spacer()

                    VStack(spacing: 15){
                        Text("What's your email?")
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                            .fontWeight(.heavy)
                            .padding(.bottom, 10)

                        CustomInputTextField(isSecureField: false, placeholderText: "", title: "", bottomMessage: "", confirmText: false, text: $email, confirmPassword: $email)
                            .padding(.bottom, 30)

                        if login == true {

                            NavigationLink(destination: {
                                PasswordView(email: email)
                            }, label: {
                                Text("Next")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .modifier(NextButtonModifier())
                            })

                        } else {

                            NavigationLink(destination: {
                                SignUpViewOne(email: email)

                            }, label: {
                                Text("Next")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .modifier(NextButtonModifier())
                            })
                        }

                    } //: VSTACK
                    .padding()
                    Spacer(minLength: 240)
                }
            } //: VSTACK
            .accentColor(Color.white)
            .offset(y: -keyboardResponder.currentHeight * 0.1)

        } //: ZSTACK
        .tint(Color.white)

    }
}

//struct EmailView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmailView()
//    }
//}
