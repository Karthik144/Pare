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

        if #available(iOS 16.0, *) {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    TextField("Email", text: $email)

                }

                HStack{

                    Spacer()

                    Button {
                        viewModel.updateUserData(firstName: firstName, lastName: lastName, email: email)
                        viewActive = false
                    } label: {
                        Text("Save")
                            .foregroundColor(Color.white)
                            .background(
                                RoundedRectangle(cornerRadius: 50)
                                    .fill(Color(red: 0.167, green: 0.29, blue: 0.933))
                                    .frame(width:100, height: 50)
                            )
                    }
                    .frame(width: 100, height: 50, alignment: .center)


                    Spacer()

                } //: HSTACK 

            } //: FORM
            .navigationTitle("Personal")
            .navigationBarTitleDisplayMode(.large)
            .scrollContentBackground(.hidden)
        } else {
            // Fallback on earlier versions

            Form {
                Section(header: Text("Personal Information")) {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    TextField("Email", text: $email)

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
}

//struct PersonalView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonalView()
//    }
//}
