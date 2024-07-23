//
//  OrderDetailsView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 23.07.24.
//

import UIKit

final class OrderDetailsView: UIView {
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

    let assistantImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.layer.cornerRadius = 22
        imgView.clipsToBounds = true
        return imgView
    }()
    
    
    private let carContentStackView: UIStackView = {
        let stView = UIStackView()
        stView.translatesAutoresizingMaskIntoConstraints = false
        stView.axis = .horizontal
        stView.distribution = .fillProportionally
        return stView
    }()
    
    let carBrandImage: UIImageView = {
        let imView = UIImageView()
        imView.translatesAutoresizingMaskIntoConstraints = false
        imView.contentMode = .scaleAspectFit
        return imView
    }()
    
    let numberPlate: NumberPlateTextField = {
        let txtField = NumberPlateTextField()
        txtField.isUserInteractionEnabled = false
        return txtField
    }()

    private let orderContentBackground: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .customCard
        vw.clipsToBounds = true
        vw.layer.cornerRadius = 22
        return vw
    }()
    
    private let orderDescriptionStackView: UIStackView = {
        let stView = UIStackView()
        stView.translatesAutoresizingMaskIntoConstraints = false
        stView.axis = .vertical
        stView.alignment = .fill
        stView.distribution = .fill
        stView.spacing = 10
        return stView
    }()
    
    
    let cityLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 16, weight: .regular)
        lbl.textColor = .label
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let dateLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 16, weight: .regular)
        lbl.textColor = .label
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let timeLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 16, weight: .regular)
        lbl.textColor = .label
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let visualDamageLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 16, weight: .regular)
        lbl.textColor = .label
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let problemDescriptionTextView: UITextView = {
        let txtView = UITextView()
        txtView.translatesAutoresizingMaskIntoConstraints = false
        txtView.backgroundColor = .customCard
        txtView.layer.cornerRadius = 16
        txtView.isUserInteractionEnabled = false
        return txtView
    }()
    
    
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
        setAssistantImageView()
        setCarContentStackView()
        setOrderContentBackground()
        setOrderDescriptionStackView()
        setProblemDescriptionTextView()
    }
    
    //MARK: - Set UI Components
    private func setScrollView() {
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
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
    
    private func setAssistantImageView() {
        contentView.addSubview(assistantImageView)
        
        NSLayoutConstraint.activate([
            assistantImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            assistantImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            assistantImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            assistantImageView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    private func setCarContentStackView() {
        contentView.addSubview(carContentStackView)
        
        carContentStackView.addArrangedSubview(numberPlate)
        carContentStackView.addArrangedSubview(carBrandImage)
        
        NSLayoutConstraint.activate([
            carContentStackView.topAnchor.constraint(equalTo: assistantImageView.bottomAnchor, constant: 20),
            carContentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            carContentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
        ])
    }
    
    
    private func setOrderContentBackground() {
        contentView.addSubview(orderContentBackground)
        
        NSLayoutConstraint.activate([
            orderContentBackground.topAnchor.constraint(equalTo: carContentStackView.bottomAnchor, constant: 20),
            orderContentBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            orderContentBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            orderContentBackground.heightAnchor.constraint(equalToConstant: 156),
        ])
    }  
    
    
    
    private func setOrderDescriptionStackView() {
        orderContentBackground.addSubview(orderDescriptionStackView)
        
        orderDescriptionStackView.addArrangedSubview(cityLabel)
        orderDescriptionStackView.addArrangedSubview(dateLabel)
        orderDescriptionStackView.addArrangedSubview(timeLabel)
        orderDescriptionStackView.addArrangedSubview(visualDamageLabel)
        
        NSLayoutConstraint.activate([
            orderDescriptionStackView.topAnchor.constraint(equalTo: orderContentBackground.topAnchor, constant: 16),
            orderDescriptionStackView.leadingAnchor.constraint(equalTo: orderContentBackground.leadingAnchor, constant: 16),
            orderDescriptionStackView.trailingAnchor.constraint(equalTo: orderContentBackground.trailingAnchor, constant: -16),
            orderDescriptionStackView.bottomAnchor.constraint(equalTo: orderContentBackground.bottomAnchor, constant: -16),
        ])
    }
    
    private func setProblemDescriptionTextView() {
        contentView.addSubview(problemDescriptionTextView)
        
        NSLayoutConstraint.activate([
            problemDescriptionTextView.topAnchor.constraint(equalTo: orderContentBackground.bottomAnchor, constant: 20),
            problemDescriptionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            problemDescriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            problemDescriptionTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

#Preview {
     OrderDetailsView()
}
