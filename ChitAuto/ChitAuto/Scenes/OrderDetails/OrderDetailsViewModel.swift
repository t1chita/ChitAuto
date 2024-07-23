//
//  OrderDetailsViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 23.07.24.
//

import Foundation

final class OrderDetailsViewModel {
    //MARK: - Properties
    let order: Order
    
    //MARK: - Computed Properties
    var visualDamage: String {
        if order.visualDamage {
            return "აქვს"
        } else {
            return "არ აქვს"
        }
    }
    
    var time: String {
        switch order.time {
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
    
    //MARK: - Initialization
    init(order: Order) {
        self.order = order
    }
}
