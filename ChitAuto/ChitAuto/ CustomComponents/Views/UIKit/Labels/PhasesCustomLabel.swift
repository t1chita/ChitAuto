//
//  PhasesCustomLabel.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 07.07.24.
//

import UIKit

final class PhasesCustomLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        font = .systemFont(ofSize: 14, weight: .bold)
        textColor = .customLabel
        textAlignment = .left
        numberOfLines = 0
    }
}
