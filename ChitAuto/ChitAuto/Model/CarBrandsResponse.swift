//
//  CarBrandsResponse.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 10.07.24.
//

import Foundation

struct CarBrand: Decodable {
    let id: Int
    let imageUrl: String?
    let name: String
    let order: Int
}

struct CarBrandsResponse: Decodable {
    let carBrands: [CarBrand]
}

