//
//  BrandsAndModelsSheetsVC.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 10.07.24.
//

import UIKit

final class BrandsSheetsVC: UIViewController {
    //MARK: - Properties
    var brandsSheetView: BrandsSheetsView
    var brandsSheetViewModel: BrandsSheetViewModel
    
    //MARK: - Initialization
    init(brandsSheetView: BrandsSheetsView, brandsSheetViewModel: BrandsSheetViewModel) {
        self.brandsSheetView = brandsSheetView
        self.brandsSheetViewModel = brandsSheetViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycles
    override func viewWillAppear(_ animated: Bool) {
        view = brandsSheetView
        super.viewWillAppear(animated)
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
        brandsSheetViewModel.reloadDelegate = brandsSheetView
    }
    
    private func getDelegatesFromView() {
        brandsSheetView.brandsTableView.dataSource = self
        brandsSheetView.brandsTableView.delegate = self
    }
}
