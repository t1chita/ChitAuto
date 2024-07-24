//
//  TechInspectSheetView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 22.07.24.
//

import UIKit


final class TechInspectSheetView: UIView {
    //MARK: - UIComponents
    private let titleLabel: TitlesCustomLabel = {
        let lbl = TitlesCustomLabel()
        lbl.text = "ტექ ინსპექტირება"
        return lbl
    }()
    
    private let techInspectInfoBackground: UIView = {
       let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .customCard
        vw.layer.cornerRadius = 20
        return vw
    }()
    
    private let techInspectInfoStackView: UIStackView = {
        let stView = UIStackView()
        stView.translatesAutoresizingMaskIntoConstraints = false
        stView.axis = .vertical
        stView.alignment = .leading
        stView.distribution = .fillEqually
        return stView
    }()
       
    let pastDate: GeneralLabel = {
        let lbl = GeneralLabel()
        return lbl
    }()
    
    let futureDate: GeneralLabel = {
        let lbl = GeneralLabel()
        return lbl
    }()
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .customBackground
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        setupTitleLabel()
        setTechInspectInfoBackground()
        setTechInspectInfoStackView()
    }
    
    //MARK: - Set UI Components
    private func setupTitleLabel() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setTechInspectInfoBackground() {
        addSubview(techInspectInfoBackground)
        
        NSLayoutConstraint.activate([
            techInspectInfoBackground.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            techInspectInfoBackground.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            techInspectInfoBackground.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            techInspectInfoBackground.heightAnchor.constraint(equalToConstant: 176),
        ])
    }   
    
    private func setTechInspectInfoStackView() {
        techInspectInfoBackground.addSubview(techInspectInfoStackView)
        
        techInspectInfoStackView.addArrangedSubview(pastDate)
        techInspectInfoStackView.addArrangedSubview(futureDate)
        
        NSLayoutConstraint.activate([
            techInspectInfoStackView.topAnchor.constraint(equalTo: techInspectInfoBackground.topAnchor, constant: 6),
            techInspectInfoStackView.leadingAnchor.constraint(equalTo: techInspectInfoBackground.leadingAnchor,constant: 6),
            techInspectInfoStackView.trailingAnchor.constraint(equalTo: techInspectInfoBackground.trailingAnchor, constant: -6),
            techInspectInfoStackView.bottomAnchor.constraint(equalTo: techInspectInfoBackground.bottomAnchor)
        ])
    }
}
