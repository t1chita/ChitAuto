//
//  CarInfoButton.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 09.07.24.
//

import UIKit

final class CarInfoButton: UIButton {
    var title: String = "" {
           didSet {
               setupConfiguration()
           }
       }
       
    
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
        contentHorizontalAlignment = .fill
        heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupConfiguration(){
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.image = UIImage(systemName: "chevron.down")
        configuration.imagePlacement = .trailing
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
        configuration.titleAlignment = .leading
        configuration.baseForegroundColor = .customLabel
        configuration.background.backgroundColor = .customBackground
        self.configuration = configuration
    }
}
