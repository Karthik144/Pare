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

    @State private var password = ""

    var body: some View {

        ZStack{

            Color(red: 0.167, green: 0.29, blue: 0.933).ignoresSafeArea()

            VStack{

                Spacer()

                VStack(){

                    // Progress View
                    Text("Step 3/4")
                        .font(.subheadline)
                        .foregroundColor(Color.white)
                        .padding(.bottom, 15)

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


                    CustomInputTextField(isSecureField: true, placeholderText: "Something secure...", text: $password)
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


                Spacer(minLength: 325)

            } //: VSTACK
            .navigationTitle("Sign Up")
            .foregroundColor(Color.white)
            .navigationBarTitleDisplayMode(.inline)
            .accentColor(Color.white)

        } //: ZSTACK
    }
}

//struct SignUpViewThree_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpViewThree()
//    }
//}
