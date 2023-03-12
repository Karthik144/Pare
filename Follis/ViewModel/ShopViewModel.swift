//
//  ShopViewModel.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/8/23.
//

import Foundation
import Firebase


class ShopViewModel: ObservableObject {


    // MARK: - PROPERTIES
    @Published var shops = [Shop]()
    @Published var selectedRequiredOptions = [MenuItem: [Required]]()
    @Published var selectedModificationOptions = [MenuItem: [Modification]]()
    @Published var selectedAddOptions = [MenuItem: [Add]]()
    //    @Published var selectedAddOptions : [MenuItem: [Add]] = [:]
    @Published var cartItems = [MenuItem]()
    @Published var total = 0.0
    @Published var subtotal = 0.0
    @Published var tax = 0.0
    @Published private var totalRewards = 0

    
    private let service = ShopService()

    func fetchShops(completion: @escaping([Shop]) -> Void){

        Firestore.firestore().collection("shops").addSnapshotListener { (querySnapshot, error) in

            guard let documents = querySnapshot?.documents else {
                print("No documents in this collection.")
                return

            }

            let shops = documents.compactMap({ try? $0.data(as: Shop.self) })

            completion(shops)

        }

    } //: FUNC FETCH SHOPS


    func fetchShopMenu(withUID uid: String, completion: @escaping([MenuItem]) -> Void){

        Firestore.firestore().collection("shops").document(uid).collection("menu").addSnapshotListener { (querySnapshot, error) in

            guard let documents = querySnapshot?.documents else {
                print("No documents in this collection.")
                return

            }

            let menuItems = documents.compactMap({ try? $0.data(as: MenuItem.self) })

            completion(menuItems)

        }

    }


    func fetchItemAddOptions(withUID uid: String, itemUID: String, completion: @escaping([Add]) -> Void){

        Firestore.firestore().collection("shops").document(uid).collection("menu").document(itemUID).collection("add").addSnapshotListener { (querySnapshot, error) in

            guard let documents = querySnapshot?.documents else {
                print("No documents in this collection.")
                return

            }

            let addOptions = documents.compactMap({ try? $0.data(as: Add.self) })

            completion(addOptions)

        }

    } //: FETCH ITEM ADD OPTIONS

    func fetchItemRequiredOptions(withUID uid: String, itemUID: String, completion: @escaping([Required]) -> Void){

        Firestore.firestore().collection("shops").document(uid).collection("menu").document(itemUID).collection("required").addSnapshotListener { (querySnapshot, error) in

            guard let documents = querySnapshot?.documents else {
                print("No documents in this collection.")
                return

            }

            let requiredOptions = documents.compactMap({ try? $0.data(as: Required.self) })

            completion(requiredOptions)

        }

    } //: FETCH ITEM ADD OPTIONS


    func fetchItemModificationOptions(withUID uid: String, itemUID: String, completion: @escaping([Modification]) -> Void){

        Firestore.firestore().collection("shops").document(uid).collection("menu").document(itemUID).collection("modifications").addSnapshotListener { (querySnapshot, error) in

            guard let documents = querySnapshot?.documents else {
                print("No documents in this collection.")
                return

            }

            let modificationOptions = documents.compactMap({ try? $0.data(as: Modification.self) })

            completion(modificationOptions)

        }

    } //: FETCH ITEM ADD OPTIONS

    // Fetch pending orders data
    func fetchPendingOrders(completion: @escaping([PendingOrder]) -> Void){

        // Gets the current users uid so we can reference it
        guard let userUID = Auth.auth().currentUser?.uid else {return}

        Firestore.firestore().collection("users").document(userUID).collection("pending_orders").addSnapshotListener { (querySnapshot, error) in

            guard let documents = querySnapshot?.documents else {
                print("No documents in this collection.")
                return

            }

            let pendingOrders = documents.compactMap({ try? $0.data(as: PendingOrder.self) })

            completion(pendingOrders)

        }

    } //: FETCH ITEM ADD OPTIONS


    // NOTE: NEED TO FINISHED THIS FUNC TO UPLOAD DATA
    func updateCartActiveStatus(cartActive: Bool){

        // Gets the current users uid so we can reference it
        guard let userUID = Auth.auth().currentUser?.uid else {return}

        // Create a reference to the database
        let db = Firestore.firestore()

        // Takes us to the current user
        Firestore.firestore().collection("users").document(userUID).updateData(["cart_active": cartActive]){ _ in

            print("User data successfully uploaded.")
        }


    } //: UPDATE CART ACTIVE IN FIREBASE


    // Upload order to firebase
    func postOrderData(shopID: String, cartTotalItems: String, cart: [MenuItem], selectedRequiredOptions: [MenuItem: [Required]], selectedModificationOptions: [MenuItem: [Modification]], selectedAddOptions: [MenuItem: [Add]], orderStatus: String){

        // Gets the current users uid so we can reference it
        guard let userUID = Auth.auth().currentUser?.uid else {return}

        // Create a reference to the database
        let db = Firestore.firestore()


        // Add a document to user's values collection
        db.collection("users").document(userUID).collection("pending_orders").addDocument(data: ["shop_id": shopID, "total_items": cartTotalItems, "user_who_ordered": userUID, "date_ordered": Timestamp(date: Date())]) { error in

            // Check for errors
            if error == nil {
                // No errors
                print("Success!")

            } else {
                // Handle the error
                print("Here's the error: \(String(describing: error?.localizedDescription))")
                return
            }
        }

        let totalItems = Int(cartTotalItems) ?? 0

        for i in 0..<(totalItems-1) {

            var cartItem = cart[i]

            // Store the array of required objects for the cart item
            var itemRequiredOptions = selectedRequiredOptions[cartItem]

            // Store the array of modified objects for the cart item
            var itemModificationOptions = selectedModificationOptions[cartItem]

            // Store the array of addOn objects for the cart item
            var itemAddOnOptions = selectedAddOptions[cartItem]


            // Add a document to user's values collection
            db.collection("users").document(userUID).collection("pending_orders").addDocument(data: ["shop_id": shopID, "total_items": cartTotalItems, "user_who_ordered": userUID, "date_posted": Timestamp(date: Date())]) { error in

                // Check for errors
                if error == nil {
                    // No errors
                    print("Success!")

                } else {
                    // Handle the error
                    print("Here's the error: \(String(describing: error?.localizedDescription))")
                    return
                }
            }


        }



    } //: ADD SHARE DATA TO BACKEND


    func calcItemAddOnTotal(item: MenuItem) -> Double{

        var addOptionsPrice = 0.0

        // Find all add options for that item
        let itemAddOptions = selectedAddOptions[item]

        print("INSIDE CALC ITEM ADD ON TOTAL")
        print(itemAddOptions?.count)

        for each in itemAddOptions ?? [] {

            print("INSIDE FOR LOOP IN VIEW MODEL")
            print(each.option)
            addOptionsPrice += Double(each.price) ?? 0.0
        }

        return addOptionsPrice

    }

    func calcTotal() -> Double {

        // Find items in cart
        subtotal = 0
        for cartItem in cartItems {

            subtotal += ((Double(cartItem.price) ?? 0.0) + calcItemAddOnTotal(item: cartItem)) * Double(cartItem.quantity!)

        }

        tax = round((0.06 * subtotal) * 100) / 100.0

        total = 1.06 * subtotal


        total = round(total * 100) / 100.0

        let finalTotal = total

        return finalTotal


    } //: FUNC CALC TOTAL


    func calcTotalRewards() -> Int {

        // Find items in cart
        for cartItem in cartItems {

            totalRewards += Int(cartItem.rewards) ?? 0

        }

        let finalTotalRewards = totalRewards

        return finalTotalRewards

    } //: FUNC CALC TOTAL REWARDS
    
    func updateQuantity(index:Int, newQuantity:Int){
        cartItems[index].quantity = newQuantity
    }



}
