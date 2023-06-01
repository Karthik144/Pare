//
//  AuthViewModel.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/13/23.
//

import Foundation
import Firebase
import FirebaseFunctions
import MagicSDK
import MagicSDK_Web3
import PromiseKit
import Web3PromiseKit


class AuthViewModel: ObservableObject{


    // MARK: - PROPERTIES
    @Published var userSession = Auth.auth().currentUser
    @Published var didAuthenticateUser = false
    @Published var currentUser: User?
    @Published var isExistingUser: Bool?
    @Published var DIDToken = ""
    @Published var publicAddress = ""
    //    @Published var cartItems = [MenuItem]()
    private let service = UserService()

    init(){
        // Sets user session to current user
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
    }

    // Register user
    func register(firstName: String, lastName: String, withEmail email: String, password: String, magic: Magic) {
        // Generate DID token with Magic Auth
        magic.auth.loginWithMagicLink(LoginWithMagicLinkConfiguration(showUI: false, email: email)).done({ result in
            self.DIDToken = result

            print("Result", result) // DIDToken

            let functions = Functions.functions()
            let auth = functions.httpsCallable("auth")

            auth.call(["didToken": self.DIDToken]) { (result, error) in
                if let error = error {

                    // Handle the error
                    print("Error: \(error.localizedDescription)")
                    return
                }

                if let data = result?.data as? [String: Any],
                   let customToken = data["token"] as? String {

                    // Handle the response data
                    print("Response: \(data)")

                    Auth.auth().signIn(withCustomToken: customToken) { (authResult, error) in
                        if let error = error as NSError? {
                            // Handle the error
                            print("Error: \(error.localizedDescription)")
                            return
                        }

                        // User successfully signed in
                        print("User signed in with custom token")
//                        isUserLoggedIn = true  // Set the login status

                        // Call getAccount to set public address
                        self.getAccount(magic: magic){ success in
                            if success{
                                // Saver user data to Firebase Firestore
                                guard let user = authResult?.user else { return }

                                Firestore.firestore().collection("users")
                                    .document(user.uid)
                                    .setData(["first_name": firstName, "last_name": lastName, "email": email, "public_address": self.publicAddress, "is_merchant": false, "cart_active": false, "rewards": 0, "wallet": true]){ _ in

                                        print("User data successfully uploaded.")

                                        self.didAuthenticateUser = true
                                        self.checkIfExistingUser(userEmail: email)
                                        self.fetchUser()
                                    }

                                // Set userSession as current user
                                self.userSession = user
                            }
                            else{
                                print("fuck")
                            }
                            
                        }

                        

                    }
                }
            } //: AUTH CALL
        }).catch { error in
            print("Error:", error) // Handle error from loginWithMagicLink
        }


    } //: FUNC REGISTER



    //Get User
    func fetchUser(){
        guard let uid = self.userSession?.uid else { return }

        service.fetchUser(withUid: uid) { user in
            self.currentUser = user
            self.fetchUser()
        }

    } // FETCH USER
    
    //Get User for archived users
    func fetchUser(uid: String?){
        guard let uid = self.userSession?.uid else { return }

        service.fetchUser(withUid: uid) { user in
            self.currentUser = user
            self.fetchUser(uid: uid as String)
        }

    } // FETCH USER

    func checkIfExistingUser(userEmail: String){

        service.checkIfExistingUser(userEmail: userEmail) { User2 in
            if User2.email == userEmail{
                self.isExistingUser = true
                self.fetchUser(uid: User2.id)

            } else {
                self.isExistingUser = false
            }
        }



    }


    // Login user
    func logIn(withEmail email: String, password: String, magic: Magic) {

//        Auth.auth().signIn(withEmail: email, password: password) { result, error in
//            if let error = error {
//                print("Could not login with error \(error.localizedDescription).")
//                return
//            }
//
//            // Save user data to Firebase Firestore
//            guard let user = result?.user else { return }
//            self.userSession = user
//            self.fetchUser()
//
//        }

        // Generate DID token with Magic Auth
        magic.auth.loginWithMagicLink(LoginWithMagicLinkConfiguration(showUI: false, email: email)).done({ result in

            self.DIDToken = result

            print("Result", result) // DIDToken

            let functions = Functions.functions()
            let auth = functions.httpsCallable("auth")

            auth.call(["didToken": self.DIDToken]) { (result, error) in
                if let error = error {

                    // Handle the error
                    print("Error: \(error.localizedDescription)")
                    return
                }

                if let data = result?.data as? [String: Any],
                   let customToken = data["token"] as? String {

                    // Handle the response data
                    print("Response: \(data)")

                    Auth.auth().signIn(withCustomToken: customToken) { (authResult, error) in
                        if let error = error as NSError? {
                            // Handle the error
                            print("Error: \(error.localizedDescription)")
                            return
                        }

                        // User successfully signed in
                        print("User signed in with custom token")
//                        isUserLoggedIn = true  // Set the login status

                        // Call get account to set public address
                        self.getAccount(magic: magic){ success in
                            if success{
                                // Set userSession as current user
                                self.userSession = authResult?.user
                                self.fetchUser()
                            }
                            else{
                                print("fuck")
                            }
                        }


                    }
                }
            } //: AUTH CALL
        }).catch { error in
            print("Error:", error) // Handle error from loginWithMagicLink
        }
        
    } //: FUNC LOGIN

    // Get user's public address
    func getAccount(magic: Magic, completion: @escaping (Bool) -> Void) {

        var web3 = Web3(provider: magic.rpcProvider)

        firstly {
            // Get user's Ethereum public address
            web3.eth.accounts()
        }.done { accounts -> Void in
            if let account = accounts.first {
                // Set to UILa
                self.publicAddress = account.hex(eip55: false)
                print("Public Address: \(self.publicAddress)")
                completion(true)

            } else {
                print("No Account Found")
                completion(false)
            }
        }.catch { error in
            print("Error loading accounts and balance: \(error)")
            completion(false)
        }
    } //: GET ACCOUNT

    // Sign user out
    func signOut() {

        // Sets user session to nil
        userSession = nil

        // Signs user out on backend
        try? Auth.auth().signOut()

    } //: FUNC SIGNOUT

    func deleteUser(){
        let db = Firestore.firestore()
        
        Auth.auth().currentUser?.delete { error in
            if let error = error {
                print("error deleting user - \(error)")
            } else {
                print("Account deleted")
            }
        }
        
        db.collection("users").document(currentUser?.id ?? "").delete()

        userSession = nil

    } //: DELETE USER

    func updateUserData(firstName: String, lastName: String, email: String){

        // Update first name

        // Create a reference to the database
        let db = Firestore.firestore()

        // Takes us to the current user
        db.collection("users").document(currentUser?.id ?? "").updateData(["first_name": firstName]){ _ in

            print("User data successfully uploaded.")
        }

        // Update last name
        db.collection("users").document(currentUser?.id ?? "").updateData(["last_name": lastName]){ _ in

            print("User data successfully uploaded.")
        }

        // Update email
        db.collection("users").document(currentUser?.id ?? "").updateData(["email": email]){ _ in

            print("User data successfully uploaded.")
        }
    }

    func updateUserWalletSetupStatus(){

        // Update first name

        // Create a reference to the database
        let db = Firestore.firestore()

        // Updates wallet status
        db.collection("users").document(currentUser?.id ?? "").updateData(["wallet": true]){ _ in

            print("User data successfully uploaded.")
        }

    }



}

