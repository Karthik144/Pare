//
//  ProfileView.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/7/23.
//

import SwiftUI

struct ProfileView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showingAlert = false

    // MARK: - BODY
    var body: some View {

        NavigationView {

            VStack{

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

                    Button {
                        viewModel.signOut()
                    } label: {
                        Text("Sign Out")
                    }

                    Button {
                        showingAlert.toggle()
                    } label: {
                        Text("Delete account")
                    }
                    .foregroundColor(Color.red)
                    .alert("Are you sure you want to delete your account?", isPresented: $showingAlert){

                        Button("Cancel", role: .cancel){}

                        Button("Delete", role: .destructive){
                            viewModel.deleteUser()
                        }

                    } //: ALERT


                } //: FORM
                .navigationTitle("Settings")

            }


        } //: NAV VIEW


    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
