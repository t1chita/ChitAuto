//
//  CountryResponse.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 21.07.24.
//

import Foundation


struct CountryResponse: Identifiable, Decodable {
    let id: String
    let name: String
    let flag: String
    let code: String
    let dialCode: String
    let pattern: String
    let limit: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case flag
        case code
        case dialCode = "dial_code"
        case pattern
        case limit
    }
}
