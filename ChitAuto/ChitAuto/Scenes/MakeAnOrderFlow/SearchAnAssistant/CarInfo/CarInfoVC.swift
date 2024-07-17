//
//  CarInfoVC.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 14.07.24.
//

import UIKit

protocol SaveCarInfoDelegate: AnyObject {
    func handleSavingCarInfo()
}

final class CarInfoVC: UIViewController {
    //MARK: - Properties
    var carInfoView: CarInfoView
    var carInfoViewModel: CarInfoViewModel
    
    //MARK: - Initialization
    init(carInfoView: CarInfoView, carInfoViewModel: CarInfoViewModel) {
        self.carInfoView = carInfoView
        self.carInfoViewModel = carInfoViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycles
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view = carInfoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        handleDelegates()
    }
    
    //MARK: - SetupUI
    private func setupUI() {
        removeDefaultBackButton()
        setCarPlateTextField()
    }
    
    //MARK: - Delegates
    private func handleDelegates() {
        getDelegatesFromView()
    }
    
    private func getDelegatesFromView() {
        carInfoView.bottomButtonsStackView.saveButtonDelegate = self
        carInfoView.bottomButtonsStackView.popViewControllerDelegate = self
        carInfoView.saveCarInfoDelegate = self
    }
    
    //MARK: - Set UI Components
    private func setCarPlateTextField() {
        carInfoView.carPlateTextField.text = carInfoViewModel.currentCar.plateNumber
    }
    
    private func removeDefaultBackButton() {
        navigationItem.setHidesBackButton(true, animated: true)
    }
}


//MARK: - Extensions

extension CarInfoVC: SaveButtonDelegate {
    func saveCarDetails() {
        carInfoViewModel.currentOrder?.problemDescription = carInfoView.problemDescriptionTextView.text
        if carInfoViewModel.validateCarInfoPage {
            
            guard let order = carInfoViewModel.currentOrder else {
                print("DEBUG: Can't unwrap currentOrder")
                return
            }
            
            let locationAndTimeView = LocationAndTimeView()
            let locationAndTimeViewModel = LocationAndTimeViewModel(order: order, userId: carInfoViewModel.userId)
            
            locationAndTimeViewModel.onCurrentOrderChanged = { [weak self] order in
                self?.carInfoViewModel.currentOrder = order
            }
            
            let vc = LocationAndTimeVC(locationAndTimeView: locationAndTimeView, locationAndTimeViewModel: locationAndTimeViewModel)
            
            navigationController?.pushViewController(vc, animated: true)
        } else {
            //TODO: ALERT
        }
    }
}

extension CarInfoVC: PopViewControllerDelegate {
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}

extension CarInfoVC: SaveCarInfoDelegate {
    func handleSavingCarInfo() {
        carInfoViewModel.currentOrder?.visualDamage.toggle()
        carInfoView.updateVisualDamageButton(buttonTapped: carInfoViewModel.currentOrder?.visualDamage ?? false)
    }
}
