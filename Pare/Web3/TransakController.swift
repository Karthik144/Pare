//
//  TransakController.swift
//  Pare
//
//  Created by Karthik  Ramu on 5/30/23.
//

import SwiftUI
import WebKit

struct TransakController: View {

    // MARK: - PROPERTIES
    let publicAddress: String
    let firstName: String
    let lastName: String
    let emailUsername: String
    let emailDomain: String

    // MARK: - BODY
    var body: some View{

        // URL Format: "https://global-stg.transak.com?apiKey=<YOUR_API_KEY>&<QUERY_PARAMETERS>"

        // Note: Can add userData object so they don't have to fill out First Name, Last Name, Mobile Number, Date of Birth -- need to edit user data below correctly so that we can input user details (this will bring us directly to the last step of KYC)
        WebView(url: URL(string: "https://global-stg.transak.com/?apiKey=d66d374c-d314-452e-ad13-3fbfc6e1319f&network=polygon&defaultCryptoCurrency=USDC&environment=STAGING&cryptoCurrencyList=USDC&walletAddress=\(publicAddress)&fiatCurrency=USD&defaultFiatAmount=30&hideMenu=true&themeColor=2B4AEE&productsAvailed=BUY&exchangeScreenTitle=Add%20coins%20to%20your%20wallet.&userData=%7B%22firstName%22%3A%22\(firstName)%22%2C%22lastName%22%3A%22\(lastName)%22%2C%22email%22%3A%22\(emailUsername)%40\(emailDomain)%22%2C%22mobileNumber%22%3A%22%2B15417543010%22%2C%22dob%22%3A%221994-08-26%22%2C%22address%22%3A%7B%22addressLine1%22%3A%22170%20Pine%20St%22%2C%22addressLine2%22%3A%22San%20Francisco%22%2C%22city%22%3A%22San%20Francisco%22%2C%22state%22%3A%22CA%22%2C%22postCode%22%3A%2294111%22%2C%22countryCode%22%3A%22US%22%7D%7D"), onError: { error in

            print("Error - TransakController:", error.description)

        })

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


