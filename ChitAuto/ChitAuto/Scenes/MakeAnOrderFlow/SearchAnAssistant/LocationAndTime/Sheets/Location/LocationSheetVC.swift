//
//  Location.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 17.07.24.
//


import UIKit

final class LocationSheetVC: UIViewController {
    //MARK: - Properties
    var locationSheetView: LocationSheetView
    var locationSheetViewModel: LocationSheetViewModel
    
    weak var locationSheetDelegate: LocationSheetDelegate?
    
    //MARK: - Initialization
    init(locationSheetView: LocationSheetView, locationSheetViewModel: LocationSheetViewModel) {
        self.locationSheetView = locationSheetView
        self.locationSheetViewModel = locationSheetViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - LifeCycles
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view = locationSheetView
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
        locationSheetViewModel.reloadDelegate = locationSheetView
    }
    
    private func getDelegatesFromView() {
        locationSheetView.locationTableView.dataSource = self
        locationSheetView.locationTableView.delegate = self
    }
    //MARK: - Set UI Components
}
