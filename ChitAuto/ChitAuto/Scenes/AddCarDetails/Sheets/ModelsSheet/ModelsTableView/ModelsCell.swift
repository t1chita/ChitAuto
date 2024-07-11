//
//  ModelsCell.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 11.07.24.
//

import UIKit

final class ModelsCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "ModelsCell"
    
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
    
    private let carModelName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 14, weight: .bold)
        lbl.textColor = .customLabel
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
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
    func configure(withCarBrand carModel: CarModel) {
        self.carModelName.text = carModel.title
        
        self.myIndicatorImage.image = isSelected ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "square")
        self.myIndicatorImage.tintColor = isSelected ? .checkmark : .systemGray
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        setRectangleView()
        setIndicatorImage()
        setCarModelName()
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
    
    private func setCarModelName() {
        rectangleView.addSubview(carModelName)
        
        NSLayoutConstraint.activate([
            carModelName.centerYAnchor.constraint(equalTo: rectangleView.centerYAnchor),
            carModelName.heightAnchor.constraint(equalToConstant: 17),
            carModelName.trailingAnchor.constraint(equalTo: rectangleView.trailingAnchor, constant: -34),
        ])
    }
}
