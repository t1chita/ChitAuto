//
//  TransmissionTypesResponse.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 12.07.24.
//

import Foundation

struct TransmissionTypesResponse: Decodable {
    let transmissionTypeId: Int
    let localizedValue: String
}
