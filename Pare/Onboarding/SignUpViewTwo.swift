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
                    Text("Step 2/3")
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
//                        .padding(.bottom, 15)
                        .padding()


                    Spacer()

                    HStack{

                        Spacer()

                        Text("What's your last name?")
                            .font(.title)
                            .foregroundColor(customColor)
                            .fontWeight(.heavy)
                            .padding(.bottom, 10)
                            .multilineTextAlignment(.center)

                        Spacer()

                    } //: HSTACK


                    CustomInputTextField(isSecureField: false, placeholderText: "", title: "", bottomMessage: "", confirmText: false, text: $lastName, confirmPassword: $lastName)
                        .padding(.bottom, 30)

                    // Next button
                    NavigationLink(destination: {
                        EmailView(firstName: firstName, lastName: lastName, login: false)

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
