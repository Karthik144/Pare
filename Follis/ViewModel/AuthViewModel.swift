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
    @Published var isExistingUser = false
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

    func checkIfExistingUser(userEmail: String){

        Firestore.firestore().collection("merchants").getDocuments { (snapshot, error) -> Void in
             guard let snapshot = snapshot, error == nil else {
                 // Handle error
                 print ("An error occured while trying to verify your account.")
                 return
            }

            snapshot.documents.forEach({ (documentSnapshot) in
              let documentData = documentSnapshot.data()
              let email = documentData["email"] as? String

                if userEmail == email {

                    let docID = documentSnapshot.documentID

                    self.isExistingUser = true

//                    let user = User2(id: docID, email: email ?? "")

                }

            })
          }

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

