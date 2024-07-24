//
//  BrandsCell.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 10.07.24.
//

import UIKit

final class BrandsCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "BrandsCell"
    
    var isCellSelected: Bool = false
    
    //MARK: - UIComponents
    private let rectangleView: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.clipsToBounds = true
        vw.backgroundColor = .customCard
        vw.layer.cornerRadius = 30
        return vw
    }()
    
    private let myIndicatorImage: UIImageView = {
        let imView = UIImageView()
        imView.translatesAutoresizingMaskIntoConstraints = false
        imView.contentMode = .scaleAspectFit
        return imView
    }()
    
    private let carBrandImage: UIImageView = {
        let imView = UIImageView()
        imView.translatesAutoresizingMaskIntoConstraints = false
        imView.contentMode = .scaleAspectFit
        return imView
    }()
    
    private let brandName: GeneralLabel = {
        let lbl = GeneralLabel()
        return lbl
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
    func configure(withCarBrand carBrand: CarBrand) {
        if let imageUrl = URL(string: carBrand.imageUrl ?? "") {
            carBrandImage.loadImage(from: imageUrl)
        }
        self.brandName.text = carBrand.name
        self.myIndicatorImage.image = isSelected ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "square")
        self.myIndicatorImage.tintColor = isSelected ? .checkmark : .systemGray
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        setRectangleView()
        setIndicatorImage()
        setCarBrandImage()
        setCarBrandName()
    }
    
    //MARK: - Set UI Components
    private func setRectangleView() {
        addSubview(rectangleView)
        
        NSLayoutConstraint.activate([
            rectangleView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            rectangleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            rectangleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            rectangleView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            rectangleView.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    private func setIndicatorImage() {
        rectangleView.addSubview(myIndicatorImage)
        
        NSLayoutConstraint.activate([
            myIndicatorImage.centerYAnchor.constraint(equalTo: rectangleView.centerYAnchor),
            myIndicatorImage.heightAnchor.constraint(equalToConstant: 30),
            myIndicatorImage.leadingAnchor.constraint(equalTo: rectangleView.leadingAnchor, constant: 24),
            myIndicatorImage.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func setCarBrandImage() {
        rectangleView.addSubview(carBrandImage)
        
        NSLayoutConstraint.activate([
            carBrandImage.centerYAnchor.constraint(equalTo: rectangleView.centerYAnchor),
            carBrandImage.heightAnchor.constraint(equalToConstant: 30),
            carBrandImage.leadingAnchor.constraint(equalTo: myIndicatorImage.trailingAnchor, constant: 10),
            carBrandImage.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func setCarBrandName() {
        rectangleView.addSubview(brandName)
        
        NSLayoutConstraint.activate([
            brandName.centerYAnchor.constraint(equalTo: rectangleView.centerYAnchor),
            brandName.heightAnchor.constraint(equalToConstant: 17),
            brandName.trailingAnchor.constraint(equalTo: rectangleView.trailingAnchor, constant: -34),
           ])
    }
}
