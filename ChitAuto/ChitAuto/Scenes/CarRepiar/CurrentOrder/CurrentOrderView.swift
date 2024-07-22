//
//  CurrentOrderView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 18.07.24.
//

import UIKit

final class CurrentOrderView: UIView {
    //MARK: - UIComponents
    private let repairingGif: UIImageView = {
       let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        let repairingGif = UIImage.gifImageWithName("repairingGif")
        imgView.image = repairingGif
        return imgView
    }()
    
    private let orderDesc: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 18, weight: .regular)
        lbl.textAlignment = .center
        lbl.textColor = .customLabel
        lbl.text = "თქვენი შეკვეთა მიღებულია,ასისტენტი მალე დაგიკავშირდებათ."
        return lbl
    }()
    
    private let orderStatusButtonsStackView: UIStackView = {
       let stView = UIStackView()
        stView.translatesAutoresizingMaskIntoConstraints = false
        stView.axis = .horizontal
        stView.distribution = .fillEqually
        stView.spacing = 6
        stView.alignment = .fill
        return stView
    }()
    
    private let cancelOrderButton: CustomGeneralButton = {
        let button = CustomGeneralButton()
        button.setTitle("გაუქმება", for: .normal)
        button.backgroundColor = .red
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        return button
    }()
    
    private let orderIsDoneButton: CustomGeneralButton = {
        let button = CustomGeneralButton()
        button.setTitle("დასრულებულია", for: .normal)
        button.backgroundColor = .checkmark
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        return button
    }()
    
    weak var cancelButtonDelegate: CancelButtonDelegate?
    
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
        setOrderDesc()
        setCancelOrderButton()
        setRepairingGif()
    }
    
    //MARK: - Set UI Components
    private func setRepairingGif() {
        addSubview(repairingGif)
        
        NSLayoutConstraint.activate([
            repairingGif.topAnchor.constraint(equalTo: topAnchor, constant: 70),
            repairingGif.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            repairingGif.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
        ])
    }
    
    private func setOrderDesc() {
        addSubview(orderDesc)
        
        NSLayoutConstraint.activate([
            orderDesc.centerYAnchor.constraint(equalTo: centerYAnchor),
            orderDesc.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            orderDesc.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
        ])
    }
    
    private func setCancelOrderButton() {
        addSubview(orderStatusButtonsStackView)
        
        orderStatusButtonsStackView.addArrangedSubview(orderIsDoneButton)
        orderStatusButtonsStackView.addArrangedSubview(cancelOrderButton)
        
        cancelOrderButton.addAction(UIAction(title: "Cancel Order", handler: {[weak self] _ in
            self?.cancelButtonDelegate?.handleCancelButton()
        }), for: .touchUpInside)
          
        orderIsDoneButton.addAction(UIAction(title: "Order Is Done", handler: {[weak self] _ in
            self?.cancelButtonDelegate?.handleOrderIsDoneButton()
        }), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            orderStatusButtonsStackView.topAnchor.constraint(equalTo: orderDesc.bottomAnchor, constant: 30),
            orderStatusButtonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            orderStatusButtonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            orderStatusButtonsStackView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
