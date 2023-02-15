//
//  LogInView.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/13/23.
//

import SwiftUI

struct LogInView: View {

    // MARK: - PROPERTIES
    @State private var email = ""
    @State private var password = ""

    // MARK: - BODY
    var body: some View {
        VStack{

            // Text fields for user inputs
//            CustomInputTextField(fieldTitle: "Email", isSecureField: false, text: $email)
//
//            CustomInputTextField(fieldTitle: "Password", isSecureField: true, text: $password)

            Spacer()

            // Done button
            Button(action: {
                // Verify info

            }, label: {
                Text("Done")
                    .fontWeight(.bold)
                    .modifier(ButtonModifier())
                    .frame(width:300, height: 50)
            })

            Spacer()

        } //: VSTACK
        .navigationTitle("Log In")
        .navigationBarTitleDisplayMode(.inline)
    }


}



// MARK: - PREVIEW
struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
