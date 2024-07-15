//
//  BottomButtonsStackView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 14.07.24.
//

import UIKit

class BottomButtonsStackView: UIStackView {

    // MARK: - Subviews
    let saveButton: CustomGeneralButton = {
        let button = CustomGeneralButton()
        button.setTitle("შენახვა", for: .normal)
        button.backgroundColor = .customBackground
        return button
    }()

    private let backButton: BackButton = {
        let button = BackButton()
        return button
    }()
    
    weak var popViewControllerDelegate: PopViewControllerDelegate?
    weak var saveButtonDelegate: SaveButtonDelegate?
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        axis = .horizontal
        spacing = 60
        distribution = .fillProportionally
        translatesAutoresizingMaskIntoConstraints = false

        addArrangedSubview(backButton)
        addArrangedSubview(saveButton)
        
        backButton.addAction(UIAction(title: "Go To User Main Page", handler: { [weak self] _ in
            self?.popViewControllerDelegate?.popViewController()
        }), for: .touchUpInside)
        
        saveButton.addAction(UIAction(title: "Save Car Details", handler: {[weak self] _ in
            self?.saveButtonDelegate?.saveCarDetails()
        }), for: .touchUpInside)
    }
}
