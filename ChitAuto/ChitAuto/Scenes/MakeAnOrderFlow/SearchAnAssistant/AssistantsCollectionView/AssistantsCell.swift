//
//  AssistantsCell.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 16.07.24.
//

import UIKit

final class AssistantsCell: UICollectionViewCell {
    static let identifier = "AssistantsCell"
    //MARK: - UIComponents
    private let assistantImage: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleAspectFill
        imgView.layer.cornerRadius = 10
        return imgView
    }()
    
    private let assistantCarBrandsContentView: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .customCard
        vw.layer.cornerRadius = 10
        return vw
    }()
    
    private let carBrandsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private let assistantNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 14, weight: .bold)
        lbl.textColor = .customLabel
        lbl.backgroundColor = .customCard
        lbl.layer.masksToBounds = true
        lbl.layer.cornerRadius = 4
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let servicePriceAndRatingBackground: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .checkmark
        vw.layer.cornerRadius = 10
        return vw
    }()
    
    private let servicePriceLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 14, weight: .bold)
        lbl.textColor = .customLabel
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let ratingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 4
        return stackView
    }()
    
    private let starImage: UIImageView = {
        let imView = UIImageView()
        imView.image = UIImage(systemName: "star.fill")
        imView.tintColor = .yellow
        return imView
    }()
    
    private let ratingLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 14, weight: .bold)
        lbl.textColor = .yellow
        lbl.textAlignment = .left
        return lbl
    }()
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    func configure (withAssistantInfo assistant: CarAssistant) {
        guard let unwrappedImageUrl = URL(string: assistant.profilePicUrl) else { return }
        
        assistantImage.loadImage(from: unwrappedImageUrl)
        carBrandsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        setCarBrandsImages(carBrands: assistant.carBrands)
        assistantNameLabel.text = assistant.fullName
        servicePriceLabel.text = String(assistant.assistantServiceFee) + "₾"
        ratingLabel.text = String(assistant.rating)
    }
    
    //MARK: - Setup UI
    private func setup() {
        setAssistantImage()
        setAssistantCarBrandsContentView()
        setCarBrandsStackView()
        setAssistantNameLabel()
        setServicePriceAndRatingBackground()
        setServicePriceLabel()
        setRatingStackView()
    }
    
    //MARK: - Set UI Components
    private func setAssistantImage() {
        addSubview(assistantImage)
        
        NSLayoutConstraint.activate([
            assistantImage.topAnchor.constraint(equalTo: topAnchor),
            assistantImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            assistantImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            assistantImage.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setAssistantCarBrandsContentView() {
        addSubview(assistantCarBrandsContentView)
        
        NSLayoutConstraint.activate([
            assistantCarBrandsContentView.topAnchor.constraint(equalTo: topAnchor, constant: -6),
            assistantCarBrandsContentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            assistantCarBrandsContentView.widthAnchor.constraint(equalToConstant: 40),
            assistantCarBrandsContentView.heightAnchor.constraint(equalToConstant: 116),
        ])
    } 
    
    private func setCarBrandsStackView() {
        assistantCarBrandsContentView.addSubview(carBrandsStackView)
        
        
        NSLayoutConstraint.activate([
            carBrandsStackView.topAnchor.constraint(equalTo: assistantCarBrandsContentView.topAnchor, constant: 6),
            carBrandsStackView.leadingAnchor.constraint(equalTo: assistantCarBrandsContentView.leadingAnchor, constant: 5),
            carBrandsStackView.trailingAnchor.constraint(equalTo: assistantCarBrandsContentView.trailingAnchor, constant: -5)
        ])
    }
    
    private func setAssistantNameLabel() {
        addSubview(assistantNameLabel)
        
        NSLayoutConstraint.activate([
            assistantNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            assistantNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            assistantNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            assistantNameLabel.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func setServicePriceAndRatingBackground() {
        addSubview(servicePriceAndRatingBackground)
        
        NSLayoutConstraint.activate([
            servicePriceAndRatingBackground.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            servicePriceAndRatingBackground.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -8),
            servicePriceAndRatingBackground.widthAnchor.constraint(equalToConstant: 100),
            servicePriceAndRatingBackground.heightAnchor.constraint(equalToConstant: 24),
        ])
    }   
    
    private func setServicePriceLabel() {
        servicePriceAndRatingBackground.addSubview(servicePriceLabel)
        
        NSLayoutConstraint.activate([
            servicePriceLabel.centerYAnchor.constraint(equalTo: servicePriceAndRatingBackground.centerYAnchor),
            servicePriceLabel.leadingAnchor.constraint(equalTo: servicePriceAndRatingBackground.leadingAnchor, constant: 10),
            servicePriceLabel.heightAnchor.constraint(equalToConstant: 24),
        ])
    }  
    
    private func setRatingStackView() {
        servicePriceAndRatingBackground.addSubview(ratingStackView)
        
        ratingStackView.addArrangedSubview(starImage)
        ratingStackView.addArrangedSubview(ratingLabel)
        
        NSLayoutConstraint.activate([
            ratingStackView.centerYAnchor.constraint(equalTo: servicePriceAndRatingBackground.centerYAnchor),
            ratingStackView.leadingAnchor.constraint(equalTo: servicePriceLabel.trailingAnchor, constant: 5),
            ratingStackView.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
    
    
    private func setCarBrandsImages(carBrands: [AssistantsCarBrand]) {
        for carBrand in carBrands {
            guard let unwrappedImageUrl = URL(string: carBrand.imageUrl) else { return }
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.loadImage(from: unwrappedImageUrl)
            
            // Set a fixed height for each image if needed
            imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
            
            carBrandsStackView.addArrangedSubview(imageView)
        }
    }
}
