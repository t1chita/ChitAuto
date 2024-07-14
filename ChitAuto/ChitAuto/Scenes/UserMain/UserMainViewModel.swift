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
    
    var userHasCars: Bool {
        currentUser.userCars.isEmpty
    }
    
    //MARK: - Initialization
    init(currentUser: User) {
        self.currentUser = currentUser
    }
    
    //MARK: - Child Method
    
    //MARK: - Requests
    
    //MARK: - Navigation

}
