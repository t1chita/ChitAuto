//
//  BrandsAndModelsSheetsVC.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 10.07.24.
//

import UIKit

final class BrandsAndModelsSheetsVC: UIViewController {
    //MARK: - Properties
    var brandsAndModelsSheetView: BrandsAndModelsSheetsView
    var brandsAndModelsSheetViewModel: BrandsAndModelsSheetViewModel
    
    weak var brandsAndModelsSheetsDelegate: BrandsAndModelsSheetsDelegate?
    //MARK: - Initialization
    init(brandsAndModelsSheetView: BrandsAndModelsSheetsView, brandsAndModelsSheetViewModel: BrandsAndModelsSheetViewModel) {
        self.brandsAndModelsSheetView = brandsAndModelsSheetView
        self.brandsAndModelsSheetViewModel = brandsAndModelsSheetViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycles
    override func viewWillAppear(_ animated: Bool) {
        view = brandsAndModelsSheetView
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        handleDelegates()
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        
    }
    
    //MARK: - Delegates
    private func handleDelegates() {
        transferDelegatesFromViewModelToView()
        getDelegatesFromView()
        getDelegatesFromViewToViewModel()
    }
    
    private func transferDelegatesFromViewModelToView() {
        brandsAndModelsSheetViewModel.reloadDelegate = brandsAndModelsSheetView
    }
    
    private func getDelegatesFromViewToViewModel() {

    }
    
    private func getDelegatesFromView() {
        brandsAndModelsSheetView.brandsTableView.dataSource = self
        brandsAndModelsSheetView.brandsTableView.delegate = self
    }
}
