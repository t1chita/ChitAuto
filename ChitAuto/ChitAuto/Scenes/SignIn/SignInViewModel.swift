//
//  SignInViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 06.07.24.
//

import Foundation

final class SignInViewModel: ObservableObject {
    //    MARK: - Static Properties
    let mailLabel: String = "მეილი"
    let passwordLabel: String = "პაროლი"
    
    //    MARK: - Properties
    @Published var mail: String = ""
    @Published var password: String = ""
    
    //    MARK: - LifeCycles
    
    //    MARK: - Methods
    func singIn(withEmail email: String, password: String) async throws {
        
    }
    //    MARK: - Requests
    
    //    MARK: - Navigation
}
