//
//  Models.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 22.07.24.
//

import Foundation

extension Car {
    func convertCarToDictionary() -> [String: Any] {
        return [
            "id": self.id,
            "carBrandName": self.carBrandName,
            "carBrandImageUrl": self.carBrandImageUrl,
            "carModelName": self.carModelName,
            "fuelType": self.fuelType,
            "releaseDate": self.releaseDate,
            "transmissionType": self.transmissionType,
            "plateNumber": self.plateNumber
        ]
    }
}

extension CarAssistant {
    func convertAssistantToDictionary() -> [String: Any] {
        return [
            "assistantId": self.assistantId,
            "assistantLevel": self.assistantLevel,
            "assistantServiceFee": self.assistantServiceFee,
            "carBrands": self.carBrands.map { $0.convertCarBrandToDictionary() },
            "fullName": self.fullName,
            "numberOfRepairedVehicles": self.numberOfRepairedVehicles,
            "profilePicUrl": self.profilePicUrl,
            "rating": self.rating
        ]
    }
}

extension AssistantsCarBrand {
    func convertCarBrandToDictionary() -> [String: Any] {
        return [
            "id": self.id,
            "imageUrl": self.imageUrl
        ]
    }
}
