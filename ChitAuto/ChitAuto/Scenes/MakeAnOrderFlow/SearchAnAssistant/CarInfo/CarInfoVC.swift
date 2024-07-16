//
//  CarInfoVC.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 14.07.24.
//

import UIKit

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
    }
    
    //MARK: - Delegates
    private func handleDelegates() {
        getDelegatesFromView()
    }
    
    private func getDelegatesFromView() {
        carInfoView.bottomButtonsStackView.saveButtonDelegate = self
        carInfoView.bottomButtonsStackView.popViewControllerDelegate = self
    }
    
    //MARK: - Set UI Components

    private func removeDefaultBackButton() {
        navigationItem.setHidesBackButton(true, animated: true)
    }
}


//MARK: - Extensions

extension CarInfoVC: SaveButtonDelegate {
    func saveCarDetails() {
        let locationAndTimeView = LocationAndTimeView()
        let locationAndTimeViewModel = LocationAndTimeViewModel()
        
        let vc = LocationAndTimeVC(locationAndTimeView: locationAndTimeView, locationAndTimeViewModel: locationAndTimeViewModel)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CarInfoVC: PopViewControllerDelegate {
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}
