//
//  CurrentOrderViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 18.07.24.
//

import Foundation
import FirebaseFirestore

final class CurrentOrderViewModel {
    //MARK: - Properties
    let userID: String
    
    let orderToRemove: Order
    
    //MARK: - Computed Properties
    var visualDamage: String {
        if orderToRemove.visualDamage {
            return "აქვს"
        } else {
            return "არ აქვს"
        }
    } 
    
    var time: String {
        switch orderToRemove.time {
        case "დილით":
            return "დილა"
        case "საღამოს":
            return "საღამო"
        case "შუადღეს":
            return "შუადღე"
        default:
            return ""
        }
    }
    
    //MARK: - Closures
    var onOrderRemoved: (() -> Void)?
    var onOrderCompleted: (() -> Void)?
    
    //MARK: - Initialization
    init(userID: String, orderToRemove: Order) {
        self.userID = userID
        self.orderToRemove = orderToRemove
    }
    
    //MARK: - Child MEthods
    func removeOrderWhenItsDone(completion: @escaping (Bool) -> Void) {
        saveOrderDetails { [weak self] success in
            guard let self = self else { return }
            if success {
                self.onOrderCompleted?()
                self.removeOrderFromUser(completion: completion)
            } else {
                print("DEBUG: Can't Save Order History")
                completion(false)
            }
        }
    }
    
    //MARK: - Firebase Methods
    func removeOrderFromUser(completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userID)
        userRef.getDocument { [weak self] (document, error) in
            guard let self = self else { return }
            if let document = document, document.exists {
                if var userOrders = document.data()?["userOrders"] as? [[String: Any]] {
                    userOrders.removeAll { $0["id"] as? String == self.orderToRemove.id }
                    
                    userRef.updateData([
                        "userOrders": userOrders
                    ]) { error in
                        if let error = error {
                            print("Error updating document: \(error)")
                            completion(false)
                        } else {
                            print("Document successfully updated!")
                            self.onOrderRemoved?()
                            completion(true)
                        }
                    }
                }
            } else {
                print("Document does not exist")
                completion(false)
            }
        }
    }
    
    private func saveOrderDetails(completion: @escaping (Bool) -> Void) {
        let carData: [String: Any] = [
            "id": orderToRemove.id,
            "car": orderToRemove.car.convertCarToDictionary(),
            "assistant": orderToRemove.assistant.convertAssistantToDictionary(),
            "visualDamage": orderToRemove.visualDamage,
            "problemDescription": orderToRemove.problemDescription,
            "city": orderToRemove.city,
            "address": orderToRemove.address,
            "date": orderToRemove.date,
            "time": orderToRemove.time,
        ]
        
        let db = Firestore.firestore()
        db.collection("users").document(userID).updateData([
            "userOrdersHistory": FieldValue.arrayUnion([carData])
        ]) { error in
            if let error = error {
                print("Error saving order details: \(error)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
}
