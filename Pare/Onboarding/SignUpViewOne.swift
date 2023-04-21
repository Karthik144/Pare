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


    init(email: String) {
        self.email = email
        let appearance = UINavigationBarAppearance()

        appearance.configureWithOpaqueBackground() // configure


        let backItemAppearance = UIBarButtonItemAppearance()
        backItemAppearance.normal.titleTextAttributes = [.foregroundColor : UIColor.white] // fix text color
        appearance.backButtonAppearance = backItemAppearance
        UINavigationBar.appearance().tintColor = .white
    }


    // MARK: - BODY
    var body: some View {

        ZStack{

            Color(red: 0.167, green: 0.29, blue: 0.933).ignoresSafeArea()

            VStack{

                Spacer()

                VStack(spacing: 15){

                    // Progress View
                    Text("Step 1/3")
                        .font(.subheadline)
                        .foregroundColor(Color.white)
//                        .padding(.bottom, 15)
                        .padding()

                    Spacer()

                    HStack{

                        Spacer()

                        Text("What's your first name?")
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                            .fontWeight(.heavy)
                            .padding()
//                            .padding(.bottom, 10)
                            .multilineTextAlignment(.center)

                        Spacer()

                    } //: HSTACK


                    CustomInputTextField(isSecureField: false, placeholderText: "", title: "", bottomMessage: "", confirmText: false, text: $firstName, confirmPassword: $firstName)
                        .padding(.bottom, 30)



                    // Next button
                    NavigationLink(destination: {
                        SignUpViewTwo(firstName: firstName, email: email)

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
            .tint(Color.white)
            .foregroundColor(.white)
            .navigationBarTitleDisplayMode(.inline)
            .accentColor(Color.white)
            .offset(y: -keyboardResponder.currentHeight * 0.1)
        } //: ZSTACK
        .tint(Color.white)

    }
}

//struct SignUpViewOne_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpViewOne()
//            .environmentObject(AuthViewModel())
//
//    }
//}
