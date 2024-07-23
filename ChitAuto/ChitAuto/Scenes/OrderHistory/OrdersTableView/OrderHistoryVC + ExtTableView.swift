//
//  OrderHistoryVC + ExtTableView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 23.07.24.
//

import UIKit

extension OrderHistoryVC: UITableViewDelegate {
    
}

extension OrderHistoryVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orderHistoryViewModel.usersOrderHistoryCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrdersCell.identifier, for: indexPath) as! OrdersCell
        
        let assistantName = orderHistoryViewModel.usersOrderHistory[indexPath.row].assistant.fullName
        let assistantImage = orderHistoryViewModel.usersOrderHistory[indexPath.row].assistant.profilePicUrl
        
        cell.configure(withAssistantName: assistantName, imageUrl: assistantImage)
        return cell
    }
    
    
}
