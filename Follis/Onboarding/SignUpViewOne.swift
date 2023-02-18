//
//  SignUpViewOne.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/13/23.
//

import SwiftUI

struct SignUpViewOne: View {

    // MARK: - PROPERTIES
    let email: String
    @State private var firstName = ""
    @ObservedObject var keyboardResponder = KeyboardResponder()


    // MARK: - BODY
    var body: some View {

        ZStack{

            Color(red: 0.167, green: 0.29, blue: 0.933).ignoresSafeArea()

            VStack{

                Spacer()

                VStack(){

                    // Progress View
                   
                    Text("Step 1/4")
                        .font(.subheadline)
                        .foregroundColor(Color.white)
                        .padding(.bottom, 15)
                

                    HStack{

                        Spacer()

                        Text("What's your first name?")
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                            .fontWeight(.heavy)
                            .padding(.bottom, 10)
                            .multilineTextAlignment(.center)

                        Spacer()

                    } //: HSTACK


                    CustomInputTextField(isSecureField: false, placeholderText: "What your friends call you...", text: $firstName)
                        .padding(.bottom, 30)

                    // Next button
                    NavigationLink(destination: {
                        SignUpViewTwo(firstName: firstName, email: email)

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

//struct SignUpViewOne_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpViewOne()
//            .environmentObject(AuthViewModel())
//
//    }
//}
