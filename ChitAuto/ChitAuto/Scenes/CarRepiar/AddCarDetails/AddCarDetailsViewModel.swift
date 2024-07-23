//
//  AddCarDetailsViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 09.07.24.
//

import FirebaseFirestore
import Foundation

final class AddCarDetailsViewModel {
    //MARK: - Properties
    var carBrand: CarBrand?
    
    var carPlateNumber: String = ""
    
    var userId: String
    
    //MARK: - Computed Properties
    var userCar: Car? {
        didSet { onSelectedCarChanged?(userCar!) }
    }
    
    var carBrandName: String = "მწარმოებელი" {
        didSet { onCarBrandChanged?(carBrandName) }
    }
    
    var carModelName: String = "მოდელი" {
        didSet { onCarModelChanged?(carModelName) }
    }
    
    var carReleaseDate: String = "გამოშვების წელი" {
        didSet { onCarReleaseDateChanged?(carReleaseDate) }
    }
    
    var carFuelType: String = "საწვავის ტიპი" {
        didSet { onCarFuelTypeChanged?(carFuelType) }
    }
    
    var carTransmissionType: String = "გადაცემათა კოლოფი" {
        didSet { onCarTransmissionTypeChanged?(carTransmissionType) }
    }
    
    init(userId: String) {
        self.userId = userId
    }

    //MARK: - Closures
    var onCarBrandChanged: ((String) -> Void)?
    
    var onCarModelChanged: ((String) -> Void)?
    
    var onCarReleaseDateChanged: ((String) -> Void)?
    
    var onCarFuelTypeChanged: ((String) -> Void)?
    
    var onCarTransmissionTypeChanged: ((String) -> Void)?
    
    var onSelectedCarChanged: ((Car) -> Void)?
    
    //MARK: - Firebase Methods
    func saveCarDetails() {
        guard let carBrand = carBrand else { return }
        
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
        ])
    }
}

//MARK: - Validation
extension AddCarDetailsViewModel {
    private var isBrandValid: Bool {
        carBrandName != "მწარმოებელი"
    }
    
    private var isModelValid: Bool {
        carModelName != "მოდელი"
    }

    private var isReleaseDateValid: Bool {
        carReleaseDate != "გამოშვების წელი"
    }
    
    private var isFuelTypeValid: Bool {
        carFuelType != "საწვავის ტიპი"
    }
    
    private var isTransmissionTypeValid: Bool {
        carTransmissionType != "გადაცემათა კოლოფი"
    }
    
    private var isNumberPlateValid: Bool {
        carPlateNumber != "" && carPlateNumber.count == 9
    }
    
    var isAddCarDetailsValid: Bool {
        return isBrandValid
        && isModelValid 
        && isReleaseDateValid
        && isFuelTypeValid
        && isTransmissionTypeValid
        && isNumberPlateValid
    }
}
