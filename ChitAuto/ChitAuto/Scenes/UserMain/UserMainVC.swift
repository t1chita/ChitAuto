//
//  UserMainVC.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 08.07.24.
//

import UIKit

protocol PopViewControllerDelegate: AnyObject {
    func popViewController()
}

protocol GarageSheetRepresentableDelegate: AnyObject {
    func presentGarageSheet()
}

protocol AddCarDetailsPushableDelegate: AnyObject {
    func pushToAddCarDetailsPage()
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
        if userMainViewModel.currentUser.userCars.isEmpty {
            view = userMainViewWithoutOrder
        }
        else {
            view.backgroundColor = .cyan
        }
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
        getDelegatesFromView()
    }
    
    private func getDelegatesFromView() {
        userMainViewWithoutOrder.navigateToRootViewControllerDelegate = self
        userMainViewWithoutOrder.garageSheetRepresentableDelegate = self
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
extension UserMainVC: PopViewControllerDelegate {
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}

extension UserMainVC: GarageSheetRepresentableDelegate {
    func presentGarageSheet() {
        let garageSheetView = GarageSheetView()
        let garageSheetViewModel = GarageSheetViewModel(userCars: userMainViewModel.currentUser.userCars)
        let vc = GarageSheetVC(garageSheetView: garageSheetView, garageSheetViewModel: garageSheetViewModel)
        
        garageSheetView.addCarDetailsPushableDelegate = self
        
        vc.modalPresentationStyle = .pageSheet
        
        let sheet = vc.sheetPresentationController
        let smallDetentId = UISheetPresentationController.Detent.Identifier("small")
        let smallDetent = UISheetPresentationController.Detent.custom(identifier: smallDetentId) { _ in
            if garageSheetViewModel.userCars.isEmpty { return 200 }
            return 350
        }
        
        sheet?.detents = [smallDetent]
        
        present(vc, animated: true, completion: nil)
    }
}

extension UserMainVC: AddCarDetailsPushableDelegate {
    func pushToAddCarDetailsPage() {
        let addCarDetailsView = AddCarDetailsView()
        let addCarDetailsViewModel = AddCarDetailsViewModel(userId: userMainViewModel.currentUser.id)
        addCarDetailsViewModel.onSelectedCarChanged = { [weak self] car in
            self?.userMainViewModel.currentUser.userCars.append(car)
        }
        let vc = AddCarDetailsVC(addCardDetailsView: addCarDetailsView, addCardDetailsViewModel: addCarDetailsViewModel)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
