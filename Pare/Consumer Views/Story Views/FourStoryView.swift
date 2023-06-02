//
//  FourStoryView.swift
//  Pare
//
//  Created by Karthik  Ramu on 6/2/23.
//

import SwiftUI

struct FourStoryView: View {

    // MARK: - PROPERTIES
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var username = ""
    @State private var domain = ""

    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading){
            
            // Main message
            Group{
                
                Text("With Pare, you use digital cash called ")
                    .font(.title.weight(.bold))
                
                +
                
                Text("**USDC** ")
                    .foregroundColor(Color.accentColor)
                    .font(.title.weight(.bold))
                
                +
                
                Text(".")
                    .foregroundColor(Color.accentColor)
                    .font(.title.weight(.bold))
            }
            .padding()
            .padding(.bottom, 0)
            
            // Main message
            Text("It’s secure without relying on middlemen.")
                .font(.title.weight(.bold))
                .padding()
                .padding(.bottom, 0)
            
            
            Spacer()
            
            HStack{
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
                        .frame(width:300, height: 50)
                    
                } //: BUTTON
                .padding(.bottom, 35)
                
                Spacer()
            }
            
        } //: VSTACK
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
    }
    
}
// MARK: - PREVIEW 
struct FourStoryView_Previews: PreviewProvider {
    static var previews: some View {
        FourStoryView()
    }
}
