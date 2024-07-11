//
//  CarModelResponse.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 11.07.24.
//

import Foundation

struct CarModel: Codable {
    let id: Int
    let carBrandId: Int
    let title: String
    let order: Int
}

struct CarModelsResponse: Codable {
    let carModels: [CarModel]
}
