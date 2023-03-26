//
//  HelpView.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/15/23.
//

import SwiftUI

struct HelpView: View {

    // MARK: - PROPERTIES
    var phoneNumber1 = "571-635-3433"
    var emailAddress1 = "wvv6xa@virginia.edu"

    var phoneNumber2 = "‭703-220-4590‬"
    var emailAddress2 = "cuw5zg@virginia.edu"

    init(){
        UITableView.appearance().backgroundColor = .clear
    }

    // MARK: - BODY
    var body: some View {



        VStack{

            HStack{

                Text("Contact any one of us and we'll fix your issue asap")
                    .foregroundColor(Color.black)
                    .padding()

                Spacer()

            } //: HSTACK

            if #available(iOS 16.0, *) {
                Form{

                    Section(header: Text("Karthik's Contact Info")) {
                        Button(action: {
                            if let url = URL(string: "tel:\(phoneNumber1)"), UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            HStack {
                                Image(systemName: "phone.circle.fill")
                                    .foregroundColor(.accentColor)
                                Text(phoneNumber1)
                            }
                        }

                        Button(action: {
                            if let url = URL(string: "mailto:\(emailAddress1)") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            HStack {
                                Image(systemName: "envelope.circle.fill")
                                    .foregroundColor(.accentColor)
                                Text(emailAddress1)
                            }
                        }

                    } //: SECTION

                    Section(header: Text("Akhil's Contact Info")) {
                        Button(action: {
                            if let url = URL(string: "tel:\(phoneNumber2)"), UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            HStack {
                                Image(systemName: "phone.circle.fill")
                                    .foregroundColor(.accentColor)
                                Text(phoneNumber2)
                            }
                        }

                        Button(action: {
                            if let url = URL(string: "mailto:\(emailAddress2)") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            HStack {
                                Image(systemName: "envelope.circle.fill")
                                    .foregroundColor(.accentColor)
                                Text(emailAddress2)
                            }
                        }

                    } //: SECTION
                } //: FORM
                .background(Color.white) // Set the background color of the VStack to white
                .scrollContentBackground(.hidden)
            } else {
                // Fallback on earlier versions
                Form{

                    Section(header: Text("Karthik's Contact Info")) {
                        Button(action: {
                            if let url = URL(string: "tel:\(phoneNumber1)"), UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            HStack {
                                Image(systemName: "phone.circle.fill")
                                    .foregroundColor(.accentColor)
                                Text(phoneNumber1)
                            }
                        }

                        Button(action: {
                            if let url = URL(string: "mailto:\(emailAddress1)") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            HStack {
                                Image(systemName: "envelope.circle.fill")
                                    .foregroundColor(.accentColor)
                                Text(emailAddress1)
                            }
                        }

                    } //: SECTION

                    Section(header: Text("Akhil's Contact Info")) {
                        Button(action: {
                            if let url = URL(string: "tel:\(phoneNumber2)"), UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            HStack {
                                Image(systemName: "phone.circle.fill")
                                    .foregroundColor(.accentColor)
                                Text(phoneNumber2)
                            }
                        }

                        Button(action: {
                            if let url = URL(string: "mailto:\(emailAddress2)") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            HStack {
                                Image(systemName: "envelope.circle.fill")
                                    .foregroundColor(.accentColor)
                                Text(emailAddress2)
                            }
                        }

                    } //: SECTION
                } //: FORM
                .background(Color.white) // Set the background color of the VStack to white
            }

        } //: VSTACK
        .navigationTitle("Help")
        .navigationBarTitleDisplayMode(.large)
    }
}


// MARK: - PREVIEW
struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
