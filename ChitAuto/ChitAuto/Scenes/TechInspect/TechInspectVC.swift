//
//  TechInspectVC.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 22.07.24.
//

import UIKit
protocol GetTechInspectDelegate: AnyObject {
    func getTechInspectInfo()
}
final class TechInspectVC: UIViewController {
    //MARK: - UIComponents
    private var techInspectView: TechInspectView
    private var techInspectViewModel: TechInspectViewModel
    
    //MARK: - Initialization
    init(techInspectView: TechInspectView, techInspectViewModel: TechInspectViewModel) {
        self.techInspectView = techInspectView
        self.techInspectViewModel = techInspectViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycles
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view = techInspectView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleDelegates()
        setupUI()
        title = "ტექ ინსპექტირება"
    }
    
    //MARK: - SetupUI
    private func setupUI() {
        setNavigationItemsOnWelcomePage()
    }
    
    //MARK: - Delegates
    private func handleDelegates() {
        getDelegatesFromView()
    }
    
    private func getDelegatesFromView() {
        techInspectView.getTechInspectDelegate = self
        techInspectView.numberPlateTextField.delegate = self
        techInspectView.popViewControllerDelegate = self
    }
    
    private func setNavigationItemsOnWelcomePage() {
        navigationItem.leftBarButtonItem = techInspectView.mainButton
    }
}

extension TechInspectVC: PopViewControllerDelegate {
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}

extension TechInspectVC: GetTechInspectDelegate {
    func getTechInspectInfo() {
        techInspectViewModel.numberPlate = techInspectView.numberPlateTextField.text ?? ""
        techInspectViewModel.getTechInspectInfo() { [weak self] success in
            if success {
                DispatchQueue.main.async { [weak self] in
                    let techInspectSheetView = TechInspectSheetView()
                    let techInspectSheetViewModel = TechInspectSheetViewModel(pastDate: self?.techInspectViewModel.pastDate ?? "", futureDate: self?.techInspectViewModel.futureDate ?? "")
                    
                    let vc = TechInspectSheetVC(techInspectSheetView: techInspectSheetView, techInspectSheetViewModel: techInspectSheetViewModel)
                    vc.modalPresentationStyle = .pageSheet
                    
                    let sheet = vc.sheetPresentationController
                    let smallDetentId = UISheetPresentationController.Detent.Identifier("small")
                    let smallDetent = UISheetPresentationController.Detent.custom(identifier: smallDetentId) { context in
                        return 270
                    }
                    
                    sheet?.detents = [smallDetent]
                    
                    self?.present(vc, animated: true, completion: nil)
                }
            } else {
                DispatchQueue.main.async { [weak self] in 
                    AlertManager.showCanNotShowTechInspectInfo(on: self!)
                }
            }
        }
    }
}


extension TechInspectVC: UITextFieldDelegate {
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       self.view.endEditing(true)
       return false
   }
}
