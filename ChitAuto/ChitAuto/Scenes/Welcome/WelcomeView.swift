//
//  WelcomeView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 07.07.24.
//

import UIKit

protocol ReloadCollectionViewDelegate: AnyObject {
    func reloadData()
}


final class WelcomeView: UIView {
    //MARK: - UIComponents
    private let scrollView: UIScrollView = {
        let scrView = UIScrollView()
        scrView.translatesAutoresizingMaskIntoConstraints = false
        scrView.showsVerticalScrollIndicator = false
        return scrView
    }()
    
    let contentView: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
    let whyCaruTitle: TitlesCustomLabel = {
        let lbl = TitlesCustomLabel()
        return lbl
    }()
    
    let carusDescription: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 16, weight: .regular)
        lbl.textColor = .label
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let backgroundView: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .customCard
        vw.layer.cornerRadius = 30
        vw.clipsToBounds = true
        return vw
    }()
    
    let assistantImage: CustomImageView = {
        let imView = CustomImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        return imView
    }()
    
    private let contentViewForReasonsWhyCaru: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .customCard
        vw.layer.cornerRadius = 30
        vw.clipsToBounds = true
        return vw
    }()
    
    private let fullStackViewOfThreeReason: UIStackView = {
        let stView = UIStackView()
        stView.translatesAutoresizingMaskIntoConstraints = false
        stView.axis = .vertical
        stView.spacing = 15
        return stView
    }()
    
    let timeSavingStackView: CustomStackView = {
        let stView = CustomStackView()
        return stView
    }()
    
    let guaranteeStackView: CustomStackView = {
        let stView = CustomStackView()
        return stView
    }()
    
    let insuranceStackView: CustomStackView = {
        let stView = CustomStackView()
        return stView
    }()
    
    let howDoesItWorksTitle: TitlesCustomLabel = {
        let lbl = TitlesCustomLabel()
        return lbl
    }()
    
    let howDoesItWorksCollectionView: UICollectionView = {
        let collectionViewFlowLayout = CustomFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: collectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PhasesCell.self, forCellWithReuseIdentifier: PhasesCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    lazy var menuButton: UIBarButtonItem = {
        let saveMenu = UIMenu(title: "", children: [
            UIAction(title: "გარაჟი", image: UIImage(systemName: "car.2.fill")) { [weak self] _ in
                self?.navigatorDelegate?.navigateToGarage()
            },
            UIAction(title: "პროფილი", image: UIImage(systemName: "person.fill")) { [weak self] _ in
                self?.navigatorDelegate?.navigateToProfile()
            },
            UIAction(title: "გასვლა", image: UIImage(systemName: "rectangle.portrait.and.arrow.forward")) { [weak self] _ in
                self?.signOutDelegate?.signOut()
            },
        ])
        let button = UIBarButtonItem(image: UIImage(systemName: "list.dash"), menu: saveMenu)
        return button
    }()
    
    //MARK: - Delegates
    weak var signOutDelegate: SignOutDelegate?
    weak var navigatorDelegate: NavigatorDelegate?
        
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
        
        setWhyCaruTitle()
        setCarusDescription()
        
        setBackgroundView()
        setAssistantImage()
        setContentViewForReasonsWhyCaru()
        setFullStackViewOfThreeReason()
        
        setHowDoesItWorksTitle()
        setHowDoesItWorksCollectionView()
    }
    
    //MARK: - Set UI Components
    private func setScrollView() {
        addSubview(scrollView)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
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
    
    private func setWhyCaruTitle() {
        contentView.addSubview(whyCaruTitle)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            whyCaruTitle.topAnchor.constraint(equalTo: contentView.topAnchor),
            whyCaruTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            whyCaruTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            whyCaruTitle.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    private func setCarusDescription() {
        contentView.addSubview(carusDescription)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            carusDescription.topAnchor.constraint(equalTo: whyCaruTitle.topAnchor, constant: 36),
            carusDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            carusDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            carusDescription.heightAnchor.constraint(equalToConstant: 240),
        ])
    }
    
    private func setBackgroundView() {
        contentView.addSubview(backgroundView)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: carusDescription.bottomAnchor, constant: 16),
            backgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            backgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            backgroundView.heightAnchor.constraint(equalToConstant: 345),
        ])
    }
    
    private func setAssistantImage() {
        backgroundView.addSubview(assistantImage)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            assistantImage.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 24),
            assistantImage.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 24),
            assistantImage.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -24),
            assistantImage.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -24),
        ])
    }
    
    private func setContentViewForReasonsWhyCaru() {
        contentView.addSubview(contentViewForReasonsWhyCaru)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            contentViewForReasonsWhyCaru.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -48),
            contentViewForReasonsWhyCaru.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 48),
            contentViewForReasonsWhyCaru.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -48),
            contentViewForReasonsWhyCaru.heightAnchor.constraint(equalToConstant: 450),
        ])
    }
    
    private func setFullStackViewOfThreeReason() {
        contentViewForReasonsWhyCaru.addSubview(fullStackViewOfThreeReason)
        
        fullStackViewOfThreeReason.addArrangedSubview(timeSavingStackView)
        fullStackViewOfThreeReason.addArrangedSubview(guaranteeStackView)
        fullStackViewOfThreeReason.addArrangedSubview(insuranceStackView)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            fullStackViewOfThreeReason.topAnchor.constraint(equalTo: contentViewForReasonsWhyCaru.topAnchor, constant: 24),
            fullStackViewOfThreeReason.leadingAnchor.constraint(equalTo: contentViewForReasonsWhyCaru.leadingAnchor, constant: 24),
            fullStackViewOfThreeReason.trailingAnchor.constraint(equalTo: contentViewForReasonsWhyCaru.trailingAnchor, constant: -24),
            fullStackViewOfThreeReason.bottomAnchor.constraint(equalTo: contentViewForReasonsWhyCaru.bottomAnchor, constant: -24)
        ])
    }
    
    private func setHowDoesItWorksTitle() {
        contentView.addSubview(howDoesItWorksTitle)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            howDoesItWorksTitle.topAnchor.constraint(equalTo: contentViewForReasonsWhyCaru.bottomAnchor, constant: 30),
            howDoesItWorksTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 26),
            howDoesItWorksTitle.widthAnchor.constraint(equalToConstant: 190),
            howDoesItWorksTitle.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func setHowDoesItWorksCollectionView() {
        contentView.addSubview(howDoesItWorksCollectionView)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            howDoesItWorksCollectionView.topAnchor.constraint(equalTo: howDoesItWorksTitle.bottomAnchor, constant: 16),
            howDoesItWorksCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 9),
            howDoesItWorksCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            howDoesItWorksCollectionView.heightAnchor.constraint(equalToConstant: 570),
            howDoesItWorksCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }
}

//MARK: Reload Data For ViewModel
extension WelcomeView: ReloadCollectionViewDelegate {
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.howDoesItWorksCollectionView.reloadData()
        }
    }
}
