//
//  NumberPlateTextField.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 12.07.24.
//



import UIKit

final class NumberPlateTextField: UITextField {
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    private func setup() {
       translatesAutoresizingMaskIntoConstraints = false
       clipsToBounds = true
       layer.cornerRadius = 10
       layer.borderWidth = 1
       layer.borderColor = UIColor.black.cgColor
       placeholder = "XX-000-XX"
       textColor = .customLabel
       textAlignment = .center
       font = .systemFont(ofSize: 32, weight: .bold)
       backgroundColor = .customBackground
       setIcon(.carPlate)
    }
}
