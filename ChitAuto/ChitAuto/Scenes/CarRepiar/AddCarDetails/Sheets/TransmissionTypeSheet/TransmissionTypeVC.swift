//
//  TransmissionTypeVC.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 12.07.24.
//

import UIKit

final class TransmissionTypeVC: UIViewController {
    //MARK: - Properties
    var transmissionTypeView: TransmissionTypeView
    var transmissionTypeViewModel: TransmissionTypeViewModel
    
    //MARK: - Initialization
    init(transmissionTypeView: TransmissionTypeView, transmissionTypeViewModel: TransmissionTypeViewModel) {
        self.transmissionTypeView = transmissionTypeView
        self.transmissionTypeViewModel = transmissionTypeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - LifeCycles
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view = transmissionTypeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleDelegates()
    }
    
    //MARK: - Delegates
    private func handleDelegates() {
        transferDelegatesFromViewModelToView()
        getDelegatesFromView()
    }
    
    private func transferDelegatesFromViewModelToView() {
        transmissionTypeViewModel.reloadDelegate = transmissionTypeView
    }
    
    private func getDelegatesFromView() {
        transmissionTypeView.transmissionTypeTableView.dataSource = self
        transmissionTypeView.transmissionTypeTableView.delegate = self
    }
}
