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
    let mailLabel: String = "მეილი"
    let passwordLabel: String = "პაროლი"
    
    //MARK: - Properties
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    //MARK: - Methods
    func createUser() async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            let user = User(id: result.user.uid, firstName: firstName, lastName: lastName, email: email, phoneNumber: "", personalNo: "", imageUrl: "", userCars: [], userOrders: [])
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
        } catch {
            print("Debug: Failed to create user with error \(error.localizedDescription)")
        }
    }
}


//MARK: - Validation
extension SignUpViewModel {
    var emailIsValid: Bool {
        return !email.isEmpty && email.contains("@")
    }
    
    var nameIsValid: Bool {
        return !firstName.isEmpty
    }
    
    var lastNameIsValid: Bool {
        return !lastName.isEmpty
    }
    
    var passwordIsValid: Bool {
        return !password.isEmpty && password.count >= 8
    }
    
    var formIsValid: Bool {
        return emailIsValid && nameIsValid && passwordIsValid && lastNameIsValid
    }
}
