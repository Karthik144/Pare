//
//  TransakController.swift
//  Pare
//
//  Created by Karthik  Ramu on 5/30/23.
//

import SwiftUI
import WebKit

struct userData: Codable{
    let firstName: String
    let lastName: String
}


struct TransakController: View {

    // MARK: - PROPERTIES
    let publicAddress: String
    let firstName: String
    let lastName: String
    //let emailUsername: String
    //let emailDomain: String
    let email: String
    @State private var encodedString = ""
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State var param:String?

    

    // MARK: - BODY
    var body: some View{
        // URL Format: "https://global-stg.transak.com?apiKey=<YOUR_API_KEY>&<QUERY_PARAMETERS>"

        // Note: Can add userData object so they don't have to fill out First Name, Last Name, Mobile Number, Date of Birth -- need to edit user data below correctly so that we can input user details (this will bring us directly to the last step of KYC)

        
        //PRODUCTION
        WebView(url: URL(string: "https://global.transak.com/?apiKey=e0b53fa9-2126-450f-8a91-8239a0e4ae6d&network=polygon&defaultCryptoCurrency=USDC&cryptoCurrencyList=USDC&fiatCurrency=USD&defaultFiatAmount=30&walletAddress=\(publicAddress)&disableWalletAddressForm=true&email=\(email)&userData=%7B%22firstName%22%3A%22Jane%22%2C%22lastName%22%3A%22Doe%22%7D"), onError: {error in
                print("This is error: ", error)
            
        })
        .onDisappear(){
            authViewModel.updateUserWalletSetupStatus()
        }
        .onAppear{
            
            let userObject = userData(firstName: firstName, lastName: lastName)
            
            let jsonEncoder = JSONEncoder()
            guard let jsonData = try? jsonEncoder.encode(userObject) else {
                fatalError("Failed to encode object into JSON")
            }
            
            let jsonString = String(data: jsonData, encoding: .utf8) ?? ""

            encodedString = jsonString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

            print(encodedString)

        }
        
        /*
        //STAGING
        WebView(url: URL(string: "https://global-stg.transak.com/?apiKey=173117b1-85df-44a8-b66b-d7f2fa52822d&network=polygon&defaultCryptoCurrency=USDC&environment=STAGING&walletAddress=\(publicAddress)&disableWalletAddressForm=true&cryptoCurrencyList=USDC&fiatCurrency=USD&defaultFiatAmount=30&email=\(emailDomain)"), onError: {error in
                print(error)
            
        })
        .onDisappear(){
            authViewModel.updateUserWalletSetupStatus()
        }
        .onAppear{
            let jsonObject: [String:Any] = [
                "firstName" : firstName,
                "lastName" : lastName,
            ]
            
            guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: []) else {return}
            
            let jsonString = String(data: jsonData, encoding: .utf8)

            let encodedString = jsonString?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

            param = (encodedString ?? "")


        }
         */
    } //: VIEW
    


} //: TransakController

enum MyURLError: Error {

    case invalidURL


    var description: String {

        switch self {

        case .invalidURL:
            return "Your URL is incorrect."
        }
    }
} //: MyURLError

struct WebView: UIViewRepresentable {

    let url: URL?
    let onError: (MyURLError) -> Void

    private let webView = WKWebView()

    func makeUIView(context: Context) -> some UIView {
        return webView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        webView.load(url, onError: onError)
    }
} //: WEBVIEW

extension WKWebView {

    func load(_ url: URL?, onError: (MyURLError) -> Void){

        guard let url = url else {

            return onError(.invalidURL)
        }

        load(.init(url: url))
    }
} //: WKWebView


