//
//  SignUpViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 03.07.24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import Network

@MainActor
final class SignUpViewModel: ObservableObject {
    //MARK: - Static Properties
    let firstNameLabel: String = "სახელი"
    let lastNameLabel: String = "გვარი"
    let mailLabel: String = "მეილი"
    let passwordLabel: String = "პაროლი"
    let phoneNumberLabel: String = "მობილურის ნომერი"
    let countriesApi: String = "https://chitauto-default-rtdb.europe-west1.firebasedatabase.app/countries.json"
    var countries: [CountryResponse] = []
    
    //MARK: - Properties
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var phoneNumber: String = ""
    @Published var searchForCountry: String = ""
    @Published var countryPickerIsPresented: Bool = false
    @Published var countryFlag = "🇬🇪"
    @Published var countryDialCode = "+995"
    
    var filteredCountries: [CountryResponse] {
        if searchForCountry.isEmpty {
            return countries
        } else {
            return countries.filter({$0.name.contains(searchForCountry)})
        }
    }
    
    init() {
        fetchCountries()
    }
    
    //MARK: - Methods
    func createUser() async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            let user = User(id: result.user.uid, firstName: firstName, lastName: lastName, email: email, phoneNumber: countryDialCode + phoneNumber, imageUrl: "", userCars: [], userOrders: [])
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
        } catch {
            print("Debug: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func fetchCountries() {
        NetworkService.networkService.getData(urlString: countriesApi) { [weak self] (result: Result<[CountryResponse],Error>) in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let countryResponse):
                    self?.countries = countryResponse
                case .failure(let error):
                    print("DEBUG: Can't Fetch Countries \(error.localizedDescription)")
                }
            }
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
    
     var phoneNumberIsValid: Bool {
        return !phoneNumber.isEmpty
    }
    
    var formIsValid: Bool {
        return emailIsValid && nameIsValid && passwordIsValid && lastNameIsValid && phoneNumberIsValid
    }
}
