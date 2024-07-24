//
//  CarInfoView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 14.07.24.
//

import UIKit

final class CarInfoView: UIView {
    //MARK: - UI Components
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
    
    let carPlateTextField: NumberPlateTextField = {
        let txtField = NumberPlateTextField()
        txtField.isUserInteractionEnabled = false
        return txtField
    }()
    
    private let visualDamageButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "ვიზუალური დაზიანება"
        configuration.image = UIImage(systemName: "plus.app")
        configuration.imagePlacement = .leading
        configuration.baseForegroundColor = .customLabel
        configuration.background.backgroundColor = .customBackground
        let button = UIButton(configuration: configuration)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 6
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let problemDescriptionTitle: GeneralLabel = {
        let lbl = GeneralLabel()
        lbl.text = "რა სჭირს მანქანას?"
        return lbl
    }()
    
    let problemDescriptionTextView: UITextView = {
        let txtView = UITextView()
        txtView.translatesAutoresizingMaskIntoConstraints = false
        txtView.backgroundColor = .customBackground
        txtView.layer.cornerRadius = 16
        return txtView
    }()
    
    let bottomButtonsStackView: BottomButtonsStackView = {
        let stView = BottomButtonsStackView()
        stView.saveButton.setTitle("შემდეგი", for: .normal)
        return stView
    }()
    
    //MARK: - Delegates
    weak var saveCarInfoDelegate: SaveCarInfoDelegate?
    
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
        setVisualDamageButton()
        setProblemDescriptionTitle()
        setProblemDescriptionTextView()
        setBottomButtonsStackView()
    }

    //MARK: - Set UI Components
    private func setScrollView() {
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func setContentView() {
        scrollView.addSubview(contentView)
        let heightAnchor = contentView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor)
        heightAnchor.priority = .defaultHigh
        
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
        
        NSLayoutConstraint.activate([
            carInfoBackground.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -100),
            carInfoBackground.heightAnchor.constraint(equalToConstant: 450),
            carInfoBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            carInfoBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
        ])
    }
    
    private func setCarPlateTextField() {
        carInfoBackground.addSubview(carPlateTextField)
        
        NSLayoutConstraint.activate([
            carPlateTextField.topAnchor.constraint(equalTo: carInfoBackground.topAnchor, constant: 16),
            carPlateTextField.leadingAnchor.constraint(equalTo: carInfoBackground.leadingAnchor, constant: 16),
            carPlateTextField.trailingAnchor.constraint(equalTo: carInfoBackground.trailingAnchor, constant: -16),
            carPlateTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setVisualDamageButton() {
        carInfoBackground.addSubview(visualDamageButton)
        
        visualDamageButton.addAction(UIAction(title: "Handle Saving Car Info", handler: { [weak self] _ in
            self?.saveCarInfoDelegate?.handleSavingCarInfo()
        }), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            visualDamageButton.topAnchor.constraint(equalTo: carPlateTextField.bottomAnchor, constant: 10),
            visualDamageButton.leadingAnchor.constraint(equalTo: carPlateTextField.leadingAnchor),
            visualDamageButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func setProblemDescriptionTitle() {
        carInfoBackground.addSubview(problemDescriptionTitle)
        
        NSLayoutConstraint.activate([
            problemDescriptionTitle.topAnchor.constraint(equalTo: visualDamageButton.bottomAnchor, constant: 4),
            problemDescriptionTitle.leadingAnchor.constraint(equalTo: visualDamageButton.leadingAnchor),
            problemDescriptionTitle.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func setProblemDescriptionTextView() {
        carInfoBackground.addSubview(problemDescriptionTextView)
        
        NSLayoutConstraint.activate([
            problemDescriptionTextView.topAnchor.constraint(equalTo: problemDescriptionTitle.bottomAnchor, constant: 10),
            problemDescriptionTextView.leadingAnchor.constraint(equalTo: carPlateTextField.leadingAnchor),
            problemDescriptionTextView.trailingAnchor.constraint(equalTo: carPlateTextField.trailingAnchor),
            problemDescriptionTextView.heightAnchor.constraint(equalToConstant: 230),
        ])
    }
    
    private func setBottomButtonsStackView() {
        carInfoBackground.addSubview(bottomButtonsStackView)
        
        NSLayoutConstraint.activate([
            bottomButtonsStackView.topAnchor.constraint(equalTo: problemDescriptionTextView.bottomAnchor, constant: 10),
            bottomButtonsStackView.leadingAnchor.constraint(equalTo: carPlateTextField.leadingAnchor),
            bottomButtonsStackView.trailingAnchor.constraint(equalTo: carPlateTextField.trailingAnchor),
            bottomButtonsStackView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func updateVisualDamageButton(buttonTapped: Bool) {
      if buttonTapped {
        visualDamageButton.layer.borderWidth = 2
        visualDamageButton.layer.borderColor = UIColor.checkmark.cgColor
      } else {
        visualDamageButton.layer.borderWidth = 0
        visualDamageButton.layer.borderColor = UIColor.clear.cgColor
      }
    }
}

