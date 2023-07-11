//
//  FollisApp.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/13/23.
//

import UIKit
import SwiftUI
import Firebase
import Combine
import Stripe

@main
struct PareApp: App{
    //@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init(){
        FirebaseApp.configure()
    }

    @StateObject var viewModel = AuthViewModel()
    @StateObject var walletViewModel = WalletViewModel()
    @StateObject var web3WalletViewModel = web3ViewModel()
    @StateObject var shopViewModel = ShopViewModel()
    @ObservedObject var appState = AppState()
    @StateObject var sheetManager = SheetManager()
    @StateObject var promoSheetManager = PromoSheetManager()
//    StripeAPI.defaultPublishableKey = "pk_test_51NGLJGLYY9K9hzsbArCeG7aiT6s7jGuoGynpbGN5obXCKI9BKOd4Y3vH9qvxKPXKMG46Cpo5xehIaBu5gzSlIQFX00zLqGG45z"

    var body: some Scene {
        WindowGroup {
            WelcomeView(walletViewModel: web3WalletViewModel)
                .environmentObject(viewModel)
                .environmentObject(walletViewModel)
                .environmentObject(appState)
                .environmentObject(shopViewModel)
                .environmentObject(web3WalletViewModel)
                .environmentObject(sheetManager)
                .environmentObject(promoSheetManager)

        }

    }
}




/*
extension URLSession {
  func fetchData<T: Decodable>(for url: URL, completion: @escaping (Result<T, Error>) -> AnyPublisher<T,Error>) {
      URLSession.shared
          .dataTaskPublisher(for: url)
          .tryMap { (data,response) -> T in
              return data as! T
          }
          .eraseToAnyPublisher()
  }
}
*/

/*

extension URLSession {
  func fetchData<T: Decodable>(for url: URL, completion: @escaping (Result<T, Error>) -> Void) {
    self.dataTask(with: url) { (data, response, error) in
      if let error = error {
        completion(.failure(error))
      }

      if let data = data {
        do {
          let object = try JSONDecoder().decode(T.self, from: data)
          completion(.success(object))
        } catch let decoderError {
          completion(.failure(decoderError))
        }
      }
    }.resume()
  }
}

*/
