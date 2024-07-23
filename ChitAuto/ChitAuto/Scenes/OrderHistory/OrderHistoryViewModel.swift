//
//  OrderHistoryViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 22.07.24.
//

import Foundation


final class OrderHistoryViewModel {
    //MARK: - Properties
    let usersOrderHistory: [Order]
    
    //MARK: - Computed Properties
    var usersOrderHistoryCount: Int {
        usersOrderHistory.count
    }
    
    //MARK: - Initialization
    init(usersOrderHistory: [Order]) {
        self.usersOrderHistory = usersOrderHistory
    }
}
