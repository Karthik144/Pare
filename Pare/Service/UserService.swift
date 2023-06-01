//
//  UserService.swift
//  Follis
//
//  Created by Karthik  Ramu on 2/13/23.
//

import Firebase
import FirebaseFirestoreSwift

struct UserService {


    // Fetches current user data
    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void){

        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
            guard let snapshot = snapshot else { return }

            guard let user = try? snapshot.data(as: User.self) else { return }

            completion(user)
        }
    } //: FETCH USER DATA

    func checkIfExistingUser(userEmail: String, completion: @escaping (UserCheck) -> Void) {


        Firestore.firestore().collection("users").getDocuments { (snapshot, error) -> Void in
             guard let snapshot = snapshot, error == nil else {
                 // Handle error
                 print ("An error occured while trying to verify your account. - checkIfExistingUser, UserService")
                 return
            }

            snapshot.documents.forEach({ (documentSnapshot) in
              let documentData = documentSnapshot.data()
              let email = documentData["email"] as? String

                if userEmail == email {

                    let docID = documentSnapshot.documentID

                    let user = UserCheck(id: docID, email: email ?? "")

                    completion(user)

                }

            })
          }


    }

}
