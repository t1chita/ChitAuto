//
//  CarRepairingViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 08.07.24.
//

import Foundation

final class CarRepairingViewModel {
    //MARK: - Properties
    let garage: String = "გარაჟი"
    
    let callAnAssistant: String = "გამოძახება"
    
    private var _currentUser: User
    
    private var _currentCar: Car?
    
    private let accessQueue = DispatchQueue(label: "com.chitauto.CarRepairingViewModel.accessQueue")

    //MARK: - Computed Properties
    var currentUser: User {
        get {
            accessQueue.sync { _currentUser }
        }
        set {
            accessQueue.sync { _currentUser = newValue }
            onSelectedUserChanged?(newValue)
        }
    }
    
    var currentCar: Car? {
        get {
            accessQueue.sync { _currentCar }
        }
        set {
            accessQueue.sync { _currentCar = newValue }
        }
    }
    
    var selectedOrder: Order? {
        accessQueue.sync {
            _currentUser.userOrders.first(where: { $0.car.id == _currentCar?.id })
        }
    }
    
    var userHasCars: Bool {
        accessQueue.sync {
            !_currentUser.userCars.isEmpty
        }
    }
    
    var currentCarHasOrder: Bool {
        accessQueue.sync {
            _currentUser.userOrders.contains(where: { $0.car.id == _currentCar?.id })
        }
    }
    
    //MARK: - Closures
    var onSelectedUserChanged: ((User) -> Void)?
    
    
    //MARK: - Initialization
    init(currentUser: User) {
        self._currentUser = currentUser
    }
}
