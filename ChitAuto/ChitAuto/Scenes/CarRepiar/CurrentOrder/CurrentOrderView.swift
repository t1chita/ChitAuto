//
//  CurrentOrderView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 18.07.24.
//

import UIKit

final class CurrentOrderView: UIView {
    //MARK: - UIComponents
    let orderDetailsView: OrderDetailsView = {
        let vw = OrderDetailsView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
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
        setOrderDetailsView()
        setCancelOrderButton()
    }
    
    //MARK: - Set UI Components
    private func setOrderDetailsView() {
        addSubview(orderDetailsView)
        
        NSLayoutConstraint.activate([
            orderDetailsView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            orderDetailsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            orderDetailsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            orderDetailsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80),
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
            orderStatusButtonsStackView.topAnchor.constraint(equalTo: orderDetailsView.bottomAnchor, constant: 10),
            orderStatusButtonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            orderStatusButtonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            orderStatusButtonsStackView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
