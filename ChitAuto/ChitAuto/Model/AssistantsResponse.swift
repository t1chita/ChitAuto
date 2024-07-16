//
//  AssistantsResponse.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 16.07.24.
//

import Foundation

struct CarAssistant: Decodable {
    let assistantId: Int
    let assistantLevel: String
    let assistantServiceFee: Int
    let carBrands: [AssistantsCarBrand]
    let fullName: String
    let numberOfRepairedVehicles: Int
    let profilePicUrl: String
    let rating: Double
}

struct AssistantsCarBrand: Codable {
    let id: Int
    let imageUrl: String
}
