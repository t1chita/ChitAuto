//
//  ProfileView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 20.07.24.
//

import UIKit

final class ProfileView: UIView {
    let profileImage: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.layer.masksToBounds = true
        imgView.layer.cornerRadius = 75
        imgView.image = UIImage(resource: .mainButton)
        return imgView
    }()
    
    let userName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 26, weight: .bold)
        lbl.textColor = .customLabel
        lbl.textAlignment = .center
        lbl.text = "Temur Chitashvili"
        return lbl
    }()
    
    let personalInformationStackView: UIStackView = {
        let stView = UIStackView()
        stView.translatesAutoresizingMaskIntoConstraints = false
        stView.axis = .horizontal
        stView.distribution = .equalCentering
        stView.alignment = .center
        return stView
    }()
    
    let selectPhotoButton: UIButton = {
        var configuration = UIButton.Configuration.borderless()
        configuration.title = "აირჩიე ფოტო"
        configuration.imagePlacement = .leading
        configuration.imagePadding = 2
        configuration.baseForegroundColor = .customLabel
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let personalInformationLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 18, weight: .bold)
        lbl.textColor = .customLabel
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.text = "პერსონალური\nინფორმაცია"
        return lbl
    }()
    
    let editPersonalInformationButton: UIButton = {
        var configuration = UIButton.Configuration.borderless()
        configuration.title = "შეცვლა"
        configuration.image = UIImage(systemName: "pencil.line")
        configuration.imagePlacement = .leading
        configuration.imagePadding = 2
        configuration.baseForegroundColor = .customLabel
        let button = UIButton(configuration: configuration)
        return button
    }()
    
    private let personalInfoCardBackground: UIView = {
       let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .customCard
        vw.layer.cornerRadius = 20
        return vw
    }()
    
    private let personalInfoStackView: UIStackView = {
        let stView = UIStackView()
        stView.translatesAutoresizingMaskIntoConstraints = false
        stView.axis = .vertical
        stView.alignment = .fill
        stView.distribution = .fillEqually
        return stView
    }()
    
    let nameTextField: PersonalInfoTextField = {
        let txtField = PersonalInfoTextField(textFieldTitle: "მეილი", textFieldIcon: "envelope.open.fill")
        txtField.textFieldText = "@gmail.com"
        return txtField
    }()
     
    let phoneNumber: PersonalInfoTextField = {
        let txtField = PersonalInfoTextField(textFieldTitle: "ტელეფონის ნომერი", textFieldIcon: "iphone")
        txtField.textFieldText = "+995597050897"
        return txtField
    }()
    
    let personalNo: PersonalInfoTextField = {
        let txtField = PersonalInfoTextField(textFieldTitle: "პ/ნ", textFieldIcon: "person.fill")
        txtField.textFieldText = "01411109648"
        return txtField
    }()
    
    weak var photoSelectionDelegate: PhotoSelectionDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        backgroundColor = .customBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setProfileImage()
        setUserName()
        setSelectPhotoButton()
        setPersonalInformationStackView()
        setPersonalInfoCardBackground()
        setPersonalInfoStackView()
    }
    
    private func setProfileImage() {
        addSubview(profileImage)
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            profileImage.heightAnchor.constraint(equalToConstant: 150),
            profileImage.widthAnchor.constraint(equalToConstant: 150),
            profileImage.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    private func setUserName() {
        addSubview(userName)
        
        NSLayoutConstraint.activate([
            userName.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
            userName.leadingAnchor.constraint(equalTo: leadingAnchor),
            userName.trailingAnchor.constraint(equalTo: trailingAnchor),
            userName.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
        
    private func setSelectPhotoButton() {
        addSubview(selectPhotoButton)
        
        selectPhotoButton.addAction(UIAction(title: "Present Image Picker", handler: {[weak self] _ in
            self?.photoSelectionDelegate?.selectPhoto()
        }), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            selectPhotoButton.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 10),
            selectPhotoButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            selectPhotoButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            selectPhotoButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func setPersonalInformationStackView() {
        addSubview(personalInformationStackView)
        
        personalInformationStackView.addArrangedSubview(personalInformationLabel)
        personalInformationStackView.addArrangedSubview(editPersonalInformationButton)
        
        editPersonalInformationButton.addAction(UIAction(title: "Handle Edit User Info", handler: {[weak self] _ in
            //TODO: Add Edit Logic
        }), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            personalInformationStackView.topAnchor.constraint(equalTo: selectPhotoButton.bottomAnchor, constant: 14),
            personalInformationStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            personalInformationStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            personalInformationStackView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setPersonalInfoCardBackground() {
        addSubview(personalInfoCardBackground)
        
        NSLayoutConstraint.activate([
            personalInfoCardBackground.topAnchor.constraint(equalTo: personalInformationStackView.bottomAnchor, constant: 20),
            personalInfoCardBackground.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            personalInfoCardBackground.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            personalInfoCardBackground.heightAnchor.constraint(equalToConstant: 270),
        ])
    }
    
    private func setPersonalInfoStackView() {
        personalInfoCardBackground.addSubview(personalInfoStackView)
        
        personalInfoStackView.addArrangedSubview(nameTextField)
        personalInfoStackView.addArrangedSubview(phoneNumber)
        personalInfoStackView.addArrangedSubview(personalNo)

        NSLayoutConstraint.activate([
            personalInfoStackView.topAnchor.constraint(equalTo: personalInfoCardBackground.topAnchor),
            personalInfoStackView.leadingAnchor.constraint(equalTo: personalInfoCardBackground.leadingAnchor, constant: 16),
            personalInfoStackView.trailingAnchor.constraint(equalTo: personalInfoCardBackground.trailingAnchor, constant: -16),
            personalInfoStackView.bottomAnchor.constraint(equalTo: personalInfoStackView.bottomAnchor, constant: -16),
        ])
    }
    
}
#Preview {
    ProfileVC(profileView: ProfileView(), profileViewModel: ProfileViewModel())
}
