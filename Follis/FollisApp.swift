//
//  FollisApp.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/13/23.
//

import UIKit
import SwiftUI
import Firebase
import metamask_ios_sdk
import Combine

class AppDelegate: UIResponder,UIApplicationDelegate{
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}


@main
struct FollisApp: App{
    //@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init(){
        FirebaseApp.configure()
    }

    @StateObject var viewModel = AuthViewModel()
    @StateObject var shopViewModel = ShopViewModel()
    @StateObject var FundsViewModel = JSONViewModel()
    @ObservedObject var appState = AppState()
    
    

    var body: some Scene {
        WindowGroup {
            WelcomeView()
                .environmentObject(viewModel)
                .environmentObject(appState)
                .environmentObject(FundsViewModel)
                .environmentObject(shopViewModel)
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
