//
//  CarInfoViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 14.07.24.
//

import Foundation

final class CarInfoViewModel {
    //MARK: - Properties
    var currentCar: Car
    
    let userId: String
    
    //MARK: - Computed Properties
    var currentOrder: Order? {
        didSet { onCurrentOrderChanged?(currentOrder!)}
    }
    
    var validateCarInfoPage: Bool {
        guard let order = currentOrder else { return false }
        return !order.problemDescription.isEmpty
    }
    
    //MARK: - Closures
    var onCurrentOrderChanged: ((Order) -> Void)?
    
    //MARK: - Initialization
    init(currentCar: Car, userId: String) {
        self.currentCar = currentCar
        self.userId = userId
        createOrder()
    }
    
    //MARK: - Child Methods
    private func createOrder() {
        let assistant = CarAssistant(assistantId: 0, assistantLevel: "", assistantServiceFee: 0, carBrands: [], fullName: "", numberOfRepairedVehicles: 0, profilePicUrl: "", rating: 0)
        
        currentOrder = Order(id: UUID().uuidString, car: currentCar, assistant: assistant,visualDamage: false, problemDescription: "", city: "", address: "", date: "", time: "")
    }
    
}
