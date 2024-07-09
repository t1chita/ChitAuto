//
//  UserMainVC.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 08.07.24.
//

import UIKit

protocol NavigateToRootViewControllerDelegate: AnyObject {
    func backToRootViewController()
}

protocol AddCarInTheGarageDelegate: AnyObject {
    func addCarInTheGarageDelegate()
}

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
        super.viewWillAppear(true)
        view = userMainViewWithoutOrder
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        handleDelegates()
        setNavigationItemsOnWelcomePage()
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
        userMainViewWithoutOrder.addCarInTheGarageDelegate = self
    }
    
    private func getDelegatesFromView() {
        userMainViewWithoutOrder.navigateToRootViewControllerDelegate = self
    }
    
    //MARK: - Set UI Components
    private func setAddCarInTheGarageButtonWithData() {
        userMainViewWithoutOrder.addCarInTheGarageButton.setTitle(userMainViewModel.addCarInTheGarage, for: .normal)
    }
    
    private func setNavigationItemsOnWelcomePage() {
        navigationItem.leftBarButtonItem = userMainViewWithoutOrder.mainButton
    }
    //MARK: - Child Methods
}

//MARK: - Extensions Of Delegates
extension UserMainVC: NavigateToRootViewControllerDelegate {
    func backToRootViewController() {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension UserMainVC: AddCarInTheGarageDelegate {
    func addCarInTheGarageDelegate() {
        let garageSheetView = GarageSheetView()
        let garageSheetViewModel = GarageSheetViewModel()
        let vc = GarageSheetVC(garageSheetView: garageSheetView, garageSheetViewModel: garageSheetViewModel)
        
        vc.modalPresentationStyle = .pageSheet
        
        let sheet = vc.sheetPresentationController
        let smallDetentId = UISheetPresentationController.Detent.Identifier("small")
        let smallDetent = UISheetPresentationController.Detent.custom(identifier: smallDetentId) { context in
            return 200
        }
        
        sheet?.detents = [smallDetent]
        
        present(vc, animated: true, completion: nil)
    }
}
