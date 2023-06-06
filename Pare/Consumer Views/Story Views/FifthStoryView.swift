//
//  FifthStoryView.swift
//  Pare
//
//  Created by Karthik  Ramu on 6/5/23.
//

import SwiftUI

struct FifthStoryView: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var username = ""
    @State private var domain = ""

    // MARK: - BODY
    var body: some View {

        VStack(alignment: .leading){


            // Title
            Text("Before you add USDC to your wallet...")
                .font(.title.weight(.bold))
                .padding()
                .padding(.bottom, 0)

            // Point #1
            HStack{

                VStack{

                    Image("credit_card")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                        .padding()

                    Spacer()

                }


                VStack(alignment: .leading){

                    Text("You will be asked for your SSN, Driver’s ID, and photo verification to verify your identity and prevent fraudulent transactions.")
                        .font(.callout)
                        .padding(.top)
                        .padding(.trailing)

                    Text("It’s government regulations for purchasing USDC, so blame them not us.")
                        .font(.callout)
                        .padding(.top, 5)
                        .padding(.trailing)

                    Spacer()

                } //: VSTACK
                .fixedSize(horizontal: false, vertical: true)

            } //: HSTACK
            .padding(.bottom)

            // Point #2
            HStack{

                VStack{

                    Image("lock")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                        .padding()

                    Spacer()

                } //: VSTACK



                VStack(alignment: .leading){

                    Text("To process this sensitive info and purchase USDC, we use Transak.")
                        .font(.callout)
                        .padding(.top)
                        .padding(.trailing)

                    Text("Transak is registered as a Money Service Business with the US Treasury and follows all regulations.")
                        .font(.callout)
                        .padding(.top, 5)
                        .padding(.trailing)

                    Text("The next screen will direct you to Transak, and none of this info is accessible or stored by us.")
                        .font(.callout)
                        .padding(.top, 5)
                        .padding(.trailing)

                    Spacer()


                } //: VSTACK
                .fixedSize(horizontal: false, vertical: true)


            } //: HSTACK

            Spacer()

            HStack{

                Spacer()

                let url = "https://www.electronicid.eu/en/blog/post/crypto-exchanges-compliance/en"

                let textAndLink = "You can learn more about the U.S. Legal Regulations on this [here](\(url))."

                Text(.init(textAndLink))
                    .font(.caption)
                    .padding()


                Spacer() 

            } //: HSTACK

            HStack{

                Spacer()

                // Add USDC button (nav to Transak)
                NavigationLink {
                    TransakController(publicAddress: authViewModel.currentUser?.public_address ?? "", firstName: authViewModel.currentUser?.first_name ?? "", lastName: authViewModel.currentUser?.last_name ?? "", email: authViewModel.currentUser?.email ?? "")
                } label: {

                    Text("Add Funds")
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .background(
                            RoundedRectangle(cornerRadius: 8,  style: .continuous)
                                .fill(Color.accentColor)
                                .frame(width: 300, height: 50)
                        )
                        .frame(width:300, height: 50)

                } //: NAV LINK
                .padding(.bottom, 35)

                Spacer()


            } //: HSTACK



        } //: VSTACK
        .onAppear(){

            // Split email into username and domain
            let email = authViewModel.currentUser?.email ?? ""
            let components = email.components(separatedBy: "@")

            if components.count == 2 {
                self.username = components[0]
                self.domain = components[1]
            } else {
                print("Invalid email format - AddFundsView")
            }

        } //: ON APPEAR

    } //: BODY
} //: VIEW


// MARK: - PREVIEW
struct FifthStoryView_Previews: PreviewProvider {
    static var previews: some View {
        FifthStoryView()
    }
}
