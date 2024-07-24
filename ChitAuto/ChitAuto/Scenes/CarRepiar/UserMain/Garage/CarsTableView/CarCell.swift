//
//  CarCell.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 12.07.24.
//

import UIKit

final class CarCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "CarCell"
    
    //MARK: - UI Components
    private let rectangleView: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.clipsToBounds = true
        vw.backgroundColor = .customCard
        vw.layer.cornerRadius = 20
        return vw
    }()
    
    private let carBrandImage: UIImageView = {
        let imView = UIImageView()
        imView.translatesAutoresizingMaskIntoConstraints = false
        imView.contentMode = .scaleAspectFit
        return imView
    }()
    
    private let carBrandName: GeneralLabel = {
        let lbl = GeneralLabel()
        return lbl
    }()
    
    private let carModelName: GeneralLabel = {
        let lbl = GeneralLabel()
        return lbl
    }()
    
    private let carPlateTextField: NumberPlateTextField = {
        let txtField = NumberPlateTextField()
        txtField.isUserInteractionEnabled = false
        return txtField
    }()
    
    //MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    func configure(withUserCar car: Car) {
        self.carBrandImage.loadImage(from: URL(string: car.carBrandImageUrl)!)
        self.carBrandName.text = car.carBrandName
        self.carModelName.text = car.carModelName
        self.carPlateTextField.text = car.plateNumber
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        setRectangleView()
        setCarImageView()
        setCarPlateTextField()
        setCarBrandName()
        setCarModelName()
    }
    
    //MARK: - Set UI Components
    private func setRectangleView() {
        addSubview(rectangleView)
        
        NSLayoutConstraint.activate([
            rectangleView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            rectangleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            rectangleView.trailingAnchor.constraint(equalTo: trailingAnchor),
            rectangleView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            rectangleView.heightAnchor.constraint(equalToConstant: 90),
        ])
    }
    
    private func setCarImageView() {
        rectangleView.addSubview(carBrandImage)
        
        NSLayoutConstraint.activate([
            carBrandImage.centerYAnchor.constraint(equalTo: rectangleView.centerYAnchor),
            carBrandImage.leadingAnchor.constraint(equalTo: rectangleView.leadingAnchor, constant: 6),
            carBrandImage.heightAnchor.constraint(equalToConstant: 40),
            carBrandImage.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func setCarBrandName() {
        rectangleView.addSubview(carBrandName)
        
        NSLayoutConstraint.activate([
            carBrandName.topAnchor.constraint(equalTo: rectangleView.topAnchor, constant: 4),
            carBrandName.leadingAnchor.constraint(equalTo: rectangleView.leadingAnchor, constant: 6),
        ])
    }  
    
    private func setCarModelName() {
        rectangleView.addSubview(carModelName)
        
        NSLayoutConstraint.activate([
            carModelName.topAnchor.constraint(equalTo: carBrandImage.bottomAnchor, constant: 4),
            carModelName.leadingAnchor.constraint(equalTo: carBrandImage.leadingAnchor, constant: 6),
        ])
    }
    
    private func setCarPlateTextField() {
        rectangleView.addSubview(carPlateTextField)
        
        NSLayoutConstraint.activate([
            carPlateTextField.centerYAnchor.constraint(equalTo: rectangleView.centerYAnchor),
            carPlateTextField.trailingAnchor.constraint(equalTo: rectangleView.trailingAnchor, constant: -6),
            carPlateTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    //MARK: - Methods For Update UI
    func setSelectedAppearance() {
        rectangleView.backgroundColor = UIColor.customCard.withAlphaComponent(0.7)
        rectangleView.layer.borderColor = UIColor.black.cgColor
        rectangleView.layer.borderWidth = 2
    }
    
    func setDeselectedAppearance() {
        rectangleView.backgroundColor = .customCard
        rectangleView.layer.borderColor = UIColor.clear.cgColor
        rectangleView.layer.borderWidth = 0
    }
}
