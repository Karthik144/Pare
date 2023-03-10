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

    let imageList = ["person", "calendar.badge.clock", "questionmark.circle"]
    let textList = ["Personal", "Past Orders", "Help"]




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

                        Text("220 Points")
                            .font(.callout)
                            .foregroundColor(Color.black)
                    } //: HSTACK
                    .padding(.leading, 5)

                } //: VSTACK


                Spacer()

                ForEach((0..<imageList.count), id: \.self) { i in

                    NavigationLink {
                        PersonalView()
                    } label: {
                        ProfileItemCell(imageName: imageList[i], cellText: textList[i])
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                    }

                } //: FOR EACH

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


        } //: NAV VIEW



    }

}


    // MARK: - PREVIEW
    struct ProfileView_Previews: PreviewProvider {
        static var previews: some View {
            ProfileView()
        }
    }
