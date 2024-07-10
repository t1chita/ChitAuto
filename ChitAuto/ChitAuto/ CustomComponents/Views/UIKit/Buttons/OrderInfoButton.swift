//
//  OrderInfoButton.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 09.07.24.
//

import UIKit

final class OrderInfoButton: UIButton {
    let title: String
    
    //MARK: - Initialization
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        configuration = setupConfiguration()
        contentHorizontalAlignment = .fill
        heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupConfiguration() -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.image = UIImage(systemName: "chevron.down")
        // Ensure the image is on the trailing side and the title is on the leading side
        configuration.imagePlacement = .trailing
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
        configuration.titleAlignment = .leading
        configuration.baseForegroundColor = .customLabel
        configuration.background.backgroundColor = .customBackground
        return configuration
    }
}
