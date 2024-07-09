//
//  UserMainViewWithoutOrder.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 08.07.24.
//

import UIKit


final class UserMainViewWithoutOrder: UIView {
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
    
    private let addCarImage: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(resource: .addCar)
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    let addCarInTheGarageButton: CustomGeneralButton = {
        let button = CustomGeneralButton()
        return button
    }()
    
    private let bottomContentView: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .customCard
        vw.clipsToBounds = true
        vw.layer.cornerRadius = 22
        return vw
    }()
    
    private let garageAndServiceStackView: UIStackView = {
        let stView = UIStackView()
        stView.translatesAutoresizingMaskIntoConstraints = false
        stView.axis = .horizontal
        stView.distribution = .equalCentering
        return stView
    }()
    
    let garageButton: UIButton = {
        var configuration = UIButton.Configuration.borderless()
        configuration.title = "გარაჟი"
        configuration.image = UIImage(systemName: "car.2.fill")
        configuration.imagePlacement = .top
        configuration.baseForegroundColor = .customLabel
        let button = UIButton(configuration: configuration)
        return button
    }()
    
    let callAnAssistantButton: UIButton = {
        var configuration = UIButton.Configuration.borderless()
        configuration.title = "გამოიძახე"
        configuration.image = UIImage(systemName: "figure.stand.line.dotted.figure.stand")
        configuration.imagePlacement = .top
        configuration.baseForegroundColor = .customLabel
        let button = UIButton(configuration: configuration)
        return button
    }()
    
    lazy var mainButton: UIBarButtonItem = {
        let customButton = UIButton()
        customButton.addAction(UIAction(title: "Go To Welcome Page", handler: { _ in
            
        }), for: .touchUpInside)
        customButton.setImage(.mainButton, for: .normal)
        let button = UIBarButtonItem(customView: customButton)
        return button
    }()
    
    //MARK: - Delegates
    weak var addCarInTheGarageDelegate: AddCarInTheGarageDelegate?
    
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
        setAddCarImage()
        setAddCarInTheGarageButton()
        setBottomContentView()
        setGarageAndServiceStackView()
    }
    
    //MARK: - Set UI Components
    private func setScrollView() {
        addSubview(scrollView)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -120),
        ])
    }
    
    private func setContentView() {
        scrollView.addSubview(contentView)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
        ])
    }
    
    private func setAddCarImage() {
        contentView.addSubview(addCarImage)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            addCarImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            addCarImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            addCarImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            addCarImage.heightAnchor.constraint(equalToConstant: 270),
        ])
    }
    
    private func setAddCarInTheGarageButton() {
        contentView.addSubview(addCarInTheGarageButton)
        
        addCarInTheGarageButton.addAction(UIAction(title: "Add Car In The Garage", handler: { [weak self] _ in
            self?.addCarInTheGarageDelegate?.addCarInTheGarageDelegate()
        }), for: .touchUpInside)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            addCarInTheGarageButton.topAnchor.constraint(equalTo: addCarImage.bottomAnchor, constant: 40),
            addCarInTheGarageButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 48),
            addCarInTheGarageButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -48),
            addCarInTheGarageButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
    
    private func setBottomContentView() {
        addSubview(bottomContentView)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            bottomContentView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 30),
            bottomContentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomContentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomContentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 20),
        ])
        
    }
    
    private func setGarageAndServiceStackView() {
        bottomContentView.addSubview(garageAndServiceStackView)
        
        garageAndServiceStackView.addArrangedSubview(garageButton)
        garageAndServiceStackView.addArrangedSubview(callAnAssistantButton)
        
        garageButton.addAction(UIAction(title: "Add Car In The Garage", handler: { [weak self] _ in
            self?.addCarInTheGarageDelegate?.addCarInTheGarageDelegate()
        }), for: .touchUpInside)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            garageAndServiceStackView.topAnchor.constraint(equalTo: bottomContentView.topAnchor),
            garageAndServiceStackView.leadingAnchor.constraint(equalTo: bottomContentView.leadingAnchor, constant: 60),
            garageAndServiceStackView.trailingAnchor.constraint(equalTo: bottomContentView.trailingAnchor, constant: -46),
            garageAndServiceStackView.heightAnchor.constraint(equalToConstant: 90),
        ])
    }
}
