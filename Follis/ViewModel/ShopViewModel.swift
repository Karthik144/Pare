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

    // Properties for uploading to completed_orders
    @Published private var pendingOrders = [PendingOrder]()
    @Published private var orderItems = [OrderItem]()
    @Published private var orderAddOptions = [OrderItem : [Add]]()
    @Published private var orderRequiredOptions = [OrderItem : [Required]]()
    @Published private var orderModificationOptions = [OrderItem : [Modification]]()

    
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


    // Upload order to firebase - original
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

    // NEED TO FIX
    func updatePendingOrders(){

        fetchPendingData()

        
    }

    // NEED TO FIX
    func fetchPendingData(){


        // Fetch pending orders
        fetchPendingOrders { orders in
            self.pendingOrders = orders

            // Fetch order items of the 1 pending order
            // Note: User can only have 1 pending order at a time
            if !self.pendingOrders.isEmpty{

                self.fetchOrderItems(orderID: self.pendingOrders[0].id ?? "") { items in
                    self.orderItems = items

                    self.updateAddDict { dict in
                        self.orderAddOptions = dict

                        self.uploadCompleteData()

                    }


//                    self.uploadCompleteData()



                }

            }

//            self.uploadCompleteData()


        } //: FETCH PENDING ORDER & DETAILS
    }

    // NEED TO FIX
    func updateAddDict(completion: @escaping([OrderItem: [Add]]) -> Void){

        var tempDict = [OrderItem : [Add]]()

        for item in self.orderItems{

            // Fetch add options for each item
            self.fetchOrderItemAddOptions(orderID: self.pendingOrders[0].id ?? "", itemID: item.id ?? "") { addOptions in

                // Add to addOptions dictionary
                tempDict[item] = addOptions
            }
        }

        completion(tempDict)
    }

    // NEED TO FIX
    func uploadCompleteData(){

        // Gets the current users uid so we can reference it
        guard let userUID = Auth.auth().currentUser?.uid else {return}

        // Create a reference to the database
        let db = Firestore.firestore()


        // Add a document to user's values collection
        let ordersDocRef = db.collection("users").document(userUID).collection("completed_orders").addDocument(data: ["shop_id": pendingOrders[0].shop_id, "total_items": pendingOrders[0].total_items, "user_who_ordered": pendingOrders[0].user_who_ordered, "pending": false, "date_ordered": pendingOrders[0].date_ordered]) { error in

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


        let totalItems = orderItems.count

        print("Total order items: \(totalItems)")

        for i in 0..<(totalItems) {

            var item = orderItems[i]

            // Store the array of required objects for the cart item
            let itemRequiredOptions = orderRequiredOptions[item, default: []]
            print("Required Dict Count: \(itemRequiredOptions.count)")

            // Store the array of modified objects for the cart item
            let itemModificationOptions = orderModificationOptions[item, default: []]
            print("Modification Dict Count: \(itemModificationOptions.count)")

            // Store the array of addOn objects for the cart item
            let itemAddOnOptions = orderAddOptions[item, default: []]
            print("Add Dict Count: \(itemAddOnOptions.count)")



            // Add a document to user's values collection
            let itemDocRef = db.collection("users").document(userUID).collection("completed_orders").document(ordersDocRef.documentID).collection("order_items").addDocument(data: ["name": item.name, "order_id": ordersDocRef.documentID]) { error in

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
                db.collection("users").document(userUID).collection("completed_orders").document(ordersDocRef.documentID).collection("order_items").document(itemDocRef.documentID).collection("required").addDocument(data: ["option": each.option]) { error in

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
                db.collection("users").document(userUID).collection("completed_orders").document(ordersDocRef.documentID).collection("order_items").document(itemDocRef.documentID).collection("add").addDocument(data: ["option": each.option, "price": each.price]) { error in

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
                db.collection("users").document(userUID).collection("completed_orders").document(ordersDocRef.documentID).collection("order_items").document(itemDocRef.documentID).collection("modifications").addDocument(data: ["option": each.option]) { error in

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

    }

    func fetchOrderItems(orderID: String, completion: @escaping([OrderItem]) -> Void){

        // Gets the current users uid so we can reference it
        guard let userUID = Auth.auth().currentUser?.uid else {return}

        Firestore.firestore().collection("users").document(userUID).collection("pending_orders").document(orderID).collection("order_items").addSnapshotListener { (querySnapshot, error) in

            guard let documents = querySnapshot?.documents else {
                print("No documents in this collection.")
                return

            }

            let orderItems = documents.compactMap({ try? $0.data(as: OrderItem.self) })

            completion(orderItems)

        }

    }

    func fetchOrderItemAddOptions(orderID: String, itemID: String, completion: @escaping([Add]) -> Void){

        // Gets the current users uid so we can reference it
        guard let userUID = Auth.auth().currentUser?.uid else {return}

        Firestore.firestore().collection("users").document(userUID).collection("pending_orders").document(orderID).collection("order_items").document(itemID).collection("add").addSnapshotListener { (querySnapshot, error) in

            guard let documents = querySnapshot?.documents else {
                print("No documents in this collection.")
                return

            }

            let itemAddOptions = documents.compactMap({ try? $0.data(as: Add.self) })

            completion(itemAddOptions)

        }

    }

    func fetchOrderItemModificationOptions(orderID: String, itemID: String, completion: @escaping([Modification]) -> Void){


        // Gets the current users uid so we can reference it
        guard let userUID = Auth.auth().currentUser?.uid else {return}

        Firestore.firestore().collection("users").document(userUID).collection("pending_orders").document(orderID).collection("order_items").document(itemID).collection("modifications").addSnapshotListener { (querySnapshot, error) in

            guard let documents = querySnapshot?.documents else {
                print("No documents in this collection.")
                return

            }

            let itemModificationOptions = documents.compactMap({ try? $0.data(as: Modification.self) })

            completion(itemModificationOptions)

        }

    }

    func fetchOrderItemRequiredOptions(orderID: String, itemID: String, completion: @escaping([Required]) -> Void){

        // Gets the current users uid so we can reference it
        guard let userUID = Auth.auth().currentUser?.uid else {return}

        Firestore.firestore().collection("users").document(userUID).collection("pending_orders").document(orderID).collection("order_items").document(itemID).collection("required").addSnapshotListener { (querySnapshot, error) in

            guard let documents = querySnapshot?.documents else {
                print("No documents in this collection.")
                return

            }

            let itemRequiredOptions = documents.compactMap({ try? $0.data(as: Required.self) })

            completion(itemRequiredOptions)

        }

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
