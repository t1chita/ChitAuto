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
    //MARK: - Properties
    var imageIsSaved = false
    
    var email: String = ""
    
    var phoneNumber: String = ""
    
    var imageData: Data?
    
    var uploadInProgress: Bool = false
    
    var enableToEditInfo: Bool = false

    //MARK: - Computed Properties
    var currentUser: User {
        didSet { onUserProfilePictureChanged?(currentUser) }
    }
    
    //MARK: - Closures
    var onUserProfilePictureChanged: ((User) -> Void)?
    
    init(currentUser: User) {
        self.currentUser = currentUser
    }
    
    //MARK: - Firebase Methods
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
    
    func updateEmailAndPhoneNumber() {
        let db = Firestore.firestore()
        let updateData: [String: Any] = [
               "phoneNumber": phoneNumber,
               "email": email
           ]
           
        db.collection("users").document(currentUser.id).updateData(updateData) { [weak self] error in
            if let error = error {
                print("Failed to save data: \(error.localizedDescription)")
                return
            }
            self?.currentUser.phoneNumber = self?.phoneNumber ?? ""
            self?.currentUser.email = self?.email ?? ""
        }
    }
}

