//
//  UserMainVC.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 08.07.24.
//

import UIKit

protocol PopViewControllerDelegate: AnyObject {
    func popViewController()
}

protocol GarageAndOrderFlowDelegate: AnyObject {
    func presentGarageSheet()
    func makeAnOrder()
}

protocol AddCarDetailsDelegate: AnyObject {
    func pushToAddCarDetailsPage()
}

protocol OrderStatusDelegate: AnyObject {
    func handleOrderStatusButton()
}

final class CarRepairingVC: UIViewController {
    //MARK: - Properties
    private var carRepairingView: CarRepairingView
    private var carRepairingViewModel: CarRepairingViewModel
    
    //MARK: - Initialization
    init(carRepairingView: CarRepairingView, carRepairingViewModel: CarRepairingViewModel) {
        self.carRepairingView = carRepairingView
        self.carRepairingViewModel = carRepairingViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycles
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view = carRepairingView
        updateCarInfo()
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleDelegates()
        setupUI()
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        setNavigationItems()
        setDefaultSelectedCarWithData()
    }
     
    //MARK: - Delegates
    private func handleDelegates() {
        getDelegatesFromView()
    }
    
    private func getDelegatesFromView() {
        carRepairingView.navigateToRootViewControllerDelegate = self
        carRepairingView.garageAndOrderFlowRepresentableDelegate = self
        carRepairingView.orderStatusButtonDelegate = self
    }

    //MARK: - Set UI Components
    private func setNavigationItems() {
        navigationItem.leftBarButtonItem = carRepairingView.mainButton
        title = "მანაქანის შეკეთება"
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    private func setCarBrandImageWithData() {
        guard let unwrappedImageUrl = URL(string: carRepairingViewModel.currentCar?.carBrandImageUrl ?? "") else { return }
        carRepairingView.carBrandImage.loadImage(from: unwrappedImageUrl)
    }
    
    private func setCarPlateNumberWithData() {
        carRepairingView.numberPlate.text = carRepairingViewModel.currentCar?.plateNumber
    }
    
    private func setAssistantNameWithData() {
        carRepairingView.assistantName.text = carRepairingViewModel.selectedOrder?.assistant.fullName
    }
    
    private func setDefaultSelectedCarWithData() {
        carRepairingViewModel.currentCar = carRepairingViewModel.currentUser.userCars.first
    }
    
    private func setAssistantImageWitData() {
        guard let imageUrl = URL(string: carRepairingViewModel.selectedOrder?.assistant.profilePicUrl ?? "") else { return }
        carRepairingView.assistantImage.loadImage(from: imageUrl)
    }
    
    private func updateCarInfo() {
        setCarBrandImageWithData()
        setCarPlateNumberWithData()
        setAssistantNameWithData()
        setAssistantImageWitData()
    }
    
    private func updateUI() {
        if carRepairingViewModel.userHasCars {
            if carRepairingViewModel.currentCarHasOrder {
                carRepairingView.updateViewWithOrder()
            } else {
                carRepairingView.updateViewWithoutOrder()
            }
        } else {
            carRepairingView.updateViewWithoutCarAndOrder()
        }
    }
}

//MARK: - Extensions Of Delegates
extension CarRepairingVC: PopViewControllerDelegate {
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}

extension CarRepairingVC: OrderStatusDelegate {
    func handleOrderStatusButton() {
        let currentOrderView = CurrentOrderView()
        let currentOrderViewModel = CurrentOrderViewModel(userID: carRepairingViewModel.currentUser.id, orderToRemove: carRepairingViewModel.selectedOrder!)
           
           currentOrderViewModel.onOrderRemoved = { [weak self] in
               guard let self = self else { return }

               self.carRepairingViewModel.currentUser = {
                   var user = self.carRepairingViewModel.currentUser
                   user.userOrders.removeAll(where: { $0.id == self.carRepairingViewModel.selectedOrder?.id })
                   return user
               }()
               self.updateUI()
           } 
        
        currentOrderViewModel.onOrderCompleted = { [weak self] in
               guard let self = self else { return }

              self.carRepairingViewModel.currentUser = {
                   var user = self.carRepairingViewModel.currentUser
                   user.userOrders.removeAll(where: { $0.id == self.carRepairingViewModel.selectedOrder?.id })
                   user.userOrdersHistory.append(self.carRepairingViewModel.selectedOrder!)
                   return user
               }()
               self.updateUI()
           }
           
           let vc = CurrentOrderVC(currentOrderView: currentOrderView, currentOrderViewModel: currentOrderViewModel)
           
           navigationController?.pushViewController(vc, animated: true)
       }
}

extension CarRepairingVC: GarageAndOrderFlowDelegate {
    func makeAnOrder() {
        if carRepairingViewModel.userHasCars && !carRepairingViewModel.currentCarHasOrder {
            guard let userCar = carRepairingViewModel.currentCar else { return }
            
            let carInfoView = CarInfoView()
            let carInfoViewModel = CarInfoViewModel(currentCar: userCar, userId: carRepairingViewModel.currentUser.id)
            
            carInfoViewModel.onCurrentOrderChanged = { [weak self] order in
                if order.assistant.fullName != "" {
                    self?.carRepairingViewModel.currentUser.userOrders.append(order)
                }
            }
            
            let vc = CarInfoVC(carInfoView: carInfoView, carInfoViewModel: carInfoViewModel)
            
            navigationController?.pushViewController(vc, animated: true)
            
        } else if carRepairingViewModel.currentCarHasOrder {
            AlertManager.showCurrentCarHasOrder(on: self)
        }
    }
    
    func presentGarageSheet() {
        let garageSheetView = GarageSheetView()
        let garageSheetViewModel = GarageSheetViewModel(userCars: carRepairingViewModel.currentUser.userCars)
        
        garageSheetView.addCarDetailsPushableDelegate = self
        garageSheetViewModel.onSavedCarChanged = {[weak self] car in
            self?.carRepairingViewModel.currentCar = car
            self?.updateCarInfo()
            self?.updateUI()
        }
        let vc = GarageSheetVC(garageSheetView: garageSheetView, garageSheetViewModel: garageSheetViewModel)
        
        
        vc.modalPresentationStyle = .pageSheet
        
        let sheet = vc.sheetPresentationController
        let smallDetentId = UISheetPresentationController.Detent.Identifier("small")
        let smallDetent = UISheetPresentationController.Detent.custom(identifier: smallDetentId) { _ in
            if garageSheetViewModel.userCars.isEmpty { return 200 }
            return 350
        }
        
        sheet?.detents = [smallDetent]
        
        present(vc, animated: true, completion: nil)
    }
}

extension CarRepairingVC: AddCarDetailsDelegate {
    func pushToAddCarDetailsPage() {
        let addCarDetailsView = AddCarDetailsView()
        let addCarDetailsViewModel = AddCarDetailsViewModel(userId: carRepairingViewModel.currentUser.id)
        addCarDetailsViewModel.onSelectedCarChanged = { [weak self] car in
            self?.carRepairingViewModel.currentCar = car
            self?.carRepairingViewModel.currentUser.userCars.append(car)
        }
        let vc = AddCarDetailsVC(addCardDetailsView: addCarDetailsView, addCardDetailsViewModel: addCarDetailsViewModel)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CarRepairingVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isEqual(navigationController?.interactivePopGestureRecognizer) {
            navigationController?.popViewController(animated: true)
        }
        return false
    }
}
