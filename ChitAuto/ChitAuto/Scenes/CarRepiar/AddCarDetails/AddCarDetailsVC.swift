//
//  AddCarDetailsVC.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 09.07.24.
//

import UIKit

protocol SheetRepresentableDelegate: AnyObject {
    func presentBrandsSheet()
    func presentModelsSheet()
    func presentReleaseDateSheet()
    func presentFuelSheet()
    func presentTransmissionSheet()
}

protocol SaveButtonDelegate: AnyObject {
    func saveCarDetails()
}

final class AddCarDetailsVC: UIViewController {
    //MARK: - Properties
    var addCardDetailsView: AddCarDetailsView
    var addCarDetailsViewModel: AddCarDetailsViewModel
    
    //MARK: - Initialization
    init(addCardDetailsView: AddCarDetailsView, addCardDetailsViewModel: AddCarDetailsViewModel) {
        self.addCardDetailsView = addCardDetailsView
        self.addCarDetailsViewModel = addCardDetailsViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycles
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view = addCardDetailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        handleDelegates()
    }

    //MARK: - Setup UI
    private func setupUI() {
        setNavigationItems()
        setCarDetailsButtons()
    }
    
    //MARK: - Delegates
    private func handleDelegates() {
        getDelegatesFromView()
    }
    
    private func getDelegatesFromView() {
        addCardDetailsView.bottomButtonsStackView.saveButtonDelegate = self
        addCardDetailsView.bottomButtonsStackView.popViewControllerDelegate = self
        addCardDetailsView.sheetRepresentableDelegate = self
        addCardDetailsView.carPlateTextField.numberPlateDelegate = self
        addCardDetailsView.carPlateTextField.delegate = self
    }
    
    //MARK: - Set UI Components
    private func setNavigationItems() {
        title = "მანაქანის დეტალები"
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    private func setCarDetailsButtons() {
        addCarDetailsViewModel.onCarBrandChanged = { [weak self] newBrandName in
               self?.addCardDetailsView.carBrandButton.title = newBrandName
           }
           addCarDetailsViewModel.onCarModelChanged = { [weak self] newModelName in
               self?.addCardDetailsView.carModelButton.title = newModelName
           }
           addCarDetailsViewModel.onCarReleaseDateChanged = { [weak self] newReleaseDate in
               self?.addCardDetailsView.carReleaseDateButton.title = newReleaseDate
           }
           addCarDetailsViewModel.onCarFuelTypeChanged = { [weak self] newFuelType in
               self?.addCardDetailsView.carFuelTypeButton.title = newFuelType
           }
           addCarDetailsViewModel.onCarTransmissionTypeChanged = { [weak self] newTransmissionType in
               self?.addCardDetailsView.carTransmissionTypeButton.title = newTransmissionType
           }

           // Set default titles
           addCardDetailsView.carBrandButton.title = addCarDetailsViewModel.carBrandName
           addCardDetailsView.carModelButton.title = addCarDetailsViewModel.carModelName
           addCardDetailsView.carReleaseDateButton.title = addCarDetailsViewModel.carReleaseDate
           addCardDetailsView.carFuelTypeButton.title = addCarDetailsViewModel.carFuelType
           addCardDetailsView.carTransmissionTypeButton.title = addCarDetailsViewModel.carTransmissionType
    }
}

//MARK: - Extensions
extension AddCarDetailsVC: SheetRepresentableDelegate {
    func presentBrandsSheet() {
        let brandsSheetsView = BrandsSheetsView()
        let brandsSheetViewModel = BrandsSheetViewModel()
        
        let vc = BrandsSheetsVC(brandsSheetView: brandsSheetsView, brandsSheetViewModel: brandsSheetViewModel)
        brandsSheetViewModel.onBrandsChanged = {[weak self] carBrand in
            self?.addCarDetailsViewModel.carBrandName = carBrand.name
            self?.addCarDetailsViewModel.carBrand = carBrand
        }
        vc.modalPresentationStyle = .pageSheet
        
        let sheet = vc.sheetPresentationController
        
        sheet?.detents = [.medium()]
        
        present(vc, animated: true, completion: nil)
    }
    
    func presentModelsSheet() {
        guard let carBrandId = addCarDetailsViewModel.carBrand?.id else { return }
        
        let modelsView = ModelsView()
        let modelsViewModel = ModelsViewModel(carBrandId: carBrandId)
        
        let vc = ModelsVC(modelsView: modelsView, modelsViewModel: modelsViewModel)
        
        modelsViewModel.onModelsChanged = {[weak self] carModelName in
            self?.addCarDetailsViewModel.carModelName = carModelName
        }
        
        vc.modalPresentationStyle = .pageSheet
        
        let sheet = vc.sheetPresentationController
        
        sheet?.detents = [.medium()]
        
        present(vc, animated: true, completion: nil)
    }
    
    func presentReleaseDateSheet() {
        let releaseDateView = ReleaseDateView()
        let releaseDateViewModel = ReleaseDateViewModel()
        
        let vc = ReleaseDateVC(releaseDateView: releaseDateView, releaseDateViewModel: releaseDateViewModel)

        releaseDateViewModel.onReleaseDateChanged = {[weak self] releaseDate in
            self?.addCarDetailsViewModel.carReleaseDate = String(releaseDate)
        }
        
        vc.modalPresentationStyle = .pageSheet
        
        let sheet = vc.sheetPresentationController
        
        sheet?.detents = [.medium()]
        
        present(vc, animated: true, completion: nil)
    }
    
    func presentFuelSheet() {
        let fuelTypeView = FuelTypeView()
        let fuelTypeViewModel = FuelTypeViewModel()
        
        let vc = FuelTypeVC(fuelTypeView: fuelTypeView, fuelTypeViewModel: fuelTypeViewModel)

        fuelTypeViewModel.onFuelTypeChanged = {[weak self] fuelType in
            self?.addCarDetailsViewModel.carFuelType = fuelType
        }
        
        vc.modalPresentationStyle = .pageSheet
        
        let sheet = vc.sheetPresentationController
        let smallDetentId = UISheetPresentationController.Detent.Identifier("small")
        let smallDetent = UISheetPresentationController.Detent.custom(identifier: smallDetentId) { context in
            return 200
        }
        
        sheet?.detents = [smallDetent]
        
        present(vc, animated: true, completion: nil)
    }
    
    func presentTransmissionSheet() {
        let transmissionTypeView = TransmissionTypeView()
        let transmissionTypeViewModel = TransmissionTypeViewModel()
        
        let vc = TransmissionTypeVC(transmissionTypeView: transmissionTypeView, transmissionTypeViewModel: transmissionTypeViewModel)
        
        transmissionTypeViewModel.onTransmissionTypeChanged = { [weak self] transmissionType in
            self?.addCarDetailsViewModel.carTransmissionType = transmissionType
        }
        
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

extension AddCarDetailsVC: NumberPlateTextFieldDelegate {
    func didChangeText(_ text: String) {
        addCarDetailsViewModel.carPlateNumber = text
    }
}

extension AddCarDetailsVC: SaveButtonDelegate {
    func saveCarDetails() {
        if addCarDetailsViewModel.isAddCarDetailsValid {
            addCarDetailsViewModel.saveCarDetails()
            navigationController?.popViewController(animated: true)
        } else {
            AlertManager.showAddCarDetailsIsNotValid(on: self)
        }
    }
}
 
extension AddCarDetailsVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

//MARK: - Pop VC
extension AddCarDetailsVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isEqual(navigationController?.interactivePopGestureRecognizer) {
            navigationController?.popViewController(animated: true)
        }
        return false
    }
}

extension AddCarDetailsVC: PopViewControllerDelegate {
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}
