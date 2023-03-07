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

    @ObservedObject var keyboardResponder = KeyboardResponder()

    @State private var password = ""

    var body: some View {

        ZStack{

            Color(red: 0.167, green: 0.29, blue: 0.933).ignoresSafeArea()

            VStack{

                Spacer()

                VStack(){

                    // Progress View
                    HStack{
                        Text("Step 3/4")
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

                    CustomInputTextField(isSecureField: true, placeholderText: "", title: "New Password" , bottomMessage: "Password Strength: Strong", text: $password)

                    VStack{



                    } //: VSTACK


                    CustomInputTextField(isSecureField: true, placeholderText: "", title: "Confirm Password" , bottomMessage: "Password matches", text: $password)
                        .padding(.bottom, 30)


                    // Next button
                    NavigationLink(destination: {
                        SignUpViewFour(firstName: firstName, lastName: lastName, email: email, password: password)

                    }, label: {

                        Text("Next")
                            .font(.title3)
                            .fontWeight(.bold)
                            .modifier(NextButtonModifier())
                    })

                } //: VSTACK


                .padding()
                Spacer(minLength: 200)
            } //: VSTACK
            .navigationTitle("Sign Up")
            .foregroundColor(Color.white)
            .navigationBarTitleDisplayMode(.inline)
            .accentColor(Color.white)
            .offset(y: -keyboardResponder.currentHeight * 0.1)


        } //: ZSTACK
    }
}

//struct SignUpViewThree_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpViewThree()
//    }
//}
