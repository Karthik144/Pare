//
//  RecoverPhraseView.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/7/23.
//

import SwiftUI

struct SignUpViewFive: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var viewModel: AuthViewModel
    let secretRecoveryPhrase = "Betray aerobic record equal polar athlete tool elite youth need below resource"
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    let isMerchant: Bool


    // MARK: - BODY
    var body: some View {
        ZStack{
            
            Color(red: 0.167, green: 0.29, blue: 0.933).ignoresSafeArea()
            
            VStack{


                // Progress View
                HStack{
                    Text("Step 4/4")
                        .font(.subheadline)
                        .foregroundColor(Color.white)
                        .padding(.bottom, 15)
                } //: HSTACK

                HStack{

                    Spacer()

                    Text("Create your wallet.")
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                        .fontWeight(.heavy)
                        .padding(.bottom, 10)
                        .multilineTextAlignment(.center)

                    Spacer()

                } //: HSTACK
                .padding(.bottom, 18)


                VStack(alignment: .leading, spacing: 10) {

                    Text("When you create a wallet, you will get a public address and private key.")
                        .padding(.leading, 15)



                    Text("Your public address is like a public username, anyone can send money to it.")
                        .padding(.leading, 15)



                    Group{

                        Text("Your private key is like a super secret password that allows you to verify your transactions. ") + Text("Don’t share it with anyone.").bold()

                    }
                    .padding(.leading, 17)
                    .padding(.trailing, 10)



                    Group{
                        Text("This secret recovery phrase allows you to access your private key, sign in with a new device and more. ")

                        + Text("Store it somewhere safe, and don’t share it with anyone.")
                            .bold()
                    }
                    .padding(.leading, 17)
                    .padding(.trailing, 10)

                } //: VSTACK
                .foregroundColor(Color.white)
                .multilineTextAlignment(.leading)
                .font(.callout)

                Spacer()

                HStack{

                    Spacer()
                    Text(secretRecoveryPhrase)
                        .bold()
                        .padding()
                        .font(.title3)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white, lineWidth: 2)
                        .frame(width: 350, height: 120)

                )


                Spacer()

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

                Spacer(minLength: 100)
                
            } //: VSTACK
        } //: ZSTACK
    }
}

struct SignUpViewFive_Previews: PreviewProvider {
    static var previews: some View {
        SignUpViewFive(firstName: "", lastName: "", email: "", password: "", isMerchant: false)
    }
}
