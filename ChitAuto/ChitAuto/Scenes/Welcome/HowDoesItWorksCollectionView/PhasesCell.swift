//
//  PhasesCell.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 07.07.24.
//

import UIKit

final class PhasesCell: UICollectionViewCell {
    static let identifier = "PhasesCell"
    //MARK: - UI Components
    private let mainBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customCard
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let assistantImageView: UIImageView = {
        let imView = UIImageView()
        imView.translatesAutoresizingMaskIntoConstraints = false
        return imView
    }()
    
    private let phaseDescriptionStackView: UIStackView = {
        let stView = UIStackView()
        stView.translatesAutoresizingMaskIntoConstraints = false
        stView.axis = .horizontal
        stView.distribution = .fillEqually
        return stView
    }()
    
    private let phaseTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 24, weight: .bold)
        lbl.textColor = .label
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let phaseOrdinalityText: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14, weight: .semibold)
        lbl.textColor = .customLabel
        lbl.textAlignment = .right
        return lbl
    }()
    
    private let phaseStepsStackView: UIStackView = {
        let stView = UIStackView()
        stView.translatesAutoresizingMaskIntoConstraints = false
        stView.axis = .vertical
        stView.alignment = .leading
        stView.distribution = .fillEqually
        stView.spacing = 5
        return stView
    }()
    
    private let firstStep: PhasesCustomLabel = {
        let lbl = PhasesCustomLabel()
        return lbl
    }()
    
    private let secondStep: PhasesCustomLabel = {
        let lbl = PhasesCustomLabel()
        return lbl
    }()
    
    private let thirdStep: PhasesCustomLabel = {
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
    func configure (withRepairPhase repairPhase: RepairPhase) {
        guard let imageURL = URL(string: repairPhase.imageURL) else { return }
        self.assistantImageView.loadImage(from: imageURL)
        self.phaseTitle.text = repairPhase.phaseText
        self.phaseOrdinalityText.text = repairPhase.phaseOrdinality
        self.firstStep.text = repairPhase.firstStep
        self.secondStep.text = repairPhase.secondStep
        self.thirdStep.text = repairPhase.thirdStep
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
        
        NSLayoutConstraint.activate([
            mainBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            mainBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setAssistantImageView() {
        mainBackgroundView.addSubview(assistantImageView)
        
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
        
        NSLayoutConstraint.activate([
            phaseStepsStackView.topAnchor.constraint(equalTo: phaseDescriptionStackView.bottomAnchor, constant: 10),
            phaseStepsStackView.leadingAnchor.constraint(equalTo: mainBackgroundView.leadingAnchor, constant: 24),
            phaseStepsStackView.trailingAnchor.constraint(equalTo: mainBackgroundView.trailingAnchor, constant: -24),
            phaseStepsStackView.heightAnchor.constraint(equalToConstant: 130),
        ])
    }
}
