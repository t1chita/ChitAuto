//
//  SearchAnAssistantVC.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 15.07.24.
//

import UIKit

final class SearchAnAssistantVC: UIViewController {
    //MARK: - Properties
    var searchAnAssistantView: SearchAnAssistantView
    var searchAnAssistantViewModel: SearchAnAssistantViewModel
    
    //MARK: - Initialization
    init(searchAnAssistantView: SearchAnAssistantView, searchAnAssistantViewModel: SearchAnAssistantViewModel) {
        self.searchAnAssistantView = searchAnAssistantView
        self.searchAnAssistantViewModel = searchAnAssistantViewModel
        super.init(nibName: nil, bundle: nil )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycles
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view = searchAnAssistantView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleDelegates()
        removeDefaultBackButton()
        print(searchAnAssistantViewModel.currentOrder)
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        removeDefaultBackButton()
    }
    
    private func handleDelegates() {
        transferDelegatesFromViewModelToView()
        getDelegatesFromView()
    }
    
    private func transferDelegatesFromViewModelToView() {
        searchAnAssistantViewModel.reloadDelegate = searchAnAssistantView
    }
    
    private func getDelegatesFromView() {
        searchAnAssistantView.assistantsCollectionView.dataSource = self
        searchAnAssistantView.assistantsCollectionView.delegate = self
        searchAnAssistantView.bottomButtonsStackView.saveButtonDelegate = self
        searchAnAssistantView.bottomButtonsStackView.popViewControllerDelegate = self
        searchAnAssistantView.changeAssistantLevelsDelegate = self
    }
    
    //MARK: - Set UI Components
    private func removeDefaultBackButton() {
        navigationItem.setHidesBackButton(true, animated: true)
    }
}

extension SearchAnAssistantVC: SaveButtonDelegate {
    func saveCarDetails() {

    }
}

extension SearchAnAssistantVC: PopViewControllerDelegate {
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}

extension SearchAnAssistantVC: ChangeAssistantLevelsDelegate {
    func handleSeniorButton() {
        searchAnAssistantViewModel.updateAssistantLevel(to: .senior)
    }
    
    func handleMediumButton() {
        searchAnAssistantViewModel.updateAssistantLevel(to: .middle)
    }
    
    func handleBeginnerButton() {
        searchAnAssistantViewModel.updateAssistantLevel(to: .beginner)
    }
}
