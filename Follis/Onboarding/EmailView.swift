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

    // MARK: - BODY
    var body: some View {
        ZStack{

            Color(red: 0.167, green: 0.29, blue: 0.933).ignoresSafeArea()

            VStack {

                Spacer()

                VStack(spacing: 15){
                    Text("What's your email?")
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                        .fontWeight(.heavy)
                        .padding(.bottom, 10)

                    CustomInputTextField(isSecureField: false, placeholderText: "We promise to not spam you...", text: $email)
                        .padding(.bottom, 30)

//                    NavigationLink(destination: SignUpViewFour(firstName: "", lastName: "", email: "", password: ""),
//                                   isActive: $isExistingUser) {
//                            Button(action: { isExistingUser = viewModel.checkIfExistingUser(email: email) }) {
//                            Text("Next")
//                        }
////                        .buttonStyle(MyButtonStyle))
//                    }

                    NavigationLink(destination: {
                        SignUpViewOne(email: email)

                    }, label: {
                        Text("Next")
                            .font(.title3)
                            .fontWeight(.bold)
                            .modifier(NextButtonModifier())
                    })




                } //: VSTACK

                Spacer(minLength: 325)
            } //: VSTACK
            .accentColor(Color.white)


        } //: ZSTACK
        .accentColor(Color.white)
    }
}

struct EmailView_Previews: PreviewProvider {
    static var previews: some View {
        EmailView()
    }
}
