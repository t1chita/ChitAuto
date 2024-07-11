//
//  AddCarDetailsViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 09.07.24.
//

import Foundation
import Network

final class AddCarDetailsViewModel {
    var carBrandId: Int?
    
    var carModelId: Int?
    
    var carBrandName: String = "მწარმოებელი" {
        didSet { carBrandNameChanged?(carBrandName) }
    }
    
    var carModelName: String = "მოდელი" {
        didSet { carModelNameChanged?(carModelName) }
    }
    
    var carReleaseDate: String = "გამოშვების წელი" {
        didSet { carReleaseDateChanged?(carReleaseDate) }
    }
    
    var carFuelType: String = "საწვავის ტიპი" {
        didSet { carFuelTypeChanged?(carFuelType) }
    }
    
    var carTransmissionType: String = "გადაცემათა კოლოფი" {
        didSet { carTransmissionTypeChanged?(carTransmissionType) }
    }
    
    var carBrandNameChanged: ((String) -> Void)?
    
    var carModelNameChanged: ((String) -> Void)?
    
    var carReleaseDateChanged: ((String) -> Void)?
    
    var carFuelTypeChanged: ((String) -> Void)?
    
    var carTransmissionTypeChanged: ((String) -> Void)?
}

