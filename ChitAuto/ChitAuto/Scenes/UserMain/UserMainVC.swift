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

protocol GarageAndOrderFlowRepresentableDelegate: AnyObject {
    func presentGarageSheet()
    func makeAnOrder()
}

protocol AddCarDetailsPushableDelegate: AnyObject {
    func pushToAddCarDetailsPage()
}

final class UserMainVC: UIViewController {
    //MARK: - Properties
    var userMainView: UserMainView
    var userMainViewModel: UserMainViewModel
    
    //MARK: - Initialization
    init(userMainView: UserMainView, userMainViewModel: UserMainViewModel) {
        self.userMainView = userMainView
        self.userMainViewModel = userMainViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycles
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view = userMainView
        userMainView.updateView(userMainViewModel.userHasCars)
        updateCarInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        handleDelegates()
        print(userMainViewModel.currentUser)
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        setNavigationItemsOnWelcomePage()
        setDefaultSelectedCar()
    }
    
    
    private func updateCarInfo() {
        setCarBrandImageWithData()
        setCarPlateNumber()
    }
     
    //MARK: - Delegates
    private func handleDelegates() {
        getDelegatesFromView()
    }
    
    private func getDelegatesFromView() {
        userMainView.navigateToRootViewControllerDelegate = self
        userMainView.garageAndOrderFlowRepresentableDelegate = self
    }
    //MARK: - Set UI Components
    
    private func setNavigationItemsOnWelcomePage() {
        navigationItem.leftBarButtonItem = userMainView.mainButton
    }
    
    private func setCarBrandImageWithData() {
        guard let unwrappedImageUrl = URL(string: userMainViewModel.currentCar?.carBrandImageUrl ?? "") else { return }
        userMainView.carBrandImage.loadImage(from: unwrappedImageUrl)
    }
    
    private func setCarPlateNumber() {
        userMainView.numberPlate.text = userMainViewModel.currentCar?.plateNumber
    }
    
    private func setDefaultSelectedCar() {
        userMainViewModel.currentCar = userMainViewModel.currentUser.userCars.first
    }
    //MARK: - Child Methods
}

//MARK: - Extensions Of Delegates
extension UserMainVC: PopViewControllerDelegate {
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}

extension UserMainVC: GarageAndOrderFlowRepresentableDelegate {
    func makeAnOrder() {
        if !userMainViewModel.userHasCars {
            guard let userCar = userMainViewModel.currentCar else { return }
            
            let carInfoView = CarInfoView()
            let carInfoViewModel = CarInfoViewModel(currentCar: userCar)
            let vc = CarInfoVC(carInfoView: carInfoView, carInfoViewModel: carInfoViewModel)
            
            navigationController?.pushViewController(vc, animated: true)
            
        } else {
            print("DEBUG: User Don't Have Cars.")
        }
    }
    
    func presentGarageSheet() {
        let garageSheetView = GarageSheetView()
        let garageSheetViewModel = GarageSheetViewModel(userCars: userMainViewModel.currentUser.userCars)
        
        garageSheetView.addCarDetailsPushableDelegate = self
        garageSheetViewModel.onSavedCarChanged = {[weak self] car in
            self?.userMainViewModel.currentCar = car
            self?.updateCarInfo()
        }
        let vc = GarageSheetVC(garageSheetView: garageSheetView, garageSheetViewModel: garageSheetViewModel)
        
        
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
            self?.userMainViewModel.currentCar = car
            self?.userMainViewModel.currentUser.userCars.append(car) 
            self?.updateCarInfo()

        }
        let vc = AddCarDetailsVC(addCardDetailsView: addCarDetailsView, addCardDetailsViewModel: addCarDetailsViewModel)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
