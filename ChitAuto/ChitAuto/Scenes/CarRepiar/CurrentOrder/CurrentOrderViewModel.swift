//
//  CurrentOrderViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 18.07.24.
//

import Foundation
import FirebaseFirestore

final class CurrentOrderViewModel {
    let userID: String
    let orderToRemove: String
    var onOrderRemoved: (() -> Void)?
    
    init(userID: String, orderToRemove: String) {
        self.userID = userID
        self.orderToRemove = orderToRemove
    }
    
    func removeOrderFromUser() {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userID)
        userRef.getDocument { [weak self] (document, error) in
            guard let self = self else { return }
            if let document = document, document.exists {
                if var userOrders = document.data()?["userOrders"] as? [[String: Any]] {
                    userOrders.removeAll { $0["id"] as? String == self.orderToRemove }
                    
                    userRef.updateData([
                        "userOrders": userOrders
                    ]) { error in
                        if let error = error {
                            print("Error updating document: \(error)")
                        } else {
                            print("Document successfully updated!")
                            self.onOrderRemoved?()
                        }
                    }
                }
            } else {
                print("Document does not exist")
            }
        }
    }
}
