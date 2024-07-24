//
//  TransmissionTypeCell.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 12.07.24.
//

import UIKit

final class TransmissionTypeCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "TransmissionTypeCell"
    
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
    
    private let transmissionType: GeneralLabel = {
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
    func configure(withTransmissionType transmissionType: String) {
        self.transmissionType.text = transmissionType
        
        self.myIndicatorImage.image = isSelected ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "square")
        self.myIndicatorImage.tintColor = isSelected ? .checkmark : .systemGray
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        setRectangleView()
        setIndicatorImage()
        setReleaseDate()
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
    
    private func setReleaseDate() {
        rectangleView.addSubview(transmissionType)
        
        NSLayoutConstraint.activate([
            transmissionType.centerYAnchor.constraint(equalTo: rectangleView.centerYAnchor),
            transmissionType.heightAnchor.constraint(equalToConstant: 17),
            transmissionType.trailingAnchor.constraint(equalTo: rectangleView.trailingAnchor, constant: -34),
        ])
    }
}
