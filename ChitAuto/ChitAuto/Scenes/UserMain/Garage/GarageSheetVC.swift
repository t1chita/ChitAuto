//
//  GarageSheetVC.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 09.07.24.
//

import UIKit

protocol GarageSheetDismissible: AnyObject {
    func dismissGarageSheet()
}

final class GarageSheetVC: UIViewController {
    //MARK: - Properties
    var garageSheetView: GarageSheetView
    var garageSheetViewModel: GarageSheetViewModel
    
    //MARK: - Initialization
    init(garageSheetView: GarageSheetView, garageSheetViewModel: GarageSheetViewModel) {
        self.garageSheetView = garageSheetView
        self.garageSheetViewModel = garageSheetViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycles
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view = garageSheetView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleDelegates()
    }
    //MARK: - Setup UI
    
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
        garageSheetView.garageSheetDismissible = self
        garageSheetView.carsTableView.dataSource = self
        garageSheetView.carsTableView.delegate = self
    }
    
    //MARK: - Set UI Components
}

extension GarageSheetVC: GarageSheetDismissible {
    func dismissGarageSheet() {
        self.dismiss(animated: true, completion: nil)
    }
}
