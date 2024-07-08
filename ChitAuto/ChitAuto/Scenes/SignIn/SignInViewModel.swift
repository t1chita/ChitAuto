//
//  SignInViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 06.07.24.
//

import Foundation
import Firebase

final class SignInViewModel: ObservableObject {
    //    MARK: - Static Properties
    let mailLabel: String = "მეილი"
    let passwordLabel: String = "პაროლი"
    
    //    MARK: - Properties
    @Published var mail: String = ""
    @Published var password: String = ""
    
    //    MARK: - LifeCycles
    
    //    MARK: - Methods
    func singIn() async throws {
        do {
            try await Auth.auth().signIn(withEmail: mail, password: password)
        } catch {
            print("DEBUG: Failed To Log In With Error \(error.localizedDescription)")
        }
    }
    //    MARK: - Requests
    
    //    MARK: - Navigation
}
