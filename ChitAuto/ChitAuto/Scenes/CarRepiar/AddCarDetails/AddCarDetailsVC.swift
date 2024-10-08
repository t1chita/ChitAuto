//
//  AddCarDetailsVC.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 09.07.24.
//

import UIKit

protocol BrandsSheetsDelegate: AnyObject {
    func didSelectCarBrand(_ carBrand: CarBrand)
}

protocol ModelsSheetsDelegate: AnyObject {
    func didSelectCarModel(_ carModelName: String)
}

protocol ReleaseDateSheetsDelegate: AnyObject {
    func didSelectReleaseDate(_ releaseDate: Int)
}

protocol FuelTypeSheetDelegate: AnyObject {
    func didSelectFuelType(_ fuelType: String)
}

protocol TransmissionTypeSheetDelegate: AnyObject {
    func didSelectTransmissionType(_ transmissionType: String)
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
        title = "მანაქანის დეტალები"
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    //MARK: - Setup UI
    private func setupUI() {
        removeDefaultBackButton()
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
    private func removeDefaultBackButton() {
        navigationItem.setHidesBackButton(true, animated: true)
    }
}

//MARK: - Extensions
extension AddCarDetailsVC {
    private func setCarDetailsButtons() {
        addCarDetailsViewModel.carBrandNameChanged = { [weak self] newBrandName in
               self?.addCardDetailsView.carBrandButton.title = newBrandName
           }
           addCarDetailsViewModel.carModelNameChanged = { [weak self] newModelName in
               self?.addCardDetailsView.carModelButton.title = newModelName
           }
           addCarDetailsViewModel.carReleaseDateChanged = { [weak self] newReleaseDate in
               self?.addCardDetailsView.carReleaseDateButton.title = newReleaseDate
           }
           addCarDetailsViewModel.carFuelTypeChanged = { [weak self] newFuelType in
               self?.addCardDetailsView.carFuelTypeButton.title = newFuelType
           }
           addCarDetailsViewModel.carTransmissionTypeChanged = { [weak self] newTransmissionType in
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

extension AddCarDetailsVC: PopViewControllerDelegate {
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}

extension AddCarDetailsVC: SheetRepresentableDelegate {
    func presentBrandsSheet() {
        let brandsSheetsView = BrandsSheetsView()
        let brandsSheetViewModel = BrandsSheetViewModel()
        
        let vc = BrandsSheetsVC(brandsSheetView: brandsSheetsView, brandsSheetViewModel: brandsSheetViewModel)
        vc.brandsSheetsDelegate = self
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
        vc.modelsSheetsDelegate = self
        vc.modalPresentationStyle = .pageSheet
        
        let sheet = vc.sheetPresentationController
        
        sheet?.detents = [.medium()]
        
        present(vc, animated: true, completion: nil)
    }
    
    func presentReleaseDateSheet() {
        let releaseDateView = ReleaseDateView()
        let releaseDateViewModel = ReleaseDateViewModel()
        
        let vc = ReleaseDateVC(releaseDateView: releaseDateView, releaseDateViewModel: releaseDateViewModel)
        vc.releaseDateSheetsDelegate = self
        vc.modalPresentationStyle = .pageSheet
        
        let sheet = vc.sheetPresentationController
        
        sheet?.detents = [.medium()]
        
        present(vc, animated: true, completion: nil)
    }
    
    func presentFuelSheet() {
        let fuelTypeView = FuelTypeView()
        let fuelTypeViewModel = FuelTypeViewModel()
        
        let vc = FuelTypeVC(fuelTypeView: fuelTypeView, fuelTypeViewModel: fuelTypeViewModel)
        vc.fuelTypeSheetDelegate = self
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
        vc.transmissionTypeSheetDelegate = self
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

extension AddCarDetailsVC: BrandsSheetsDelegate {
    func didSelectCarBrand(_ carBrand: CarBrand) {
        addCarDetailsViewModel.carBrandName = carBrand.name
        addCarDetailsViewModel.carBrand = carBrand
    }
}

extension AddCarDetailsVC: ModelsSheetsDelegate {
    func didSelectCarModel(_ carModelName: String) {
        addCarDetailsViewModel.carModelName = carModelName
    }
}

extension AddCarDetailsVC: ReleaseDateSheetsDelegate {
    func didSelectReleaseDate(_ releaseDate: Int) {
        addCarDetailsViewModel.carReleaseDate = String(releaseDate)
    }
}

extension AddCarDetailsVC: FuelTypeSheetDelegate {
    func didSelectFuelType(_ fuelType: String) {
        addCarDetailsViewModel.carFuelType = fuelType
    }
}

extension AddCarDetailsVC: TransmissionTypeSheetDelegate {
    func didSelectTransmissionType(_ transmissionType: String) {
        addCarDetailsViewModel.carTransmissionType = transmissionType
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

extension AddCarDetailsVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isEqual(navigationController?.interactivePopGestureRecognizer) {
            navigationController?.popViewController(animated: true)
        }
        return false
    }
}
