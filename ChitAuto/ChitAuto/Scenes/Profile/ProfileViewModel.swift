//
//  ProfileViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 20.07.24.
//

import Foundation
import FirebaseStorage

final class ProfileViewModel {
    var imageIsSaved = false
    
    var imageData: Data?
    
    func uploadProfileImage() {
        
        // Crate storage reference
        let storageRef = Storage.storage().reference()
        
        // Check that we were able to convert image to data
        guard imageData != nil else { return }
        
        // Specify the file path and name
        let fileRef = storageRef.child("images/\(UUID().uuidString).jpg")
        
        // Upload that data
        let uploadTask = fileRef.putData(imageData!, metadata: nil) { metaData, error in
            

            if error == nil && metaData != nil {
                //TODO: Save a reference to the file in Firestore DB
            }
        }
    }
}
