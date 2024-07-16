//
//  LocationAndTimeVC.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 15.07.24.
//

import UIKit

protocol DateChoseDelegate: AnyObject {
    func dateValueChanged()
    
}

final class LocationAndTimeVC: UIViewController {
    //MARK: - Properties
    var locationAndTimeView: LocationAndTimeView
    var locationAndTimeViewModel: LocationAndTimeViewModel
    
    //MARK: - Initialization
    init(locationAndTimeView: LocationAndTimeView, locationAndTimeViewModel: LocationAndTimeViewModel) {
        self.locationAndTimeView = locationAndTimeView
        self.locationAndTimeViewModel = locationAndTimeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycles
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view = locationAndTimeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        handleDelegates()
    }
    //MARK: - Setup UI
    private func setupUI() {
        setCityButton()
        removeDefaultBackButton()
    }
    
    //MARK: - Delegates
    private func handleDelegates() {
        getDelegatesFromView()
    }
    
    private func getDelegatesFromView() {
        locationAndTimeView.dateChoseDelegate = self
        locationAndTimeView.bottomButtonsStackView.saveButtonDelegate = self
        locationAndTimeView.bottomButtonsStackView.popViewControllerDelegate = self
    }
    
    //MARK: - Set UI Components
    private func removeDefaultBackButton() {
        navigationItem.setHidesBackButton(true, animated: true)
    }
}


//MARK: - Extensions
extension LocationAndTimeVC {
    private func setCityButton() {
        locationAndTimeViewModel.cityLocationChanged = { [weak self] newCity in
            self?.locationAndTimeView.citiesButton.title = newCity
        }  
        
        locationAndTimeViewModel.timeValueChanged = { [weak self] newTime in
            self?.locationAndTimeView.timeButton.title = newTime
        }
        
        // Set default titles
        locationAndTimeView.citiesButton.title = locationAndTimeViewModel.cityLocation
        locationAndTimeView.timeButton.title = locationAndTimeViewModel.timeValue
    }
}

extension LocationAndTimeVC: SaveButtonDelegate {
    func saveCarDetails() {
        let searchAnAssistantView = SearchAnAssistantView()
        let searchAnAssistantViewModel = SearchAnAssistantViewModel()
        
        let vc = SearchAnAssistantVC(searchAnAssistantView: searchAnAssistantView, searchAnAssistantViewModel: searchAnAssistantViewModel)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LocationAndTimeVC: PopViewControllerDelegate {
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}

extension LocationAndTimeVC: DateChoseDelegate {
    func dateValueChanged() {
        
    }
}


