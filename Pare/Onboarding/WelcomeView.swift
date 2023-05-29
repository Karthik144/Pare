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
    @StateObject var walletViewModel: web3ViewModel
    @ObservedObject var keyboardResponder = KeyboardResponder()

    // MARK: - BODY
    var body: some View {

        Group {

            // If no user is signed in, bring them to the main welcome view
            if viewModel.userSession == nil {
                mainWelcomeView
            } else {
                ContentView(walletViewModel: walletViewModel)
            }
        } //: GROUP
        .navigationViewStyle(.stack) // use stack navigation view style

    }
}

extension WelcomeView {
    var mainWelcomeView: some View {
        NavigationView {

            TabView(){

                // Benefit 1
                BenefitView(benefitNumber: "BENEFIT #1", benefit: "Earn 10% cash back on each order", subBenefit: "", image: "benefit_1")

                // Benefit 2
                BenefitView(benefitNumber: "BENEFIT #2", benefit: "Lowest meal prices", subBenefit: "We don’t inflate menu prices like others...", image: "benefit_2")

            }
            .tint(Color.white)
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))


//            VStack(alignment: .center) {
//
//                Spacer()
//
//                VStack(spacing: 12){
//
//                    Text("Pare")
//                        .font(.largeTitle)
//                        .fontWeight(.heavy)
//                        .offset(y:-50)
//                    Text("Earn rewards every time you spend.")
//                        .font(.body)
//                        .offset(y:-50)
//
//                    HStack{
//
//                        Spacer()
//
//                        // Log in button
//                        NavigationLink(destination: {
//                            EmailView(login: true)
//                        }, label: {
//                            Text("Login")
//                                .font(.title3)
//                                .fontWeight(.bold)
//                                .modifier(StartButtonModifier())
//                        })
//
//                        Spacer()
//
//                        // Sign up button
//                        NavigationLink(destination: {
//                            EmailView(login: false)
//                        }, label: {
//                            Text("Sign Up")
//                                .font(.title3)
//                                .fontWeight(.bold)
//                                .modifier(StartButtonModifier())
//                        })
//
//                        Spacer()
//
//                    }
//
//                } //: VSTACK
//
//                Spacer()
//
//            } //: VSTACK
//            .tint(Color.white)

        } //: NAVVIEW
        .tint(Color.white)



    }

}


extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
/*
struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .environmentObject(AuthViewModel())
    }
}

*/
