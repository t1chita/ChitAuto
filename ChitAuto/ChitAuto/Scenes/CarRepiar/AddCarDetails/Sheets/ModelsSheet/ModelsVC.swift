//
//  ModelsVC.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 11.07.24.
//

import UIKit

final class ModelsVC: UIViewController {
    //MARK: - Properties
    var modelsView: ModelsView
    var modelsViewModel: ModelsViewModel
    
    //MARK: - Initialization
    init(modelsView: ModelsView, modelsViewModel: ModelsViewModel) {
        self.modelsView = modelsView
        self.modelsViewModel = modelsViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycles
    override func viewWillAppear(_ animated: Bool) {
        view = modelsView
        super.viewWillAppear(true)
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
        modelsViewModel.reloadDelegate = modelsView
    }
    
    private func getDelegatesFromView() {
        modelsView.modelsTableView.dataSource = self
        modelsView.modelsTableView.delegate = self
    }
}
