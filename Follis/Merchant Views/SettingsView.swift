import SwiftUI

struct SettingsView: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showingAlert = false


    // MARK: - BODY
    var body: some View {

        NavigationView {

            VStack{
                if #available(iOS 16.0, *) {
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
                    .edgesIgnoringSafeArea(.all)
                    .scrollContentBackground(.hidden)
                    .background(.indigo)
                    .navigationTitle("Settings")
                    .onAppear { // ADD THESE
                        UITableView.appearance().backgroundColor = .white
                    }
                    .onDisappear {
                        UITableView.appearance().backgroundColor = .systemGroupedBackground
                    }
                } else {
                    // Fallback on earlier versions
                }
            } //: VSTACK

        } //: NAV VIEW

    }

}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

