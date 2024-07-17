//
//  Order.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 16.07.24.
//

import Foundation

struct Order: Identifiable, Codable {
    let id: String
    var car: Car
    var assistant: CarAssistant
    var visualDamage: Bool
    var problemDescription: String
    var city: String
    var address: String
    var date: String
    var time: String
}
