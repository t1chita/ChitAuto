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
    
    private let carBrandImage: UIImageView = {
        let imView = UIImageView()
        imView.translatesAutoresizingMaskIntoConstraints = false
        imView.contentMode = .scaleAspectFit
        return imView
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
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        setRectangleView()
        setCarImageView()
    }
    
    //MARK: - Set UI Components
    private func setRectangleView() {
        addSubview(rectangleView)
        
        NSLayoutConstraint.activate([
            rectangleView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            rectangleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            rectangleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            rectangleView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            rectangleView.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    private func setCarImageView() {
        rectangleView.addSubview(carBrandImage)
        
        NSLayoutConstraint.activate([
            carBrandImage.centerYAnchor.constraint(equalTo: rectangleView.centerYAnchor),
            carBrandImage.leadingAnchor.constraint(equalTo: rectangleView.leadingAnchor, constant: 6),
            carBrandImage.heightAnchor.constraint(equalToConstant: 30),
            carBrandImage.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
}
