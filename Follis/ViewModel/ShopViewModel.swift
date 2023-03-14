//
//  ShopViewModel.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/8/23.
//

import Foundation
import Firebase

@MainActor
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
        db.collection("users").document(userUID).updateData(["cart_active": cartActive]){ _ in

            print("User data successfully uploaded.")
        }


    } //: UPDATE CART ACTIVE IN FIREBASE


    // Upload order to firebase
    func postOrderData(shop: Shop, cartTotalItems: String, cart: [MenuItem], selectedRequiredOptions: [MenuItem: [Required]], selectedModificationOptions: [MenuItem: [Modification]], selectedAddOptions: [MenuItem: [Add]], orderStatus: String){


        // Gets the current users uid so we can reference it
        guard let userUID = Auth.auth().currentUser?.uid else {return}

        // Create a reference to the database
        let db = Firestore.firestore()


        // Add a document to user's values collection
        let ordersDocRef = db.collection("users").document(userUID).collection("pending_orders").addDocument(data: ["shop_id": shop.id, "total_items": cartTotalItems, "user_who_ordered": userUID, "pending": true, "date_ordered": Timestamp(date: Date())]) { error in

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

        for i in 0..<(totalItems) {

            var cartItem = cart[i]

            let saveQuantity = cartItem.quantity!
            let saveHash = cartItem.hash!

            cartItem.quantity = nil
            cartItem.hash = nil

            print("Cart item in for loop")
            print(cartItem)
    

            // Store the array of required objects for the cart item
            let itemRequiredOptions = selectedRequiredOptions[cartItem, default: []]

            // Store the array of modified objects for the cart item
            let itemModificationOptions = selectedModificationOptions[cartItem, default: []]

            // Store the array of addOn objects for the cart item
            let itemAddOnOptions = selectedAddOptions[cartItem, default: []]

            cartItem.quantity = saveQuantity
            cartItem.hash = saveHash


            // Add a document to user's values collection
            let itemDocRef = db.collection("users").document(userUID).collection("pending_orders").document(ordersDocRef.documentID).collection("order_items").addDocument(data: ["name": cartItem.name, "order_id": ordersDocRef.documentID]) { error in

                // Check for errors
                if error == nil {
                    // No errors
//                    print("Success!")

                } else {
                    // Handle the error
                    print("Here's the error: \(String(describing: error?.localizedDescription))")
                    return
                }
            }
            
            for each in itemRequiredOptions {

                // Add a document to user's values collection
                db.collection("users").document(userUID).collection("pending_orders").document(ordersDocRef.documentID).collection("order_items").document(itemDocRef.documentID).collection("required").addDocument(data: ["option": each.option]) { error in

                    // Check for errors
                    if error == nil {
                        // No errors
//                        print("Success!")

                    } else {
                        // Handle the error
                        print("Here's the error: \(String(describing: error?.localizedDescription))")
                        return
                    }
                }

            }

            for each in itemAddOnOptions {

                // Add a document to user's values collection
                db.collection("users").document(userUID).collection("pending_orders").document(ordersDocRef.documentID).collection("order_items").document(itemDocRef.documentID).collection("add").addDocument(data: ["option": each.option, "price": each.price]) { error in

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

            for each in itemModificationOptions {

                // Add a document to user's values collection
                db.collection("users").document(userUID).collection("pending_orders").document(ordersDocRef.documentID).collection("order_items").document(itemDocRef.documentID).collection("modifications").addDocument(data: ["option": each.option]) { error in

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


        }

        // Share data to merchant as well
        postOrderDataToMerchant(userID: userUID, orderID: ordersDocRef.documentID, shop: shop, totalPrice: calcTotal())



    } //: ADD SHARE DATA TO BACKEND


    func postOrderDataToMerchant(userID: String, orderID: String, shop: Shop, totalPrice: Double){

        // Create a reference to the database
        let db = Firestore.firestore()

        let merchantID = shop.merchant_id ?? ""

        // Add a document to user's values collection
        let ordersDocRef = db.collection("merchants").document(merchantID).collection("pending_orders").addDocument(data: ["order_id": orderID, "user_id": userID, "total": totalPrice]) { error in

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


    func calcItemAddOnTotal(itemIndex: Int) -> Double{

        var addOptionsPrice = 0.0

        print(cartItems[itemIndex])
        
        //save values
        var saveQuantity = cartItems[itemIndex].quantity!
        var saveHash = cartItems[itemIndex].hash!
        
        //set to nil to match dictionary key
        cartItems[itemIndex].quantity = nil
        cartItems[itemIndex].hash = nil
        // Find all add options for that item
        let itemAddOptions = selectedAddOptions[cartItems[itemIndex]]
        
        cartItems[itemIndex].quantity = saveQuantity
        cartItems[itemIndex].hash = saveHash


        for each in itemAddOptions ?? [] {
            //print("Price: \(each.price)")

            print("INSIDE FOR LOOP IN VIEW MODEL")
            print(each.option)
            addOptionsPrice += Double(each.price) ?? 0.0
        }
        return addOptionsPrice

    }

    func updatePendingOrders(){

        
    }

    func calcTotal() -> Double {

        // Find items in cart
        subtotal = 0
        for cartItem in cartItems {

            subtotal += ((Double(cartItem.price) ?? 0.0) + calcItemAddOnTotal(itemIndex: cartItems.firstIndex(of: cartItem)!)) * Double(cartItem.quantity!)

        }

        tax = round((0.06 * subtotal) * 100) / 100.0

        total = 1.06 * subtotal


        total = round(total * 100) / 100.0

        let finalTotal = total

        return finalTotal


    } //: FUNC CALC TOTAL


    func calcTotalRewards() -> Int {

        totalRewards = 0
        // Find items in cart
        for cartItem in cartItems {

            totalRewards += (Int(cartItem.rewards) ?? 0) * cartItem.quantity!

        }

        let finalTotalRewards = totalRewards

        return finalTotalRewards

    } //: FUNC CALC TOTAL REWARDS
    
    func updateQuantity(index:Int, newQuantity:Int){
        cartItems[index].quantity = newQuantity
    }



}
