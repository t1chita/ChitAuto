//
//  PersonalInfo.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 21.07.24.
//

import UIKit

final class PersonalInfoTextField: UIView {
    
    private let textFieldTitle: String
    private let textFieldIcon: String
    
    private let titleLabel = UILabel()
    let textField = UITextField()
    
    var textFieldText: String {
        get { return textField.text ?? "" }
        set { textField.text = newValue }
    }
    
    init(textFieldTitle: String, textFieldIcon: String) {
        self.textFieldTitle = textFieldTitle
        self.textFieldIcon = textFieldIcon
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        // Setup titleLabel
        titleLabel.text = textFieldTitle
        titleLabel.textColor = .customLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        // Setup textField
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setIcon(UIImage(systemName: textFieldIcon) ?? .logo)
        addSubview(textField)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            textField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
