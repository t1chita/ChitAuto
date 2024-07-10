//
//  AddCarDetailsVC.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 09.07.24.
//

import UIKit

protocol BrandsAndModelsSheetsDelegate: AnyObject {
    func didSelectCarBrand(_ carBrand: CarBrand)
}

final class AddCarDetailsVC: UIViewController {
    //MARK: - Properties
    var addCardDetailsView: AddCarDetailsView
    var addCardDetailsViewModel: AddCarDetailsViewModel
    
    //MARK: - Initialization
    init(addCardDetailsView: AddCarDetailsView, addCardDetailsViewModel: AddCarDetailsViewModel) {
        self.addCardDetailsView = addCardDetailsView
        self.addCardDetailsViewModel = addCardDetailsViewModel
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
        getDelegatesFromViewModelToView()
        getDelegatesFromView()
        getDelegatesFromViewToViewModel()
    }
    
    private func getDelegatesFromViewModelToView() {

    }
    
    private func getDelegatesFromViewToViewModel() {

    }
    
    private func getDelegatesFromView() {
        addCardDetailsView.popViewControllerDelegate = self
        addCardDetailsView.sheetRepresentableDelegate = self
    }
    
    //MARK: - Set UI Components
    private func setCarDetailsButtons() {
        addCardDetailsViewModel.carBrandNameChanged = { [weak self] newBrandName in
               self?.addCardDetailsView.carBrandButton.title = newBrandName
           }
           addCardDetailsViewModel.carModelNameChanged = { [weak self] newModelName in
               self?.addCardDetailsView.carModelButton.title = newModelName
           }
           addCardDetailsViewModel.carReleaseDateChanged = { [weak self] newReleaseDate in
               self?.addCardDetailsView.carReleaseDateButton.title = newReleaseDate
           }
           addCardDetailsViewModel.carFuelTypeChanged = { [weak self] newFuelType in
               self?.addCardDetailsView.carFuelTypeButton.title = newFuelType
           }
           addCardDetailsViewModel.carTransmissionTypeChanged = { [weak self] newTransmissionType in
               self?.addCardDetailsView.carTransmissionTypeButton.title = newTransmissionType
           }

           // Set default titles
           addCardDetailsView.carBrandButton.title = addCardDetailsViewModel.carBrandName
           addCardDetailsView.carModelButton.title = addCardDetailsViewModel.carModelName
           addCardDetailsView.carReleaseDateButton.title = addCardDetailsViewModel.carReleaseDate
           addCardDetailsView.carFuelTypeButton.title = addCardDetailsViewModel.carFuelType
           addCardDetailsView.carTransmissionTypeButton.title = addCardDetailsViewModel.carTransmissionType
    }
    
    private func removeDefaultBackButton() {
        navigationItem.setHidesBackButton(true, animated: true)
    }
}

//MARK: - Extensions
extension AddCarDetailsVC: PopViewControllerDelegate {
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}

extension AddCarDetailsVC: SheetRepresentableDelegate {
    func presentBrandsSheet() {
        let brandsAndModelsSheetsView = BrandsAndModelsSheetsView()
        let brandsAndModelsSheetsViewModel = BrandsAndModelsSheetViewModel()
        
        
        let vc = BrandsAndModelsSheetsVC(brandsAndModelsSheetView: brandsAndModelsSheetsView, brandsAndModelsSheetViewModel: brandsAndModelsSheetsViewModel)
        vc.brandsAndModelsSheetsDelegate = self
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

extension AddCarDetailsVC: BrandsAndModelsSheetsDelegate {
    func didSelectCarBrand(_ carBrand: CarBrand) {
        addCardDetailsViewModel.carBrandName = carBrand.name
    }
}
