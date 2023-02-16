//
//  AuthViewModel.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/13/23.
//

import Foundation
import Firebase


class AuthViewModel: ObservableObject{


    // MARK: - PROPERTIES
    @Published var userSession = Auth.auth().currentUser
    @Published var didAuthenticateUser = false
    @Published var currentUser: User?
    @Published var User2: User2?
    private let service = UserService()

    init(){
        // Sets user session to current user
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
    }

    // Register user
    func register(firstName: String, lastName: String, withEmail email: String, password: String, isMerchant: Bool) {

        Auth.auth().createUser(withEmail: email, password: password) { result, error in

            // Check for error
            if let error = error {
                print("Could not create account with error \(error.localizedDescription).")
                return
            }


            // Saver user data to Firebase Firestore
            guard let user = result?.user else { return }

            Firestore.firestore().collection("merchants")
                .document(user.uid)
                .setData(["first_name": firstName, "last_name": lastName, "email": email, "is_merchant": isMerchant]){ _ in
                    print("User data successfully uploaded.")
                    self.didAuthenticateUser = true
                    self.fetchUser()
                }

            self.userSession = user

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

    func checkIfExistingUser(email: String) -> Bool{

        var isExisting = false
        service.checkIfExistingUser(userEmail: email) { user in
            self.User2 = user
//            print(self.User2?.email)
            self.checkIfExistingUser(email: user.email)
        }

        if (User2?.email == email){
            isExisting = false
        } else {
            isExisting = true
        }

        return isExisting
    }


    // Login user
    func logIn(withEmail email: String, password: String) {

        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Could not login with error \(error.localizedDescription).")
                return
            }

            // Save user data to Firebase Firestore
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()

        }
    } //: FUNC LOGIN

    // Sign user out
    func signOut() {

        // Sets user session to nil
        userSession = nil

        // Signs user out on backend
        try? Auth.auth().signOut()

    } //: FUNC SIGNOUT

    func deleteUser(){
        Auth.auth().currentUser?.delete { error in
            if let error = error {
                print("error deleting user - \(error)")
            } else {
                print("Account deleted")
            }
        }

        userSession = nil

    } //: DELETE USER



}

