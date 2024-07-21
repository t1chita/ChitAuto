//
//  User.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 07.07.24.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let phoneNumber: String
    let personalNo: String
    var imageUrl: String
    var userCars: [Car]
    var userOrders: [Order]
}
