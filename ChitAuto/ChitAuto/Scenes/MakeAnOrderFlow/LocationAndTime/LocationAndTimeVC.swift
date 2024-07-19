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

protocol LocationSheetDelegate: AnyObject {
    func didSelectLocation(_ location: String)
}

protocol TimeSheetDelegate: AnyObject {
    func didSelectTime(_ time: String)
}

protocol LocationAndTimeVCNavigationDelegate: AnyObject {
    func handleTimeSheetNavigation()
    func handleLocationSheetNavigation()
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
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        print(locationAndTimeViewModel.order)
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
        locationAndTimeView.locationAndTimeVCNavigationDelegate = self
        locationAndTimeView.addressTextField.delegate = self
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
        locationAndTimeViewModel.address = locationAndTimeView.addressTextField.text ?? ""
        
        if locationAndTimeViewModel.isLocationAndTimeFormValid {
            
            let searchAnAssistantView = SearchAnAssistantView()
            let searchAnAssistantViewModel = SearchAnAssistantViewModel(order: locationAndTimeViewModel.order, userId: locationAndTimeViewModel.userId)
            
            searchAnAssistantViewModel.onChangedCurrentOrder = { [weak self] order in
                self?.locationAndTimeViewModel.order = order
            }
            
            let vc = SearchAnAssistantVC(searchAnAssistantView: searchAnAssistantView, searchAnAssistantViewModel: searchAnAssistantViewModel)
            
            navigationController?.pushViewController(vc, animated: true)
        } else {
            AlertManager.showCanNotUpdateOrderCarInfo(on: self)
        }
    }
}

extension LocationAndTimeVC: PopViewControllerDelegate {
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}

extension LocationAndTimeVC: DateChoseDelegate {
    func dateValueChanged() {
        let selectedDate = locationAndTimeView.datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.string(from: selectedDate)
        locationAndTimeViewModel.date = date
    }
}

extension LocationAndTimeVC: LocationSheetDelegate {
    func didSelectLocation(_ location: String) {
        locationAndTimeViewModel.cityLocation = location
    }
}

extension LocationAndTimeVC: TimeSheetDelegate {
    func didSelectTime(_ time: String) {
        locationAndTimeViewModel.timeValue = time
    }
}

extension LocationAndTimeVC: LocationAndTimeVCNavigationDelegate {
    func handleTimeSheetNavigation() {
        let timeSheetView = TimeSheetView()
        let timeSheetViewModel = TimeSheetViewModel()
        
        let vc = TimeSheetVC(timeSheetView: timeSheetView, timeSheetViewModel: timeSheetViewModel)
        vc.timeSheetDelegate = self
        vc.modalPresentationStyle = .pageSheet
        
        let sheet = vc.sheetPresentationController
        let smallDetentId = UISheetPresentationController.Detent.Identifier("small")
        let smallDetent = UISheetPresentationController.Detent.custom(identifier: smallDetentId) { context in
            return 200
        }
        
        sheet?.detents = [smallDetent]
        
        present(vc, animated: true, completion: nil)
    }
    
    func handleLocationSheetNavigation() {
        let locationSheetView = LocationSheetView()
        let locationSheetViewModel = LocationSheetViewModel()
        
        let vc = LocationSheetVC(locationSheetView: locationSheetView, locationSheetViewModel: locationSheetViewModel)
        vc.locationSheetDelegate = self
        vc.modalPresentationStyle = .pageSheet
        
        let sheet = vc.sheetPresentationController
        
        sheet?.detents = [.medium()]
        
        present(vc, animated: true, completion: nil)
    }
}

extension LocationAndTimeVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isEqual(navigationController?.interactivePopGestureRecognizer) {
            navigationController?.popViewController(animated: true)
        }
        return false
    }
}

extension LocationAndTimeVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
