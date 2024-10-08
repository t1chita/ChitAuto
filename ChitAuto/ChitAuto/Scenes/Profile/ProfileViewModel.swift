//
//  ProfileViewModel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 20.07.24.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore

final class ProfileViewModel {
    var imageIsSaved = false
    
    var imageData: Data?
    
    var currentUser: User {
        didSet { onUserProfilePictureChanged?(currentUser) }
    }
    
    var onUserProfilePictureChanged: ((User) -> Void)?
    var uploadInProgress: Bool = false
    
    init(currentUser: User) {
        self.currentUser = currentUser
    }
    
    func uploadProfileImage(completion: @escaping (Bool) -> Void) {
        uploadInProgress = true
        // Create storage reference
        let storageRef = Storage.storage().reference()
        
        // Check that we were able to convert image to data
        guard let imageData = imageData else {
            uploadInProgress = false
            completion(false)
            return
        }
        
        // Specify the file path and name
        let path = "images/\(currentUser.id).jpg"
        let fileRef = storageRef.child(path)
        
        // Upload the data
        fileRef.putData(imageData, metadata: nil) { [weak self] metaData, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Failed to upload image: \(error.localizedDescription)")
                self.uploadInProgress = false
                completion(false)
                return
            }
            
            // Get download URL
            fileRef.downloadURL { (url, error) in
                if let error = error {
                    print("Failed to retrieve download URL: \(error.localizedDescription)")
                    self.uploadInProgress = false
                    completion(false)
                    return
                }
                
                guard let url = url else {
                    self.uploadInProgress = false
                    completion(false)
                    return
                }
                
                // Save download URL to Firestore
                let db = Firestore.firestore()
                db.collection("users").document(self.currentUser.id).updateData(["imageUrl": url.absoluteString]) { error in
                    if let error = error {
                        print("Failed to save image URL: \(error.localizedDescription)")
                        self.uploadInProgress = false
                        completion(false)
                        return
                    }
                    
                    self.currentUser.imageUrl = url.absoluteString
                    self.uploadInProgress = false
                    completion(true)
                }
            }
        }
    }
}

