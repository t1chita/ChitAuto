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
    //MARK: - Properties
    private(set) var assistantLevel: AssistantsLevel = .senior
    
    let userId: String
    
    var assistants: [CarAssistant] = []
    
    var selectedAssistant: CarAssistant?
    
    var lastSelectedIndexPath: IndexPath?
    
    //MARK: - Computed Properties
    var currentOrder: Order {
        didSet { onChangedCurrentOrder?(currentOrder)}
    }
    
    var assistantsCount: Int {
        filteredAssistants.count
    }
    
    var filteredAssistants: [CarAssistant] {
        assistants.filter { $0.assistantLevel == assistantLevel.rawValue }
    }
    
    //MARK: - Api Urls
    private let assistantsApi = "https://chitauto-default-rtdb.europe-west1.firebasedatabase.app/assistants.json"

    //MARK: - Closures
    var onChangedCurrentOrder: ((Order) -> Void)?
    
    //MARK: - Initialization
    init(order: Order, userId: String) {
        self.currentOrder = order
        self.userId = userId
        fetchAssistants()
    }
    
    //MARK: - Delegates
    weak var reloadDelegate: ReloadDelegate?
    
    //MARK: - Child Methods
    func updateAssistantLevel(to level: AssistantsLevel) {
        assistantLevel = level
        reloadDelegate?.reloadData()
    }
    
    //MARK: - Fetching Methods
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
    
    // MARK: - Firebase Methods
    func saveOrderDetails() {
        let carData: [String: Any] = [
            "id": currentOrder.id,
            "car": currentOrder.car.convertCarToDictionary(),
            "assistant": currentOrder.assistant.convertAssistantToDictionary(),
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
        ])
    }
}
