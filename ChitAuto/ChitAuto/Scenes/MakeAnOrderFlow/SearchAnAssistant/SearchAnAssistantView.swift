//
//  SearchAnAssistantView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 15.07.24.
//

import UIKit

protocol ChangeAssistantLevelsDelegate: AnyObject {
    func handleSeniorButton()
    func handleMediumButton()
    func handleBeginnerButton()
}

final class SearchAnAssistantView: UIView {
    //MARK: - UIComponents
    private let scrollView: UIScrollView = {
        let scrView = UIScrollView()
        scrView.translatesAutoresizingMaskIntoConstraints = false
        scrView.showsVerticalScrollIndicator = false
        return scrView
    }()
    
    private let contentView: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
    let carInfoBackground: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.layer.cornerRadius = 20
        vw.backgroundColor = .customCard
        return vw
    }()
    
    let assistantsCollectionView: UICollectionView = {
        let collectionViewFlowLayout = CustomFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: collectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(AssistantsCell.self, forCellWithReuseIdentifier: AssistantsCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let assistantLevelsStackView: UIStackView = {
        let stView = UIStackView()
        stView.translatesAutoresizingMaskIntoConstraints = false
        stView.axis = .horizontal
        stView.spacing = 8
        stView.distribution = .fillEqually
        return stView
    }()
    
    let seniorButton: CustomGeneralButton = {
        let button = CustomGeneralButton()
        button.setTitle("ექსპერტი", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        button.backgroundColor = .customBackground
        return button
    }()
    
    let mediumButton: CustomGeneralButton = {
        let button = CustomGeneralButton()
        button.setTitle("გამოცდილი", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        button.backgroundColor = .customBackground
        return button
    }()    
    
    let beginnerButton: CustomGeneralButton = {
        let button = CustomGeneralButton()
        button.setTitle("დამწყები", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        button.backgroundColor = .customBackground
        return button
    }()
    
    let bottomButtonsStackView: BottomButtonsStackView = {
        let stView = BottomButtonsStackView()
        stView.saveButton.setTitle("შემდეგი", for: .normal)
        return stView
    }()
    
    //MARK: - Delegates
    weak var changeAssistantLevelsDelegate: ChangeAssistantLevelsDelegate?
    
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
        setScrollView()
        setContentView()
        
        setCarInfoBackground()
        setAssistantsCollectionView()
        setAssistantLevelsStackView()
        setBottomButtonsStackView()
    }
    
    //MARK: - Set UI Components
    private func setScrollView() {
        addSubview(scrollView)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func setContentView() {
        scrollView.addSubview(contentView)
        let heightAnchor = contentView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor)
        heightAnchor.priority = .defaultHigh
        
        //Set Constraints
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            heightAnchor
        ])
    }
    
    private func setCarInfoBackground() {
        contentView.addSubview(carInfoBackground)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            carInfoBackground.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -100),
            carInfoBackground.heightAnchor.constraint(equalToConstant: 450),
            carInfoBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            carInfoBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
        ])
    }
    
    private func setAssistantsCollectionView() {
        carInfoBackground.addSubview(assistantsCollectionView)
        
        NSLayoutConstraint.activate([
            assistantsCollectionView.topAnchor.constraint(equalTo: carInfoBackground.topAnchor, constant: 20),
            assistantsCollectionView.leadingAnchor.constraint(equalTo: carInfoBackground.leadingAnchor, constant: 40),
            assistantsCollectionView.trailingAnchor.constraint(equalTo: carInfoBackground.trailingAnchor, constant: -40),
            assistantsCollectionView.heightAnchor.constraint(equalToConstant: 250),
        ])
    } 
    
    private func setAssistantLevelsStackView() {
        carInfoBackground.addSubview(assistantLevelsStackView)
        
        assistantLevelsStackView.addArrangedSubview(seniorButton)
        assistantLevelsStackView.addArrangedSubview(mediumButton)
        assistantLevelsStackView.addArrangedSubview(beginnerButton)
        
        seniorButton.addAction(UIAction(title: "Show Senior Assistants", handler: {[weak self] _ in
            self?.changeAssistantLevelsDelegate?.handleSeniorButton()
        }), for: .touchUpInside)
        
        mediumButton.addAction(UIAction(title: "Show Medium Assistants", handler: {[weak self] _ in
            self?.changeAssistantLevelsDelegate?.handleMediumButton()
        }), for: .touchUpInside)
        
        beginnerButton.addAction(UIAction(title: "Show Beginner Assistants", handler: {[weak self] _ in
            self?.changeAssistantLevelsDelegate?.handleBeginnerButton()
        }), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            assistantLevelsStackView.topAnchor.constraint(equalTo: assistantsCollectionView.bottomAnchor, constant: 60),
            assistantLevelsStackView.leadingAnchor.constraint(equalTo: carInfoBackground.leadingAnchor, constant: 20),
            assistantLevelsStackView.trailingAnchor.constraint(equalTo: carInfoBackground.trailingAnchor, constant: -20),
            assistantLevelsStackView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    
    private func setBottomButtonsStackView() {
        carInfoBackground.addSubview(bottomButtonsStackView)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            bottomButtonsStackView.bottomAnchor.constraint(equalTo: carInfoBackground.bottomAnchor, constant: -6),
            bottomButtonsStackView.leadingAnchor.constraint(equalTo: carInfoBackground.leadingAnchor, constant: 20),
            bottomButtonsStackView.trailingAnchor.constraint(equalTo: carInfoBackground.trailingAnchor, constant: -20),
            bottomButtonsStackView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}


#Preview {
    SearchAnAssistantVC(searchAnAssistantView: SearchAnAssistantView(), searchAnAssistantViewModel: SearchAnAssistantViewModel())
}


//MARK: Reload Data For ViewModel
extension SearchAnAssistantView: ReloadDelegate {
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.assistantsCollectionView.reloadData()
        }
    }
}
