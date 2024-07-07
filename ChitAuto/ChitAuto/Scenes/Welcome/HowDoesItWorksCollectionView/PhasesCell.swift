//
//  PhasesCell.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 07.07.24.
//

import UIKit

final class PhasesCell: UICollectionViewCell {
    static let identifier = "PhasesCell"
    //MARK: - UIComponents
    let mainBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customCard
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    let assistantImageView: UIImageView = {
        let imView = UIImageView()
        imView.translatesAutoresizingMaskIntoConstraints = false
        return imView
    }()
    
    let phaseDescriptionStackView: UIStackView = {
        let stView = UIStackView()
        stView.translatesAutoresizingMaskIntoConstraints = false
        stView.axis = .horizontal
        stView.distribution = .fillEqually
        return stView
    }()
    
    let phaseTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 24, weight: .bold)
        lbl.textColor = .label
        lbl.textAlignment = .left
        return lbl
    }()
    
    let phaseOrdinalityText: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14, weight: .semibold)
        lbl.textColor = .customLabel
        lbl.textAlignment = .right
        return lbl
    }()
    
    let phaseStepsStackView: UIStackView = {
        let stView = UIStackView()
        stView.translatesAutoresizingMaskIntoConstraints = false
        stView.axis = .vertical
        stView.alignment = .leading
        stView.distribution = .fillEqually
        stView.spacing = 5
        return stView
    }()
    //TODO: Nice To Have Bullets In StackView
    let firstStep: PhasesCustomLabel = {
        let lbl = PhasesCustomLabel()
        return lbl
    }()
    
    let secondStep: PhasesCustomLabel = {
        let lbl = PhasesCustomLabel()
        return lbl
    }()
    
    let thirdStep: PhasesCustomLabel = {
        let lbl = PhasesCustomLabel()
        return lbl
    }()
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    func configure (imageURL: URL,
                    phaseText: String,
                    phaseOrdinality: String,
                    firstStep: String,
                    secondStep: String,
                    thirdStep: String
    ) {
        self.assistantImageView.loadImage(from: imageURL)
        self.phaseTitle.text = phaseText
        self.phaseOrdinalityText.text = phaseOrdinality
        self.firstStep.text = firstStep
        self.secondStep.text = secondStep
        self.thirdStep.text = thirdStep
    }
    
    //MARK: - Setup UI
    private func setup() {
        setMainBackgroundView()
        setAssistantImageView()
        setPhaseDescriptionStackView()
        setPhaseStepsStackView()
    }
    
    //MARK: - Set UI Components
    private func setMainBackgroundView() {
        addSubview(mainBackgroundView)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            mainBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            mainBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setAssistantImageView() {
        mainBackgroundView.addSubview(assistantImageView)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            assistantImageView.topAnchor.constraint(equalTo: mainBackgroundView.topAnchor),
            assistantImageView.leadingAnchor.constraint(equalTo: mainBackgroundView.leadingAnchor),
            assistantImageView.trailingAnchor.constraint(equalTo: mainBackgroundView.trailingAnchor),
            assistantImageView.heightAnchor.constraint(equalToConstant: 350)
        ])
    }
    
    private func setPhaseDescriptionStackView() {
        mainBackgroundView.addSubview(phaseDescriptionStackView)
        
        phaseDescriptionStackView.addArrangedSubview(phaseTitle)
        phaseDescriptionStackView.addArrangedSubview(phaseOrdinalityText)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            phaseDescriptionStackView.topAnchor.constraint(equalTo: assistantImageView.bottomAnchor, constant: 30),
            phaseDescriptionStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            phaseDescriptionStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            phaseDescriptionStackView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func setPhaseStepsStackView() {
        mainBackgroundView.addSubview(phaseStepsStackView)
        
        phaseStepsStackView.addArrangedSubview(firstStep)
        phaseStepsStackView.addArrangedSubview(secondStep)
        phaseStepsStackView.addArrangedSubview(thirdStep)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            phaseStepsStackView.topAnchor.constraint(equalTo: phaseDescriptionStackView.bottomAnchor, constant: 10),
            phaseStepsStackView.leadingAnchor.constraint(equalTo: mainBackgroundView.leadingAnchor, constant: 24),
            phaseStepsStackView.trailingAnchor.constraint(equalTo: mainBackgroundView.trailingAnchor, constant: -24),
            phaseStepsStackView.heightAnchor.constraint(equalToConstant: 130),
        ])
    }
}
