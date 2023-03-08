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
    @ObservedObject var keyboardResponder = KeyboardResponder()


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
                    HStack{
                        Text("Step 4/4")
                            .font(.subheadline)
                            .foregroundColor(Color.white)
                            .padding(.bottom, 15)
                    }
                    .offset(y:-keyboardResponder.currentHeight)



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
                        .padding(.bottom, 25)


                    }

                    NavigationLink {
                        SignUpViewFive(firstName: firstName, lastName: lastName, email: email, password: password, isMerchant: isMerchant)
                    } label: {
                        Text("Submit")
                            .font(.title3)
                            .fontWeight(.bold)
                            .modifier(NextButtonModifier())
                    }
                    .padding(.top, 20)


                } //: VSTACK


                .padding()
                Spacer(minLength: 200)
            } //: VSTACK
            .offset(y: -keyboardResponder.currentHeight * 0.1)


        } //: ZSTACK
    }
}

//struct SignUpViewFour_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpViewFour()
//    }
//}
