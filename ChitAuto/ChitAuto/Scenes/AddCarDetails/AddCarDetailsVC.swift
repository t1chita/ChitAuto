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
        removeDefaultBackButton()
        setCarDetailsButtons()
    }
    
    //MARK: - Delegates
    private func handleDelegates() {
        getDelegatesFromView()
    }
    
    private func getDelegatesFromView() {
        addCardDetailsView.popViewControllerDelegate = self
        addCardDetailsView.sheetRepresentableDelegate = self
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
        //TODO: Add Logic
    }
    
    func presentReleaseDateSheet() {
        //TODO: Add Logic
    }
    
    func presentFuelSheet() {
        //TODO: Add Logic
    }
    
    func presentTransmissionSheet() {
        //TODO: Add Logic
    }
}

extension AddCarDetailsVC: BrandsSheetsDelegate {
    func didSelectCarBrand(_ carBrand: CarBrand) {
        addCarDetailsViewModel.carBrandName = carBrand.name
        addCarDetailsViewModel.carBrandId = carBrand.id
    }
}
