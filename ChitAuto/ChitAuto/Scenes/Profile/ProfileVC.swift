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
    //MARK: - Properties
    private var profileView: ProfileView
    private var profileViewModel: ProfileViewModel
        
    //MARK: - Initialization
    init(profileView: ProfileView, profileViewModel: ProfileViewModel) {
        self.profileView = profileView
        self.profileViewModel = profileViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view = profileView
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleDelegates()
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if profileViewModel.uploadInProgress {
            AlertManager.showCanNotUpdateProfilePicture(on: self)
        }
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        setEmailTextFieldWithData()
        setUserFullName()
        setUsersProfilePic()
        setNumberTextFieldWithData()
        setNavigationItems()
    }
    
    //MARK: - Delegates
    private func handleDelegates() {
        getDelegatesFromView()
    }
    
    private func getDelegatesFromView() {
        profileView.photoSelectionDelegate = self
        profileView.popViewControllerDelegate = self
    }
    
    //MARK: - Set UI Components
    private func updateUI() {
        if profileViewModel.imageIsSaved {
            profileView.imageShouldSave()
        } else {
            profileView.imageSaved()
        }
    }
    
    private func setEmailTextFieldWithData() {
        profileView.emailTextField.textFieldText = profileViewModel.currentUser.email
    }
    
    private func setNumberTextFieldWithData() {
        profileView.phoneNumber.textFieldText = profileViewModel.currentUser.phoneNumber
    }
    
    private func setUserFullName() {
        profileView.userName.text = "\(profileViewModel.currentUser.firstName) \(profileViewModel.currentUser.lastName)"
    }
    
    private func setUsersProfilePic() {
        if profileViewModel.currentUser.imageUrl != "" {
            guard let imageUrl = URL(string: profileViewModel.currentUser.imageUrl) else { return }
            profileView.profileImage.loadImage(from: imageUrl)
        } else {
            profileView.profileImage.image = UIImage(systemName: "person.circle.fill")
        }
    }
    
    private func setNavigationItems() {
        navigationItem.leftBarButtonItem = profileView.mainButton
        title = "პროფილი"
    }
}

extension ProfileVC: PopViewControllerDelegate {
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - Image Selection
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
                
        profileViewModel.uploadProfileImage { [weak self] success in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.updateUI()
                
                if !success {
                    print("Failed to upload and save profile image.")
                }
            }
        }
    }
}
