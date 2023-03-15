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
    @Published var cartItems = [Order]()
    @Published var total = 0.0
    @Published var subtotal = 0.0
    @Published var tax = 0.0
    @Published var rewards = 0
    @Published private var totalRewards = 0

    // Properties for uploading to completed_orders
    @Published private var pendingOrders = [PendingOrder]()
    
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

    } //: FETCH PENDING ORDERS

    func fetchOrderItems(pendingOrderID: String, completion: @escaping([OrderItem]) -> Void){


        // Gets the current users uid so we can reference it
        guard let userUID = Auth.auth().currentUser?.uid else {return}

        Firestore.firestore().collection("users").document(userUID).collection("pending_orders").document(pendingOrderID).collection("order_items").addSnapshotListener { (querySnapshot, error) in

            guard let documents = querySnapshot?.documents else {
                print("No documents in this collection.")
                return

            }

            let orderItems = documents.compactMap({ try? $0.data(as: OrderItem.self) })

            completion(orderItems)

        }

    } //: FETCH ORDER ITEMS

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

    func updateRewards(rewards: Int){

        // Gets the current users uid so we can reference it
        guard let userUID = Auth.auth().currentUser?.uid else {return}

        // Create a reference to the database
        let db = Firestore.firestore()

        // Takes us to the current user
        db.collection("users").document(userUID).updateData(["rewards": rewards]){ _ in

            print("User data successfully uploaded.")
        }


    } //: UPDATE REWARDS IN FIREBASE

    // NOTE: NEED TO FINISHED THIS FUNC TO UPLOAD DATA
    func updatePendingToComplete(pendingOrderID: String, complete: Bool){

        // Gets the current users uid so we can reference it
        guard let userUID = Auth.auth().currentUser?.uid else {return}

        // Create a reference to the database
        let db = Firestore.firestore()

        // Takes us to the current user
        db.collection("users").document(userUID).collection("pending_orders").document(pendingOrderID).updateData(["complete": complete]){ _ in

            print("User data successfully uploaded.")
        }


    } //: UPDATE CART ACTIVE IN FIREBASE


    // Upload order to firebase
    func postOrderData(shop: Shop, cartTotalItems: String, cart: [Order], orderStatus: String, subtotal: Double, total: Double){
        // Gets the current users uid so we can reference it
        guard let userUID = Auth.auth().currentUser?.uid else {return}

        // Create a reference to the database
        let db = Firestore.firestore()


        // Add a document to user's values collection
        let ordersDocRef = db.collection("users").document(userUID).collection("pending_orders").addDocument(data: ["shop_id": shop.id, "total_items": cartTotalItems, "user_who_ordered": userUID, "pending": true, "complete": false, "subtotal": subtotal, "total": total, "date_ordered": Timestamp(date: Date())]) { error in

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
            


            // Add a document to user's values collection
            let itemDocRef = db.collection("users").document(userUID).collection("pending_orders").document(ordersDocRef.documentID).collection("order_items").addDocument(data: ["name": cartItem.item.name, "price": cartItem.item.price, "quantity": cartItem.item.quantity ?? 1, "rewards": cartItem.item.rewards, "order_id": ordersDocRef.documentID]) { error in

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
            
            for each in cartItem.requiredSelection ?? []{

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

            for each in cartItem.addOns ?? [] {

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

            for each in cartItem.modifications ?? [] {

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





    func calcItemAddOnTotal(order: Order) -> Double{
        var addOptionsPrice = 0.0
        
        for each in order.addOns ?? []{
            addOptionsPrice += Double(each.price) ?? 0.0
        }

        return addOptionsPrice
    }

    func calcTotal() -> Double {

        // Find items in cart
        subtotal = 0.0
        for cartOrder in cartItems {

            subtotal += ((Double(cartOrder.item.price) ?? 0.0) + calcItemAddOnTotal(order: cartOrder)) * Double(cartOrder.item.quantity!)

            rewards += Int(cartOrder.item.rewards) ?? 0

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
        for cartOrder in cartItems {

            totalRewards += (Int(cartOrder.item.rewards) ?? 0) * cartOrder.item.quantity!

        }

        let finalTotalRewards = totalRewards

        return finalTotalRewards

    } //: FUNC CALC TOTAL REWARDS
    
    
    func updateQuantity(index:Int, newQuantity:Int){
        cartItems[index].item.quantity = newQuantity
    } //: FUNC UPDATE QUANTITY


    func updatePendingOrders(){
        print("Change pending status from true to false")
    }
}
