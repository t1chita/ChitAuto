//
//  CustomGeneralButton.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 02.07.24.
//

import UIKit

final class CustomGeneralButton: UIButton {
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
        titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        translatesAutoresizingMaskIntoConstraints = false
        setTitleColor(.customLabel, for: .normal)
        titleLabel?.textAlignment = .center
        backgroundColor = .customCard
        layer.cornerRadius = 16
        clipsToBounds = true
    }
}
