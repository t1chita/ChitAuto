//
//  Car.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 12.07.24.
//

import Foundation

struct Car: Identifiable, Codable {
    let id: String
    let carBrandName: String
    let carBrandImageUrl: String
    let carModelName: String
    let fuelType: String
    let releaseDate: String
    let transmissionType: String
    let plateNumber: String
}
