//
//  SignUpViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 03.07.24.
//

import Foundation

final class SignUpViewModel: ObservableObject {
    //    MARK: - Static Properties
    let firstNameLabel: String = "სახელი"
    let lastNameLabel: String = "გვარი"
    let phoneNumberLabel: String = "ნომერი"
    let personalNoLabel: String = "პირადი ნომერი"
    let mailLabel: String = "მეილი"
    let passwordLabel: String = "პაროლი"
    
    //    MARK: - Properties
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var phoneNumber: String = ""
    @Published var personalNo: String = ""
    @Published var mail: String = ""
    @Published var password: String = ""
    
    //    MARK: - LifeCycles
    
    //    MARK: - Child Method
    
    //    MARK: - Requests
    
    //    MARK: - Navigation

}
