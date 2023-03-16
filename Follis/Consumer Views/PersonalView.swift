//
//  PersonalView.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/10/23.
//

import SwiftUI

struct PersonalView: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var viewModel: AuthViewModel
    @Binding var viewActive: Bool
    @Binding var email: String
    @Binding var firstName: String
    @Binding var lastName: String


    // MARK: - BODY 
    var body: some View {

        Form {
            Section(header: Text("Personal Information")) {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email", text: $email)
            
            }

            Section(header: Text("Preferences")) {
                Toggle("Enable notifications", isOn: .constant(true))
            }

            Section {
                Button {
                    viewModel.updateUserData(firstName: firstName, lastName: lastName, email: email)
                    viewActive = false
                } label: {
                    Text("Save")
                }

            }

        } //: FORM
        .navigationTitle("Personal")
        .navigationBarTitleDisplayMode(.large)

    }
}

//struct PersonalView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonalView()
//    }
//}
