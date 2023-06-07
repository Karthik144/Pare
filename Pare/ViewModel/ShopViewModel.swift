//
//  ShopViewModel.swift
//  Follis
//
//  Created by Karthik  Ramu on 3/8/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

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
    @Published var rewards = 0.0
    @Published var totalRewards = 0.0

    // Properties for uploading to completed_orders
    @Published private var allOrders = [PendingOrder]()
    
    private let service = ShopService()

    func fetchShops(completion: @escaping([Shop]) -> Void){

        Firestore.firestore().collection("shops").addSnapshotListener { (querySnapshot, error) in

            guard let documents = querySnapshot?.documents else {
                print("No documents in this collection. - fetchShops, ShopViewModel")
                return

            }

            let shops = documents.compactMap({ try? $0.data(as: Shop.self) })

            completion(shops)

        }

    } //: FUNC FETCH SHOPS

    
    func fetchLunchMenu(withUID uid: String, completion: @escaping([MenuItem]) -> Void){
        Firestore.firestore().collection("shops").document(uid).collection("lunch_specials").addSnapshotListener { (querySnapshot, error) in

            guard let documents = querySnapshot?.documents else {
                print("No documents in this collection. - fetchShopsMenu, ShopViewModel")
                return

            }

            let menuItems = documents.compactMap({ try? $0.data(as: MenuItem.self) })

            completion(menuItems)

        }
    }
    
    func fetchLunchRequired(withUID uid: String, itemUID: String, completion: @escaping([Required]) -> Void){
        
        Firestore.firestore().collection("shops").document(uid).collection("lunch_specials").document(itemUID).collection("required_drink").addSnapshotListener { (querySnapshot, error) in

            guard let documents = querySnapshot?.documents else {
                print("No documents in this collection. - fetchItemRequiredOptions, ShopViewModel")
                return

            }

            let requiredOptions = documents.compactMap({ try? $0.data(as: Required.self) })

            completion(requiredOptions)

        }

    } //: FETCH LUNCH DRINK OPTIONS

    func fetchShopMenu(withUID uid: String, completion: @escaping([MenuItem]) -> Void){

        Firestore.firestore().collection("shops").document(uid).collection("menu").addSnapshotListener { (querySnapshot, error) in

            guard let documents = querySnapshot?.documents else {
                print("No documents in this collection. - fetchShopsMenu, ShopViewModel")
                return

            }

            let menuItems = documents.compactMap({ try? $0.data(as: MenuItem.self) })

            completion(menuItems)

        }

    }



    func fetchItemAddOptions(withUID uid: String, itemUID: String, completion: @escaping([Add]) -> Void){

        Firestore.firestore().collection("shops").document(uid).collection("menu").document(itemUID).collection("add").addSnapshotListener { (querySnapshot, error) in

            guard let documents = querySnapshot?.documents else {
                print("No documents in this collection. - fetchItemAddOptions, ShopViewModel")
                return

            }

            let addOptions = documents.compactMap({ try? $0.data(as: Add.self) })

            completion(addOptions)

        }

    } //: FETCH ITEM ADD OPTIONS

    func fetchItemRequiredOptions(withUID uid: String, itemUID: String, completion: @escaping([Required]) -> Void){

        Firestore.firestore().collection("shops").document(uid).collection("menu").document(itemUID).collection("required").addSnapshotListener { (querySnapshot, error) in

            guard let documents = querySnapshot?.documents else {
                print("No documents in this collection. - fetchItemRequiredOptions, ShopViewModel")
                return

            }

            let requiredOptions = documents.compactMap({ try? $0.data(as: Required.self) })

            completion(requiredOptions)

        }

    } //: FETCH ITEM ADD OPTIONS


    func fetchItemModificationOptions(withUID uid: String, itemUID: String, completion: @escaping([Modification]) -> Void){

        Firestore.firestore().collection("shops").document(uid).collection("menu").document(itemUID).collection("modifications").addSnapshotListener { (querySnapshot, error) in

            guard let documents = querySnapshot?.documents else {
                print("No documents in this collection. - fetchItemModification, ShopViewModel")
                return

            }

            let modificationOptions = documents.compactMap({ try? $0.data(as: Modification.self) })

            completion(modificationOptions)

        }

    } //: FETCH ITEM ADD OPTIONS

    // Fetch pending orders data
    func fetchAllOrders(completion: @escaping([PendingOrder]) -> Void){

        // Gets the current users uid so we can reference it
        guard let userUID = Auth.auth().currentUser?.uid else {return}

        Firestore.firestore().collection("users").document(userUID).collection("orders").addSnapshotListener { (querySnapshot, error) in

            guard let documents = querySnapshot?.documents else {
                print("No documents in this collection. - fetchAllOrders, ShopViewModel")
                return

            }

            let ordersallOrders = documents.compactMap({ try? $0.data(as: PendingOrder.self) })

            completion(ordersallOrders)

        }

    } //: FETCH PENDING ORDERS


    func fetchOrderItems(pendingOrderID: String, completion: @escaping([OrderItem]) -> Void){


        // Gets the current users uid so we can reference it
        guard let userUID = Auth.auth().currentUser?.uid else {return}

        Firestore.firestore().collection("users").document(userUID).collection("orders").document(pendingOrderID).collection("order_items").addSnapshotListener { (querySnapshot, error) in

            guard let documents = querySnapshot?.documents else {
                print("No documents in this collection. - fetchOrderItems, ShopViewModel")
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

            print("User data successfully uploaded. - updateCartActiveStatus, ShopViewModel")
        }


    } //: UPDATE CART ACTIVE IN FIREBASE

    func updateRewards(rewards: Double){

        // Gets the current users uid so we can reference it
        guard let userUID = Auth.auth().currentUser?.uid else {return}

        // Create a reference to the database
        let db = Firestore.firestore()

        // Takes us to the current user
        db.collection("users").document(userUID).updateData(["rewards": rewards]){ _ in

            print("User data successfully uploaded. - updateRewards, ShopViewModel")
        }


    } //: UPDATE REWARDS IN FIREBASE

    // NOTE: NEED TO FINISHED THIS FUNC TO UPLOAD DATA
    func updatePendingToComplete(pendingOrderID: String){

        // Gets the current users uid so we can reference it
        guard let userUID = Auth.auth().currentUser?.uid else {return}

        // Create a reference to the database
        let db = Firestore.firestore()

        // Takes us to the current user
        db.collection("users").document(userUID).collection("orders").document(pendingOrderID).updateData(["status": "complete"]){ _ in

            print("User data successfully uploaded. - updatePendingToComplete, ShopViewModel")
        }


    } //: UPDATE CART ACTIVE IN FIREBASE


    // Upload order to firebase
    func postOrderData(shop: Shop, cartTotalItems: String, cart: [Order], orderStatus: String, subtotal: Double, total: Double, user: User, rewards: Bool, notes: String, promo_used: Bool){
        // Gets the current users uid so we can reference it
        guard let userUID = Auth.auth().currentUser?.uid else {return}

        // Create a reference to the database
        let db = Firestore.firestore()

        var totalItems = 0

        for each in cartItems{
            totalItems += each.item.quantity ?? 1
        }


        // Add a document to user's values collection
        let ordersDocRef = db.collection("users").document(userUID).collection("orders").addDocument(data: ["shop_id": shop.id!, "total_items": String(totalItems ?? 0), "user_who_ordered": userUID, "status": "pending", "subtotal": subtotal, "total": total, "rewards": rewards, "notes": notes, "promo_used": promo_used, "date_ordered": Timestamp(date: Date())]) { error in

            // Check for errors
            if error == nil {
                // No errors

            } else {
                // Handle the error
                print("Here's the error: \(String(describing: error?.localizedDescription)) - postOrderData, ShopViewModel")
                return
            }
        }


        var totalIndex = Int(cartTotalItems) ?? 0

        for i in 0..<(totalIndex) {

            var cartItem = cart[i]

//            var cartItem = cartItems[i]

            // Add a document to user's values collection
            let itemDocRef = db.collection("users").document(userUID).collection("orders").document(ordersDocRef.documentID).collection("order_items").addDocument(data: ["name": cartItem.item.name, "price": cartItem.item.price, "quantity": cartItem.item.quantity ?? 0, "rewards": cartItem.item.rewards, "order_id": ordersDocRef.documentID, "type": cartItem.item.type]) { error in

                // Check for errors
                if error == nil {
                    // No errors

                } else {
                    // Handle the error
                    print("Here's the error: \(String(describing: error?.localizedDescription)) - pastOrderData, ShopViewModel")
                    return
                }
            }
            
            for each in cartItem.requiredSelection ?? []{

                // Add a document to user's values collection
                db.collection("users").document(userUID).collection("orders").document(ordersDocRef.documentID).collection("order_items").document(itemDocRef.documentID).collection("required").addDocument(data: ["option": each.option]) { error in

                    // Check for errors
                    if error == nil {
                        // No errors

                    } else {
                        // Handle the error
                        print("Here's the error: \(String(describing: error?.localizedDescription)) - pastOrderData, ShopViewModel")
                        return
                    }
                }

            }
            
            

            for each in cartItem.addOns ?? [] {

                // Add a document to user's values collection
                db.collection("users").document(userUID).collection("orders").document(ordersDocRef.documentID).collection("order_items").document(itemDocRef.documentID).collection("add").addDocument(data: ["option": each.option, "price": each.price]) { error in

                    // Check for errors
                    if error == nil {
                        // No errors

                    } else {
                        // Handle the error
                        print("Here's the error: \(String(describing: error?.localizedDescription)) - pastOrderData, ShopViewModel")
                        return
                    }
                }

            }

            for each in cartItem.modifications ?? [] {

                // Add a document to user's values collection
                db.collection("users").document(userUID).collection("orders").document(ordersDocRef.documentID).collection("order_items").document(itemDocRef.documentID).collection("modifications").addDocument(data: ["option": each.option]) { error in

                    // Check for errors
                    if error == nil {
                        // No errors

                    } else {
                        // Handle the error
                        print("Here's the error: \(String(describing: error?.localizedDescription)) - pastOrderData, ShopViewModel")
                        return
                    }
                }

            }


        }

        // Share data to merchant as well
        postOrderDataToMerchant(userID: userUID, orderID: ordersDocRef.documentID, shop: shop, totalPrice: total, user: user, totalItems: totalItems, notes: notes)



    } //: ADD SHARE DATA TO BACKEND


    func postOrderDataToMerchant(userID: String, orderID: String, shop: Shop, totalPrice: Double, user: User, totalItems: Int, notes: String){

        // Create a reference to the database
        let db = Firestore.firestore()


        let merchantID = shop.merchant_id ?? ""

        

        // Add a document to user's values collection
        let ordersDocRef = db.collection("merchants").document(merchantID).collection("orders").addDocument(data: ["order_id": orderID, "user_id": userID, "total": totalPrice, "consumer_name": user.first_name + " " + user.last_name, "date_ordered": Timestamp(date: Date()), "notes": notes, "total_items": String(totalItems)]) { error in

            // Check for errors
            if error == nil {
                // No errors

            } else {
                // Handle the error
                print("Here's the error: \(String(describing: error?.localizedDescription)) - postOrderDataToMerchant, ShopViewModel")
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

            rewards += Double(cartOrder.item.rewards) ?? 0.0

        }

        tax = round((0.06 * subtotal) * 100) / 100.0

        total = 1.06 * subtotal


        total = round(total * 100) / 100.0

        let finalTotal = total

        return finalTotal


    } //: FUNC CALC TOTAL


    func calcTotalRewards() -> Double {

        totalRewards = 0.0
        // Find items in cart
        for cartOrder in cartItems {

            totalRewards += (Double(cartOrder.item.rewards) ?? 0.0) * Double(cartOrder.item.quantity!)

        }

        let finalTotalRewards = totalRewards

        return finalTotalRewards

    } //: FUNC CALC TOTAL REWARDS
    
    
    func updateQuantity(index:Int, newQuantity:Int){

        cartItems[index].item.quantity = newQuantity

    } //: FUNC UPDATE QUANTITY

}
