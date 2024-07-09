//
//  UserMainVC.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 08.07.24.
//

import UIKit

final class UserMainVC: UIViewController {
    //MARK: - Properties
    var userMainViewWithoutOrder: UserMainViewWithoutOrder
    var userMainViewModel: UserMainViewModel
    
    //MARK: - Initialization
    init(userMainViewWithoutOrder: UserMainViewWithoutOrder, userMainViewModel: UserMainViewModel) {
        self.userMainViewWithoutOrder = userMainViewWithoutOrder
        self.userMainViewModel = userMainViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycles
    override func viewWillAppear(_ animated: Bool) {
        view = userMainViewWithoutOrder
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        handleDelegates()
        setNavigateToWelcomePage()
        print(userMainViewModel.currentUser)
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        setAddCarInTheGarageButtonWithData()
    }
    
    //MARK: - Delegates
    private func handleDelegates() {
        transferDelegatesFromViewModelToView()
        getDelegatesFromView()
        getDelegatesFromViewToViewModel()
    }
    
    private func transferDelegatesFromViewModelToView() {

    }
    
    private func getDelegatesFromViewToViewModel() {
        userMainViewWithoutOrder.addCarInTheGarageDelegate = userMainViewModel
    }
    
    private func getDelegatesFromView() {
        
    }
    
    //MARK: - Set UI Components
    private func setAddCarInTheGarageButtonWithData() {
        userMainViewWithoutOrder.addCarInTheGarageButton.setTitle(userMainViewModel.addCarInTheGarage, for: .normal)
    }
    
    private func setNavigateToWelcomePage() {
        navigationItem.leftBarButtonItem = userMainViewWithoutOrder.mainButton
    }
    //MARK: - Child Methods
}
