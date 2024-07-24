//
//  GarageSheetVC.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 09.07.24.
//

import UIKit

protocol GarageSheetDelegate: AnyObject {
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
    
    //MARK: - Delegates
    private func handleDelegates() {
        getDelegatesFromView()
    }
    
    private func getDelegatesFromView() {
        garageSheetView.garageSheetDismissible = self
        garageSheetView.carsTableView.dataSource = self
        garageSheetView.carsTableView.delegate = self
    }
}

extension GarageSheetVC: GarageSheetDelegate {
    func dismissGarageSheet() {
        self.dismiss(animated: true, completion: nil)
    }
}
