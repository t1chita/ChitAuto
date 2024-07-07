//
//  User.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 07.07.24.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let phoneNumber: String
    let personalNo: String
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: firstName + lastName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
            
        return ""
    }
}
