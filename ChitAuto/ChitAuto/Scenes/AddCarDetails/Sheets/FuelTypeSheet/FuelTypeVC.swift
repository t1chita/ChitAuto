//
//  FuelTypeVC.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 12.07.24.
//

import UIKit

final class FuelTypeVC: UIViewController {
    //MARK: - Properties
    var fuelTypeView: FuelTypeView
    var fuelTypeViewModel: FuelTypeViewModel
    
    weak var fuelTypeSheetDelegate: FuelTypeSheetDelegate?
    
    //MARK: - Initialization
    init(fuelTypeView: FuelTypeView, fuelTypeViewModel: FuelTypeViewModel) {
        self.fuelTypeView = fuelTypeView
        self.fuelTypeViewModel = fuelTypeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - LifeCycles
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view = fuelTypeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleDelegates()
    }
    //MARK: - Setup UI
    
    //MARK: - Delegates
    private func handleDelegates() {
        transferDelegatesFromViewModelToView()
        getDelegatesFromView()
    }
    
    private func transferDelegatesFromViewModelToView() {
        fuelTypeViewModel.reloadDelegate = fuelTypeView
    }
    
    private func getDelegatesFromView() {
        fuelTypeView.fuelTypeTableView.dataSource = self
        fuelTypeView.fuelTypeTableView.delegate = self
    }
    //MARK: - Set UI Components
}
