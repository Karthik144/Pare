//
//  SignUpViewTwo.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/13/23.
//

import SwiftUI

struct SignUpViewTwo: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var viewModel: AuthViewModel
    @ObservedObject var keyboardResponder = KeyboardResponder()

    @State private var lastName = ""

    let firstName: String
    let email: String

    // MARK: - BODY
    var body: some View {

        ZStack{

            Color(red: 0.167, green: 0.29, blue: 0.933).ignoresSafeArea()

            VStack{

                Spacer()

                VStack(){

                    // Progress View
                    HStack{
                        Text("Step 2/4")
                            .font(.subheadline)
                            .foregroundColor(Color.white)
                            .padding(.bottom, 15)
                            .offset(y:keyboardResponder.currentHeight)
                        
                    }
                    .offset(y:-keyboardResponder.currentHeight)

                    HStack{

                        Spacer()

                        Text("What's your last name?")
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                            .fontWeight(.heavy)
                            .padding(.bottom, 10)
                            .multilineTextAlignment(.center)


                        Spacer()

                    } //: HSTACK


                    CustomInputTextField(isSecureField: false, placeholderText: "What your Navy sergeant would call you...", title: "", bottomMessage: "", text: $lastName)
                        .padding(.bottom, 30)

                    // Next button
                    NavigationLink(destination: {
                        SignUpViewThree(firstName: firstName, lastName: lastName, email: email)

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

// MARK: - PREVIEW
//struct SignUpViewTwo_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpViewTwo(firstName: <#String#>, lastName: <#String#>, email: <#String#>)
//    }
//}
