//
//  AddFundsView.swift
//  Pare
//
//  Created by Karthik  Ramu on 5/28/23.
//

import SwiftUI

struct AddFundsView: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var username = ""
    @State private var domain = ""

    // MARK: - BODY
    var body: some View {

        VStack{

            // Preface
            VStack(alignment: .leading, spacing: 30){

                Text("Think of your wallet like Venmo.")

                Text("When you add money, you’re purchasing tokens that you can spend at any shop on Pare. ")

                Text("These tokens let you earn the **highest rewards** and the **lowest meal prices**.")

                Text("To ensure security, we use a third-party to verify your identity. So please have your SSN and ID ready.")

                Text("This data is not stored by us or the third-party. **It is solely for verification to prevent fraudulent purchases.** ")


            } //: VSTACK
            .padding()


            Spacer()

            // Show Transak View
            NavigationLink {
                TransakController(publicAddress: authViewModel.currentUser?.public_address ?? "", firstName: authViewModel.currentUser?.first_name ?? "", lastName: authViewModel.currentUser?.last_name ?? "", emailUsername: self.username, emailDomain: self.domain)
            } label: {

                Text("Add Funds")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .background(
                        RoundedRectangle(cornerRadius: 8,  style: .continuous)
                            .fill(Color.accentColor)
                            .frame(width: 300, height: 50)
                    )

            } //: BUTTON
            .padding(.bottom, 35)

        } //: VSTACK
        .navigationTitle("Add funds")
        .navigationBarTitleDisplayMode(.large)
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

    } //: VIEW
}


// MARK: - PREVIEW
struct AddFundsView_Previews: PreviewProvider {
    static var previews: some View {
        AddFundsView()
    }
}
