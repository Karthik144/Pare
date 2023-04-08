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

@main
struct PareApp: App{
    //@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init(){
        FirebaseApp.configure()
    }

    @StateObject var viewModel = AuthViewModel()
    @StateObject var shopViewModel = ShopViewModel()
    @ObservedObject var appState = AppState()
    @StateObject var sheetManager = SheetManager()
    
    

    var body: some Scene {
        WindowGroup {
            WelcomeView()
                .environmentObject(viewModel)
                .environmentObject(appState)
                .environmentObject(shopViewModel)
                .environmentObject(sheetManager)
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
