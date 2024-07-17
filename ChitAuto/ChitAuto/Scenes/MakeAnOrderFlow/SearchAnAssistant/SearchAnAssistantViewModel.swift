//
//  SearchAnAssistantViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 15.07.24.
//

import Foundation
import Network
import Firebase

enum AssistantsLevel: String, CaseIterable {
      case senior = "ექსპერტი"
      case middle = "გამოცდილი"
      case beginner = "დამწყები"
}

final class SearchAnAssistantViewModel {
    //    MARK: - Properties
    private let assistantsApi = "https://chitauto-default-rtdb.europe-west1.firebasedatabase.app/assistants.json"
    private(set) var assistantLevel: AssistantsLevel = .senior
    
    var currentOrder: Order {
        didSet { onChangedCurrentOrder?(currentOrder)}
    }
    
    let userId: String
    
    var assistantsCount: Int {
        filteredAssistants.count
    }
    
    var assistants: [CarAssistant] = []
    
    var filteredAssistants: [CarAssistant] {
        assistants.filter { $0.assistantLevel == assistantLevel.rawValue }
    }
    
    var selectedAssistant: CarAssistant?
    
    var lastSelectedIndexPath: IndexPath?
    
    var onChangedCurrentOrder: ((Order) -> Void)?
    
    init(order: Order, userId: String) {
        self.currentOrder = order
        self.userId = userId
        fetchAssistants()
    }
    
    weak var reloadDelegate: ReloadDelegate?
    
    func updateAssistantLevel(to level: AssistantsLevel) {
        assistantLevel = level
        reloadDelegate?.reloadData()
    }
    
    //    MARK: - Requests
    private func fetchAssistants() {
        NetworkService.networkService.getData(urlString: assistantsApi) { [weak self] (result: Result<[CarAssistant], Error >) in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let carAssistants):
                    self?.assistants = carAssistants
                case .failure(let error):
                    print("DEBUG: Can't Fetch Assistants \(error.localizedDescription)")
                }
                self?.reloadDelegate?.reloadData()
            }
        }
    }
    
    
    // MARK: - Helper Functions
    private func convertCarToDictionary(car: Car) -> [String: Any] {
        return [
            "id": car.id,
            "carBrandName": car.carBrandName,
            "carBrandImageUrl": car.carBrandImageUrl,
            "carModelName": car.carModelName,
            "fuelType": car.fuelType,
            "releaseDate": car.releaseDate,
            "transmissionType": car.transmissionType,
            "plateNumber": car.plateNumber
        ]
    }

    private func convertAssistantToDictionary(assistant: CarAssistant) -> [String: Any] {
        return [
            "assistantId": assistant.assistantId,
            "assistantLevel": assistant.assistantLevel,
            "assistantServiceFee": assistant.assistantServiceFee,
            "carBrands": assistant.carBrands.map { convertCarBrandToDictionary(carBrand: $0) },
            "fullName": assistant.fullName,
            "numberOfRepairedVehicles": assistant.numberOfRepairedVehicles,
            "profilePicUrl": assistant.profilePicUrl,
            "rating": assistant.rating
        ]
    }

    private func convertCarBrandToDictionary(carBrand: AssistantsCarBrand) -> [String: Any] {
        return [
            "id": carBrand.id,
            "imageUrl": carBrand.imageUrl
        ]
    }

    // MARK: - Save Order Details
    func saveOrderDetails(completion: @escaping (Error?) -> Void) {
        let carData: [String: Any] = [
            "id": currentOrder.id,
            "car": convertCarToDictionary(car: currentOrder.car),
            "assistant": convertAssistantToDictionary(assistant: currentOrder.assistant),
            "visualDamage": currentOrder.visualDamage,
            "problemDescription": currentOrder.problemDescription,
            "city": currentOrder.city,
            "address": currentOrder.address,
            "date": currentOrder.date,
            "time": currentOrder.time,
        ]
        
        let db = Firestore.firestore()
        db.collection("users").document(userId).updateData([
            "userOrders": FieldValue.arrayUnion([carData])
        ]) { error in
            completion(error)
        }
    }
}
