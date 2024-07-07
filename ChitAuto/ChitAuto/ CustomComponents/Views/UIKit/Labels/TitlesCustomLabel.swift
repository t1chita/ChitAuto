//
//  TitlesCustomLabel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 07.07.24.
//

import UIKit

final class TitlesCustomLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        font = .systemFont(ofSize: 22, weight: .bold)
        numberOfLines = 0
        textColor = .label
        textAlignment = .left
    }
}
