//
//  ProfileView.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/8/23.
//

import SwiftUI

struct ProfileView: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showingAlert = false
    @State private var isViewActive: Bool = false

    let imageList = ["person", "calendar.badge.clock", "questionmark.circle"]
    let textList = ["Personal", "Past Orders", "Help"]

    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""

    // MARK: - BODY
    var body: some View {


        NavigationView{


            VStack{

                Spacer()

                // Profile with points and name
                VStack(spacing: 5){

                    Circle()
                        .frame(width: 70, height: 70)
                        .foregroundColor(Color.gray)

                    Text(viewModel.currentUser?.first_name ?? "Error" + "" + (viewModel.currentUser?.last_name ?? "Error"))
                        .font(.title)
                        .foregroundColor(Color.black)

                    HStack{
                        Image("GlowingStar")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .scaledToFit()

                        Text(String(viewModel.currentUser?.rewards ?? 0) + " Points")
                            .font(.callout)
                            .foregroundColor(Color.black)
                    } //: HSTACK
                    .padding(.leading, 5)

                } //: VSTACK


                Spacer()


                NavigationLink(destination: PersonalView(viewActive: $isViewActive, email: $email, firstName: $firstName, lastName: $lastName), isActive: $isViewActive){

                    ProfileItemCell(imageName: imageList[0], cellText: textList[0])
                        .padding(.leading, 20)
                        .padding(.trailing, 20)

                }
                .isDetailLink(false)

//                NavigationLink {
//                    PersonalView(email: $email, firstName: $firstName, lastName: $lastName)
//                } label: {
//                    ProfileItemCell(imageName: imageList[0], cellText: textList[0])
//                        .padding(.leading, 20)
//                        .padding(.trailing, 20)
//                }

                NavigationLink {
                    PastOrderView()
                } label: {
                    ProfileItemCell(imageName: imageList[1], cellText: textList[1])
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                }

                NavigationLink {
                    HelpView()
                } label: {
                    ProfileItemCell(imageName: imageList[2], cellText: textList[2])
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                }

                Spacer()

                // Sign out and delete account buttons
                VStack(spacing: 10){

                    Button {
                        viewModel.signOut()
                    } label: {
                        Text("Sign Out")
                            .foregroundColor(Color.accentColor)
                    }

                    Button {
                        showingAlert.toggle()
                    } label: {
                        Text("Delete account")
                            .foregroundColor(Color.red)
                    }
                    .foregroundColor(Color.red)
                    .alert("Are you sure you want to delete your account?", isPresented: $showingAlert){

                        Button("Cancel", role: .cancel){}

                        Button("Delete", role: .destructive){
                            viewModel.deleteUser()
                        }

                    } //: ALERT

                } //: VSTACK

                Spacer()


            } //: VSTACK
            .onAppear(){
                self.firstName = viewModel.currentUser?.first_name ?? "Error"
                self.lastName = viewModel.currentUser?.last_name ?? "Error"
                self.email = viewModel.currentUser?.email ?? "Error"
            }


        } //: NAV VIEW



    }

}


    // MARK: - PREVIEW
    struct ProfileView_Previews: PreviewProvider {
        static var previews: some View {
            ProfileView()
        }
    }
