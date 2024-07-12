//
//  SignUpViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 03.07.24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

@MainActor
final class SignUpViewModel: ObservableObject {
    //MARK: - Static Properties
    let firstNameLabel: String = "სახელი"
    let lastNameLabel: String = "გვარი"
    let phoneNumberLabel: String = "ნომერი"
    let personalNoLabel: String = "პირადი ნომერი"
    let mailLabel: String = "მეილი"
    let passwordLabel: String = "პაროლი"
    
    //MARK: - Properties
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var phoneNumber: String = ""
    @Published var personalNo: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    //MARK: - Methods
    func createUser() async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            let user = User(id: result.user.uid, firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber, personalNo: personalNo, userCars: [])
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
        } catch {
            print("Debug: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    //MARK: - Requests
    
    //MARK: - Navigation
}


//MARK: - Validation
extension SignUpViewModel: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !firstName.isEmpty
        && !lastName.isEmpty
        && !phoneNumber.isEmpty
        && !personalNo.isEmpty
        && personalNo.count == 11
        && !password.isEmpty
        && password.count > 5
    }
}
