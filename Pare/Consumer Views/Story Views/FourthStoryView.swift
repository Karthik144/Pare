//
//  FourStoryView.swift
//  Pare
//
//  Created by Karthik  Ramu on 6/2/23.
//

import SwiftUI

struct FourthStoryView: View {

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
                
                Text("**USD**")
                    .foregroundColor(Color.accentColor)
                    .font(.title.weight(.bold))
                
//                +
//
//                Text(".\n")
//                    .foregroundColor(Color.accentColor)
//                    .font(.title.weight(.bold))
//
//                +
//
//                Text("(1 USD = 1 Dollar)")
//                    .foregroundColor(Color.gray)
                
            }
            .padding()
            .padding(.bottom, 0)
            .padding(.top, 0)

            // Main message
            Text("1 USD equals $1")
                .font(.title.weight(.bold))
                .padding()
                .padding(.bottom, 0)
            
            // Main message
            Text("It’s secure without relying on middlemen")
                .font(.title.weight(.bold))
                .padding()
                .padding(.bottom, 0)
            
            
//            Spacer(minLength: 100)
            
//            var Link = Link("https://www.example.com", destination: URL(string: "https://www.example.com")!)
//                .foregroundColor(.blue)
//
//            HStack{
//                let url = "https://www.electronicid.eu/en/blog/post/crypto-exchanges-compliance/en"
//
//                let link = "* The following steps may ask for your drivers license, ssn, and photo verification in order to comply with [U.S. Legal Regulations](\(url)) for digital cash 'Know Your Customer' procedures (KYC). Transak processes all this information. Transak is registered as a Money Service Business(MSB) with the US Treasury Financial Crimes Enforcement Network"
//                Text(.init(link))
//                    .padding()
//
//            }
            

            
            Spacer()
            
            HStack{
                Spacer()

//                // Show Transak View
//                NavigationLink {
//                    TransakController(publicAddress: authViewModel.currentUser?.public_address ?? "", firstName: authViewModel.currentUser?.first_name ?? "", lastName: authViewModel.currentUser?.last_name ?? "", emailUsername: self.username, emailDomain: self.domain)
//                } label: {
//
//                    Text("Add Funds")
//                        .fontWeight(.semibold)
//                        .foregroundColor(Color.white)
//                        .background(
//                            RoundedRectangle(cornerRadius: 8,  style: .continuous)
//                                .fill(Color.accentColor)
//                                .frame(width: 300, height: 50)
//                        )
//                        .frame(width:300, height: 50)
//
//                } //: NAV LINK
//                .padding(.bottom, 35)

                NavigationLink {

                    FifthStoryView() 
                    
                } label: {

                    Text("Next")
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .background(
                            RoundedRectangle(cornerRadius: 8,  style: .continuous)
                                .fill(Color.accentColor)
                                .frame(width: 300, height: 50)
                        )
                        .frame(width:300, height: 50)

                } //: NAV LINK
                .padding(.bottom, 35)


                
                Spacer()
            }

            
        } //: VSTACK
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)

//        .onAppear(){
//
//            // Split email into username and domain
//            let email = authViewModel.currentUser?.email ?? ""
//            let components = email.components(separatedBy: "@")
//
//            if components.count == 2 {
//                self.username = components[0]
//                self.domain = components[1]
//            } else {
//                print("Invalid email format - AddFundsView")
//            }
//
//        } //: ON APPEAR

    }
    
}
// MARK: - PREVIEW 
struct FourStoryView_Previews: PreviewProvider {
    static var previews: some View {
        FourthStoryView()
    }
}
