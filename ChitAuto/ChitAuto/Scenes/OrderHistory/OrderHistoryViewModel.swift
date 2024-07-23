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
    
    var usersOrderHistoryCount: Int {
        usersOrderHistory.count
    }
    //MARK: - Initialization
    init(usersOrderHistory: [Order]) {
        self.usersOrderHistory = usersOrderHistory
    }
    
    //MARK: - Child Method
    
    //MARK: - Requests
    
    //MARK: - Navigation

}
