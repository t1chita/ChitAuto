//
//  UserMainViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 08.07.24.
//

import Foundation

protocol AddCarInTheGarageDelegate: AnyObject {
    func addCarInTheGarageDelegate()
}

final class UserMainViewModel {
    //MARK: - Properties
    let addCarInTheGarage: String = "დაამატე მანქანა გარაჟში"
    let garage: String = "გარაჟი"
    let callAnAssistant: String = "გამოძახება"
    let currentUser: User
 
    //MARK: - Initialization
    init(currentUser: User) {
        self.currentUser = currentUser
    }
    
    //MARK: - Child Method
    
    //MARK: - Requests
    
    //MARK: - Navigation

}

extension UserMainViewModel: AddCarInTheGarageDelegate {
    func addCarInTheGarageDelegate() {
        //TODO: Add Logic
    }
}
