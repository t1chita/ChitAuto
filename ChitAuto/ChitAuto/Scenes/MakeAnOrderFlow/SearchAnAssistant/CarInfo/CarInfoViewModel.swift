//
//  CarInfoViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 14.07.24.
//

import Foundation

final class CarInfoViewModel {
    var currentCar: Car
    
    var currentOrder: Order? {
        didSet { onCurrentOrderChanged?(currentOrder!)}
    }
    
    var onCurrentOrderChanged: ((Order) -> Void)?
    
    init(currentCar: Car) {
        self.currentCar = currentCar
        createOrder()
    }
    
    var validateCarInfoPage: Bool {
        guard let order = currentOrder else { return false }
        return !order.problemDescription.isEmpty
    }
    
    private func createOrder() {
        let assistant = CarAssistant(assistantId: 0,
                                     assistantLevel: "",
                                     assistantServiceFee: 0,
                                     carBrands: [],
                                     fullName: "",
                                     numberOfRepairedVehicles: 0,
                                     profilePicUrl: "",
                                     rating: 0)
        
        currentOrder = Order(id: UUID().uuidString,
                             car: currentCar,
                             assistant: assistant,
                             visualDamage: false,
                             problemDescription: "",
                             city: "",
                             address: "",
                             date: "",
                             time: "")
    }
    
}
