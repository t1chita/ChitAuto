//
//  TechInspectView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 22.07.24.
//

import UIKit

final class TechInspectView: UIView {
    //MARK: - UIComponents
    private let techInspectTitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 24, weight: .bold)
        lbl.textColor = .customLabel
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.text = "გაიგე ტექ ინსპექტირების თარიღი"
        return lbl
    }()

    
    let numberPlateTextField: NumberPlateTextField = {
        let txtField = NumberPlateTextField()
        return txtField
    }()
    
    private let getTechInspectDateButton: CustomGeneralButton = {
        let button = CustomGeneralButton()
        button.setTitle("გაიგე თარიღი", for: .normal)
        button.backgroundColor = .customCard
        return button
    }()
    
    weak var getTechInspectDelegate: GetTechInspectDelegate?
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .customBackground
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - LifeCycles
    
    //MARK: - Setup UI
    private func setupUI() {
        setTechInspectTitle()
        setNumberPlateTextField()
        setGetTechInspectDateButton()
    }
    
    //MARK: - Set UI Components
    private func setTechInspectTitle() {
        addSubview(techInspectTitle)
        
        NSLayoutConstraint.activate([
            techInspectTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 60),
            techInspectTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            techInspectTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            techInspectTitle.heightAnchor.constraint(equalToConstant: 70),
        ])
    }  
    
    private func setNumberPlateTextField() {
        addSubview(numberPlateTextField)
        
        NSLayoutConstraint.activate([
            numberPlateTextField.topAnchor.constraint(equalTo: techInspectTitle.bottomAnchor, constant: 30),
            numberPlateTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            numberPlateTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            numberPlateTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
    }    
    
    private func setGetTechInspectDateButton() {
        addSubview(getTechInspectDateButton)
        
        getTechInspectDateButton.addAction(UIAction(title: "Get Tech Inspect Info", handler: { [weak self] _ in
            self?.getTechInspectDelegate?.getTechInspectInfo()
        }), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            getTechInspectDateButton.topAnchor.constraint(equalTo: numberPlateTextField.bottomAnchor, constant: 30),
            getTechInspectDateButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            getTechInspectDateButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            getTechInspectDateButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
}

#Preview {
    TechInspectVC(techInspectView: TechInspectView(), techInspectViewModel: TechInspectViewModel())
}
