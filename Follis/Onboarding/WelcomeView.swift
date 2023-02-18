//
//  WelcomeView.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/13/23.
//

import SwiftUI

struct WelcomeView: View {

    // MARK: - PROPERTEIS
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var appState: AppState
    @ObservedObject var keyboardResponder = KeyboardResponder()


    // MARK: - BODY
    var body: some View {

        Group {

            // If no user is signed in, bring them to the main welcome view
            if viewModel.userSession == nil {
                mainWelcomeView
            } else {
                ContentView()
            }
        } //: GROUP

    }
}

extension WelcomeView {
    var mainWelcomeView: some View {
        NavigationView {
            VStack(alignment: .center) {

                Spacer()

                VStack(spacing: 12){

                    Text("Follis")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .offset(y:-50)
                    Text("Unlock the power of web3 in the real-world.")
                        .font(.body)
                        .offset(y:-50)

                    HStack{

                        Spacer()

                        // Log in button
                        NavigationLink(destination: {
                            EmailView(login: true)
                        }, label: {
                            Text("Login")
                                .font(.title3)
                                .fontWeight(.bold)
                                .modifier(StartButtonModifier())
                        })

                        Spacer()

                        // Sign up button 
                        NavigationLink(destination: {
                            EmailView(login: false)
                        }, label: {
                            Text("Sign Up")
                                .font(.title3)
                                .fontWeight(.bold)
                                .modifier(StartButtonModifier())
                        })

                        Spacer()

                    }
//                    // Get started button with custom modifier
//                    NavigationLink(destination: {
//
//                        EmailView()
//
//                    }, label: {
//                        Text("Get Started 🔥")
//                            .font(.title3)
//                            .fontWeight(.bold)
//                            .modifier(GetStartedButtonModifier())
//                    })

                } //: VSTACK



                Spacer()

            } //: VSTACK
        } //: NAVVIEW
        .navigationViewStyle(.stack)
        .onTapGesture {
            self.hideKeyboard()
        }
    }

}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .environmentObject(AuthViewModel())
    }
}

