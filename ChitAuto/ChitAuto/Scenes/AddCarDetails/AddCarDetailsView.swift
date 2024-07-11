//
//  AddCarDetailsView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 09.07.24.
//

import UIKit

protocol SheetRepresentableDelegate: AnyObject {
    func presentBrandsSheet()
    func presentModelsSheet()
    func presentReleaseDateSheet()
    func presentFuelSheet()
    func presentTransmissionSheet()
}

final class AddCarDetailsView: UIView {
    //MARK: - UIComponents
    private let scrollView: UIScrollView = {
        let scrView = UIScrollView()
        scrView.translatesAutoresizingMaskIntoConstraints = false
        scrView.showsVerticalScrollIndicator = false
        return scrView
    }()
    
    private let contentView: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
    private let carInfoBackground: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.layer.cornerRadius = 20
        vw.backgroundColor = .customCard
        return vw
    }()
    
    private let carPlateTextField: UITextField = {
        let txtField = UITextField()
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.clipsToBounds = true
        txtField.layer.cornerRadius = 10
        txtField.layer.borderWidth = 1
        txtField.layer.borderColor = UIColor.black.cgColor
        txtField.placeholder = "XX-000-XX"
        txtField.textColor = .customLabel
        txtField.textAlignment = .center
        txtField.font = .systemFont(ofSize: 32, weight: .bold)
        txtField.backgroundColor = .customBackground
        txtField.setIcon(.carPlate)
        return txtField
    }()
    
    private let carInfoStackView: UIStackView = {
        let stView = UIStackView()
        stView.translatesAutoresizingMaskIntoConstraints = false
        stView.axis = .vertical
        stView.spacing = 8
        stView.alignment = .fill
        stView.distribution = .fillEqually
        return stView
    }()
    
    let carBrandButton: CarInfoButton = {
        let button = CarInfoButton()
        return button
    }()
    
    let carModelButton: CarInfoButton = {
        let button = CarInfoButton()
        return button
    }()
    
    let carReleaseDateButton: CarInfoButton = {
        let button = CarInfoButton()
        return button
    }()
    
    let carFuelTypeButton: CarInfoButton = {
        let button = CarInfoButton()
        return button
    }()
    
    let carTransmissionTypeButton: CarInfoButton = {
        let button = CarInfoButton()
        return button
    }()
    
    private let bottomButtonsStackView: UIStackView = {
        let stView = UIStackView()
        stView.translatesAutoresizingMaskIntoConstraints = false
        stView.axis = .horizontal
        stView.spacing = 60
        stView.distribution = .fillProportionally
        return stView
    }()
    
    private let saveButton: CustomGeneralButton = {
        let button = CustomGeneralButton()
        button.setTitle("შენახვა", for: .normal)
        button.backgroundColor = .customBackground
        return button
    }()
    
    private let backButton: BackButton = {
        let button = BackButton()
        return button
    }()
    
    //MARK: - Delegates
    weak var popViewControllerDelegate: PopViewControllerDelegate?
    weak var sheetRepresentableDelegate: SheetRepresentableDelegate?
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .customBackground
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        setScrollView()
        setContentView()
        
        setCarInfoBackground()
        
        setCarPlateTextField()
        setCarInfoStackView()
        setBottomButtonsStackView()
    }
    
    //MARK: - Set UI Components
    private func setScrollView() {
        addSubview(scrollView)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.centerYAnchor.constraint(equalTo: centerYAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func setContentView() {
        scrollView.addSubview(contentView)
        let heightAnchor = contentView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor)
        heightAnchor.priority = .defaultHigh
        
        //Set Constraints
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            heightAnchor
        ])
    }
    
    private func setCarInfoBackground() {
        contentView.addSubview(carInfoBackground)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            carInfoBackground.topAnchor.constraint(equalTo: contentView.topAnchor),
            carInfoBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            carInfoBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            carInfoBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    private func setCarPlateTextField() {
        carInfoBackground.addSubview(carPlateTextField)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            carPlateTextField.topAnchor.constraint(equalTo: carInfoBackground.topAnchor, constant: 16),
            carPlateTextField.leadingAnchor.constraint(equalTo: carInfoBackground.leadingAnchor, constant: 16),
            carPlateTextField.trailingAnchor.constraint(equalTo: carInfoBackground.trailingAnchor, constant: -16),
            carPlateTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setCarInfoStackView() {
        carInfoBackground.addSubview(carInfoStackView)
        
        carInfoStackView.addArrangedSubview(carBrandButton)
        carInfoStackView.addArrangedSubview(carModelButton)
        carInfoStackView.addArrangedSubview(carReleaseDateButton)
        carInfoStackView.addArrangedSubview(carFuelTypeButton)
        carInfoStackView.addArrangedSubview(carTransmissionTypeButton)
        
        carBrandButton.addAction(UIAction(title: "Present Brands Sheet", handler: { [weak self] _ in
            self?.sheetRepresentableDelegate?.presentBrandsSheet()
        }), for: .touchUpInside)
        
        carModelButton.addAction(UIAction(title: "Present Models Sheet", handler: { [weak self] _ in
            self?.sheetRepresentableDelegate?.presentModelsSheet()
        }), for: .touchUpInside)
        
        carReleaseDateButton.addAction(UIAction(title: "Present ReleaseDate Sheet", handler: { [weak self] _ in
            self?.sheetRepresentableDelegate?.presentReleaseDateSheet()
        }), for: .touchUpInside)
        
        carFuelTypeButton.addAction(UIAction(title: "Present FuelType Sheet", handler: { [weak self] _ in
            self?.sheetRepresentableDelegate?.presentFuelSheet()
        }), for: .touchUpInside)
        
        carTransmissionTypeButton.addAction(UIAction(title: "Present TransmissionType Sheet", handler: { [weak self] _ in
            self?.sheetRepresentableDelegate?.presentTransmissionSheet()
        }), for: .touchUpInside)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            carInfoStackView.topAnchor.constraint(equalTo: carPlateTextField.bottomAnchor, constant: 20),
            carInfoStackView.leadingAnchor.constraint(equalTo: carInfoBackground.leadingAnchor, constant: 24),
            carInfoStackView.trailingAnchor.constraint(equalTo: carInfoBackground.trailingAnchor, constant: -24),
        ])
    }
    
    private func setBottomButtonsStackView() {
        carInfoBackground.addSubview(bottomButtonsStackView)
        
        bottomButtonsStackView.addArrangedSubview(backButton)
        bottomButtonsStackView.addArrangedSubview(saveButton)
        
        backButton.addAction(UIAction(title: "Go To User Main Page", handler: { [weak self] _ in
            self?.popViewControllerDelegate?.popViewController()
        }), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            bottomButtonsStackView.topAnchor.constraint(equalTo: carInfoStackView.bottomAnchor, constant: 20),
            bottomButtonsStackView.leadingAnchor.constraint(equalTo: carInfoBackground.leadingAnchor, constant: 24),
            bottomButtonsStackView.trailingAnchor.constraint(equalTo: carInfoBackground.trailingAnchor, constant: -24),
            bottomButtonsStackView.heightAnchor.constraint(equalToConstant: 40),
            bottomButtonsStackView.bottomAnchor.constraint(equalTo: carInfoBackground.bottomAnchor, constant: -20),
        ])
    }
}

#Preview {
    AddCarDetailsVC(addCardDetailsView: AddCarDetailsView(), addCardDetailsViewModel: AddCarDetailsViewModel())
}
