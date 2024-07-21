//
//  ProfileVC.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 20.07.24.
//

import UIKit

protocol PhotoSelectionDelegate: AnyObject {
    func selectPhoto()
    func savePhoto()
}

final class ProfileVC: UIViewController {
    private var profileView: ProfileView
    private var profileViewModel: ProfileViewModel
    
    init(profileView: ProfileView, profileViewModel: ProfileViewModel) {
        self.profileView = profileView
        self.profileViewModel = profileViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view = profileView
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleDelegates()
    }
    
    private func handleDelegates() {
        getDelegatesFromView()
    }
    
    private func getDelegatesFromView() {
        profileView.photoSelectionDelegate = self
    }
    
    private func updateUI() {
        if profileViewModel.imageIsSaved {
            profileView.imageShouldSave()
        } else {
            profileView.imageSaved()
        }
    }
}

extension ProfileVC: PhotoSelectionDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            profileView.profileImage.image = image
        } else if let image = info[.originalImage] as? UIImage {
            profileView.profileImage.image = image
        }
        profileViewModel.imageIsSaved = true
        updateUI()
        dismiss(animated: true)
    }
    
    func selectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
    }
    
    func savePhoto() {
        profileViewModel.imageIsSaved = false
        profileViewModel.imageData = profileView.profileImage.image?.jpegData(compressionQuality: 0.8)
        updateUI()
        profileViewModel.uploadProfileImage()
    }
}
