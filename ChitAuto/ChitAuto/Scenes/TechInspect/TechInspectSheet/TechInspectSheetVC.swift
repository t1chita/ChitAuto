//
//  TechInspectSheetVC.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 22.07.24.
//

import UIKit

final class TechInspectSheetVC: UIViewController {
    //MARK: - UIComponents
    private var techInspectSheetView: TechInspectSheetView
    private var techInspectSheetViewModel: TechInspectSheetViewModel
    
    //MARK: - Initialization
    init(techInspectSheetView: TechInspectSheetView, techInspectSheetViewModel: TechInspectSheetViewModel) {
        self.techInspectSheetView = techInspectSheetView
        self.techInspectSheetViewModel = techInspectSheetViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycles
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view = techInspectSheetView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI() 
        updateUI()
    }
    
    //MARK: - SetupUI
    private func setupUI() {
        setDateLabelsWithData()
    }
    
    private func setDateLabelsWithData() {
        techInspectSheetView.pastDate.text = techInspectSheetViewModel.pastDate
        techInspectSheetView.futureDate.text = techInspectSheetViewModel.futureDate
    }
    
    private func updateUI() {
        if techInspectSheetViewModel.isInspectDateOverdue {
            techInspectSheetView.pastDate.textColor = .systemRed
        } else {
            techInspectSheetView.pastDate.textColor = .checkmark
        }
    }
}
