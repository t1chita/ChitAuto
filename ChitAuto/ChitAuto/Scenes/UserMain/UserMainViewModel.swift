//
//  UserMainViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 08.07.24.
//

import Foundation

final class UserMainViewModel {
    //MARK: - Properties
    let garage: String = "გარაჟი"
    let callAnAssistant: String = "გამოძახება"
    
    var currentUser: User {
        didSet { onSelectedUserChanged?(currentUser) }
    }
 
    var currentCar: Car?
    
    var onSelectedUserChanged: ((User) -> Void)?
    
    var selectedOrder: Order? {
        currentUser.userOrders.first(where: { $0.car.id == currentCar?.id })
    }
    
    var userHasCars: Bool {
        !currentUser.userCars.isEmpty
    }
    
    var currentCarHasOrder: Bool {
        currentUser.userOrders.contains(where: { $0.car.id == currentCar?.id })
    }
    
    //MARK: - Initialization
    init(currentUser: User) {
        self.currentUser = currentUser
    }
}
