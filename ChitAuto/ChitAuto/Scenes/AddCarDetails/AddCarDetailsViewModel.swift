//
//  AddCarDetailsViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 09.07.24.
//

import FirebaseFirestore
import Foundation
import Network

final class AddCarDetailsViewModel {
    var carBrand: CarBrand?
    
    var userId: String
    
    var userCar: Car? {
        didSet { onSelectedCarChanged?(userCar!) }
    }
    
    init(userId: String) {
        self.userId = userId
    }
    
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
    
    var carPlateNumber: String = "" {
        didSet { carPlateNumberChanged?(carPlateNumber) }
    }
    
    var carBrandNameChanged: ((String) -> Void)?
    
    var carModelNameChanged: ((String) -> Void)?
    
    var carReleaseDateChanged: ((String) -> Void)?
    
    var carFuelTypeChanged: ((String) -> Void)?
    
    var carTransmissionTypeChanged: ((String) -> Void)?
    
    var carPlateNumberChanged: ((String) -> Void)?
    
    var onSelectedCarChanged: ((Car) -> Void)?
    
    func saveCarDetails(completion: @escaping (Error?) -> Void) {
        guard let carBrand = carBrand else {
            completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Car brand is missing"]))
            return
        }
        
        let car = Car(id: UUID().uuidString, carBrandName: carBrand.name, carBrandImageUrl: carBrand.imageUrl ?? "", carModelName: carModelName, fuelType: carFuelType, releaseDate: carReleaseDate, transmissionType: carTransmissionType, plateNumber: carPlateNumber)
        
        userCar = car
        
        let carData: [String: Any] = [
            "id": car.id,
            "carBrandName": car.carBrandName,
            "carBrandImageUrl": car.carBrandImageUrl,
            "carModelName": car.carModelName,
            "fuelType": car.fuelType,
            "releaseDate": car.releaseDate,
            "transmissionType": car.transmissionType,
            "plateNumber": car.plateNumber
        ]
        
        let db = Firestore.firestore()
        db.collection("users").document(userId).updateData([
            "userCars": FieldValue.arrayUnion([carData])
        ]) { error in
            completion(error)
        }
    }
}

