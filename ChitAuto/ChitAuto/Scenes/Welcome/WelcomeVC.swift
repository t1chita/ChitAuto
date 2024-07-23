//
//  WelcomeVC.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 07.07.24.
//

import UIKit
import Firebase

protocol HomeViewControllerDelegate: AnyObject {
    func didTapMenuButton()
}

final class WelcomeVC: UIViewController {
    //MARK: - Properties
    var welcomeView: WelcomeView
    var welcomeViewModel: WelcomeViewModel

    //MARK: - Initialization
    init(welcomeView: WelcomeView, welcomeViewModel: WelcomeViewModel) {
        self.welcomeView = welcomeView
        self.welcomeViewModel = welcomeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    //MARK: - LifeCycles
    override func viewWillAppear(_ animated: Bool) {
        view = welcomeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        handleDelegates()
        setProfileMenuButton()
        title = "მთავარი"
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        setCarusDescriptionWithData()
        setCaruBenefitsWithData()
        seHowDoesItWorkTitleWithData()
        setWhyCaruTitleWithData()
    }
    
    //MARK: - Delegates
    private func handleDelegates() {
        transferDelegatesFromViewModelToView()
        getDelegatesFromView()
        getDelegatesFromViewToViewModel()
    }
    
    private func transferDelegatesFromViewModelToView() {
        welcomeViewModel.reloadDelegate = welcomeView
    }
    
    private func getDelegatesFromViewToViewModel() {
        welcomeView.signOutDelegate = welcomeViewModel
    }
    
    private func getDelegatesFromView() {
        welcomeView.howDoesItWorksCollectionView.dataSource = self
        welcomeView.howDoesItWorksCollectionView.delegate = self
    }
    
    //MARK: - Set UI Components
    private func setWhyCaruTitleWithData() {
        welcomeView.whyCaruTitle.text = welcomeViewModel.whyCaru
    }
    
    private func setCarusDescriptionWithData() {
        welcomeView.carusDescription.text = welcomeViewModel.whyCaruDesc
    }
    
    private func setCaruBenefitsWithData() {
        welcomeView.assistantImage.loadImage(from: URL(string: welcomeViewModel.assistantImage)!)
        updateTimeSavingStackView()
        updateGuaranteeStackView()
        updateInsuraceStackView()
    }
    
    private func seHowDoesItWorkTitleWithData() {
        welcomeView.howDoesItWorksTitle.text = welcomeViewModel.howDoesItWorks
    }
    
    private func setProfileMenuButton() {
        navigationItem.leftBarButtonItem = welcomeView.menuButton
    }
    
    //MARK: - Child Methods
    private func updateTimeSavingStackView() {
        welcomeView.timeSavingStackView.titleText = welcomeViewModel.economyTitle
        welcomeView.timeSavingStackView.descrText = welcomeViewModel.economyDesc
        welcomeView.timeSavingStackView.iconString = "clock"
    }
    
    private func updateGuaranteeStackView() {
        welcomeView.guaranteeStackView.titleText = welcomeViewModel.warrantyTitle
        welcomeView.guaranteeStackView.descrText =  welcomeViewModel.warrantyDesc
        welcomeView.guaranteeStackView.iconString = "wrench.adjustable"
    }
    
    private func updateInsuraceStackView() {
        welcomeView.insuranceStackView.titleText =  welcomeViewModel.insuranceTitle
        welcomeView.insuranceStackView.descrText = welcomeViewModel.insuranceDesc
        welcomeView.insuranceStackView.iconString = "checkmark.shield.fill"
    }
}

