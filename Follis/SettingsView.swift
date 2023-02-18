//
//  SettingsView.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/15/23.
//

import SwiftUI

struct SettingsView: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showingAlert = false 

    // MARK: - BODY
    var body: some View {

        NavigationView {

            Form {

                Section(header: Text("Profile"), content: {

                    Text(viewModel.currentUser?.first_name ?? "Error")
                    Text(viewModel.currentUser?.last_name ?? "Error")
                    Text(viewModel.currentUser?.email ?? "Error")
                })

                Section(header: Text("Contact Us"), content: {

                    Label("wvv6xa@virginia.edu", systemImage: "envelope")
                    Label("571-635-3433", systemImage: "phone")

                })


            } //: FORM
            .navigationTitle("Settings")
            .toolbar{

                Menu {

                    // Button 1
                    Button(action: {
                        // Sign user out
                        viewModel.signOut()
                    }, label: {
                        Label("Sign Out", systemImage: "person.crop.circle.fill.badge.minus")
                            .foregroundColor(.red)
                    })

                    // Button 2
                    Button(action: {
                        showingAlert.toggle()
                    }, label: {
                        Label("Delete Account", systemImage: "trash.circle")
                            .foregroundColor(.red)
                    })
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Are you sure you want to delete your account?"), message: Text("You cannot undo this."), primaryButton: .destructive(Text("Delete"), action: {
                            viewModel.deleteUser()
                        }), secondaryButton: .cancel())
                    } //: END OF ALERT
                } label: {
                    Label("More", systemImage: "ellipsis.circle")
                }


            } //: TOOLBAR

        } //: NAV VIEW


    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}


//Button(action: {
//    // Sign user out
//    viewModel.signOut()
//}, label: {
//    Label("Sign Out", systemImage: "person.crop.circle.fill.badge.minus")
//        .foregroundColor(.red)
//})
