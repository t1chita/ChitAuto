//
//  GeneralLabel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 24.07.24.
//

import UIKit

final class GeneralLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        font = .systemFont(ofSize: 16, weight: .bold)
        numberOfLines = 0
        textColor = .customLabel
        textAlignment = .left
    }
}

