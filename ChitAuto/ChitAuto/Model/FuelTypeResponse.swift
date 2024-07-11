//
//  FuelTypeResponse.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 12.07.24.
//

import Foundation

struct FuelTypeResponse: Decodable {
    let fuelTypeId: Int
    let localizedValue: String
}
