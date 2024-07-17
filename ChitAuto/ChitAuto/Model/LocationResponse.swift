//
//  LocationResponse.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 17.07.24.
//

import Foundation

struct LocationResponse: Decodable {
    let cityId: Int
    let localizedValue: String
}
