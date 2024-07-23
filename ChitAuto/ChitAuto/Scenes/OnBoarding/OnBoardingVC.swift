//
//  OnBoardingVC.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 02.07.24.
//

import UIKit
import SwiftUI

final class OnBoardingVC: UIViewController {
    //MARK: - Properties
    private var onBoardingView: OnBoardingView
    private var onBoardingViewModel: OnBoardingViewModel
    
    //MARK: - Initialization
    init(onBoardingView: OnBoardingView, onBoardingViewModel: OnBoardingViewModel) {
        self.onBoardingView = onBoardingView
        self.onBoardingViewModel = onBoardingViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycles
    override func viewWillAppear(_ animated: Bool) {
        view = onBoardingView
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        handleViewDelegates()
    }
    
    //MARK: - Handle View Delegates
    private func handleViewDelegates() {
        onBoardingView.navigationDelegate = self
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        setRegistrationButtonWithData()
        setSignInLabelWithData()
    }
    
    //MARK: - Set UI Components
    private func setRegistrationButtonWithData() {
        onBoardingView.registrationButton.setTitle(onBoardingViewModel.registrationTitle, for: .normal)
    }
    
    private func setSignInLabelWithData() {
        onBoardingView.signInLabel.text = onBoardingViewModel.signInTitle
        onBoardingView.signInButton.setTitle(onBoardingViewModel.signInButtonTitle, for: .normal)
    }
}

//MARK: - Navigation Extensions
extension OnBoardingVC: SignInSingUpDelegate {
    func navigateToSignIn() {
        let view = SignInView()
        let hostingController = UIHostingController(rootView: view)
        navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(hostingController, animated: true)
    }
    
    func navigateToSignUp() {
        let view = SignUpView()
        let hostingController = UIHostingController(rootView: view)
        navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(hostingController, animated: true)
    }
}
