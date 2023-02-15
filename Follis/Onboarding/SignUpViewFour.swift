//
//  SignUpViewFour.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/14/23.
//

import SwiftUI

struct SignUpViewFour: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var viewModel: AuthViewModel

    let firstName: String
    let lastName: String
    let email: String
    let password: String

    @State private var isMerchant = false
    @State private var isConsumer = false

    var body: some View {

        ZStack{

            Color(red: 0.167, green: 0.29, blue: 0.933).ignoresSafeArea()

            VStack{

                Spacer()

                VStack(){

                    // Progress View
                    Text("Step 4/4")
                        .font(.subheadline)
                        .foregroundColor(Color.white)
                        .padding(.bottom, 15)

                    HStack{

                        Spacer()

                        Text("How would you like to use Follis?")
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                            .fontWeight(.heavy)
                            .padding(.bottom, 10)
                            .multilineTextAlignment(.center)

                        Spacer()

                    } //: HSTACK
                    .padding(.bottom, 18)


                    if isMerchant == false {
                        // Merchant button
                        Button(action: {
                            isMerchant.toggle()
                        }, label: {
                            Text("I'm a merchant 💸")
                                .font(.title3)
                                .fontWeight(.bold)
                                .modifier(UserTypeButtonModifier())

                        })
                        .padding(.bottom, 10)

                    } else {
                        // Merchant button
                        Button(action: {
                            isMerchant.toggle()
                        }, label: {
                            Text("I'm a merchant 💸")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.white)
                                        .frame(width:295, height: 50)
                                )
                                .frame(width: 295, height: 50, alignment: .center)

                        })
                        .padding(.bottom, 10)

                    }

                    if isConsumer == false {

                        // Consumer button
                        Button(action: {
                            isConsumer.toggle()
                        }, label: {
                            Text("I'm a consumer 😃")
                                .font(.title3)
                                .fontWeight(.bold)
                                .modifier(UserTypeButtonModifier())

                        })
                        .padding(.bottom, 25)

                    } else {

                        // Merchant button
                        Button(action: {
                            isConsumer.toggle()
                        }, label: {
                            Text("I'm a consumer 😃")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.white)
                                        .frame(width:295, height: 50)
                                )
                                .frame(width: 295, height: 50, alignment: .center)

                        })
                        .padding(.bottom, 10)


                    }


                    // Next button
                    Button(action: {

                        // Call sign up method from backend
                        viewModel.register(firstName: firstName, lastName: lastName, withEmail: email, password: password, isMerchant: isMerchant)

                    }, label: {

                        Text("Submit")
                            .font(.title3)
                            .fontWeight(.bold)
                            .modifier(NextButtonModifier())
                    })
                    .padding(.top, 20)

                } //: VSTACK


                Spacer(minLength: 300)

            } //: VSTACK
            .navigationTitle("Sign Up")
            .foregroundColor(Color.white)
            .navigationBarTitleDisplayMode(.inline)
            .accentColor(Color.white)

        } //: ZSTACK
    }
}

//struct SignUpViewFour_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpViewFour()
//    }
//}
