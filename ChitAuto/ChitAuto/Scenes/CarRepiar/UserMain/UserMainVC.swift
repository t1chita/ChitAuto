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

final class UserMainVC: UIViewController {
    //MARK: - Properties
    private var userMainView: UserMainView
    private var userMainViewModel: UserMainViewModel
    
    //MARK: - Initialization
    init(userMainView: UserMainView, userMainViewModel: UserMainViewModel) {
        self.userMainView = userMainView
        self.userMainViewModel = userMainViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycles
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view = userMainView
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
        userMainView.navigateToRootViewControllerDelegate = self
        userMainView.garageAndOrderFlowRepresentableDelegate = self
        userMainView.orderStatusButtonDelegate = self
    }

    //MARK: - Set UI Components
    private func setNavigationItems() {
        navigationItem.leftBarButtonItem = userMainView.mainButton
        title = "მანაქანის შეკეთება"
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    private func setCarBrandImageWithData() {
        guard let unwrappedImageUrl = URL(string: userMainViewModel.currentCar?.carBrandImageUrl ?? "") else { return }
        userMainView.carBrandImage.loadImage(from: unwrappedImageUrl)
    }
    
    private func setCarPlateNumberWithData() {
        userMainView.numberPlate.text = userMainViewModel.currentCar?.plateNumber
    }
    
    private func setAssistantNameWithData() {
        userMainView.assistantName.text = userMainViewModel.selectedOrder?.assistant.fullName
    }
    
    private func setDefaultSelectedCarWithData() {
        userMainViewModel.currentCar = userMainViewModel.currentUser.userCars.first
    }
    
    private func setAssistantImageWitData() {
        guard let imageUrl = URL(string: userMainViewModel.selectedOrder?.assistant.profilePicUrl ?? "") else { return }
        userMainView.assistantImage.loadImage(from: imageUrl)
    }
    
    private func updateCarInfo() {
        setCarBrandImageWithData()
        setCarPlateNumberWithData()
        setAssistantNameWithData()
        setAssistantImageWitData()
    }
    
    private func updateUI() {
        if userMainViewModel.userHasCars {
            if userMainViewModel.currentCarHasOrder {
                userMainView.updateViewWithOrder()
            } else {
                userMainView.updateViewWithoutOrder()
            }
        } else {
            userMainView.updateViewWithoutCarAndOrder()
        }
    }
}

//MARK: - Extensions Of Delegates
extension UserMainVC: PopViewControllerDelegate {
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}

extension UserMainVC: OrderStatusDelegate {
    func handleOrderStatusButton() {
        let currentOrderView = CurrentOrderView()
        let currentOrderViewModel = CurrentOrderViewModel(userID: userMainViewModel.currentUser.id, orderToRemove: userMainViewModel.selectedOrder!)
           
           currentOrderViewModel.onOrderRemoved = { [weak self] in
               guard let self = self else { return }

               self.userMainViewModel.currentUser = {
                   var user = self.userMainViewModel.currentUser
                   user.userOrders.removeAll(where: { $0.id == self.userMainViewModel.selectedOrder?.id })
                   return user
               }()
               self.updateUI()
           } 
        
        currentOrderViewModel.onOrderCompleted = { [weak self] in
               guard let self = self else { return }

              self.userMainViewModel.currentUser = {
                   var user = self.userMainViewModel.currentUser
                   user.userOrders.removeAll(where: { $0.id == self.userMainViewModel.selectedOrder?.id })
                   user.userOrdersHistory.append(self.userMainViewModel.selectedOrder!)
                   return user
               }()
               self.updateUI()
           }
           
           let vc = CurrentOrderVC(currentOrderView: currentOrderView, currentOrderViewModel: currentOrderViewModel)
           
           navigationController?.pushViewController(vc, animated: true)
       }
}

extension UserMainVC: GarageAndOrderFlowDelegate {
    func makeAnOrder() {
        if userMainViewModel.userHasCars && !userMainViewModel.currentCarHasOrder {
            guard let userCar = userMainViewModel.currentCar else { return }
            
            let carInfoView = CarInfoView()
            let carInfoViewModel = CarInfoViewModel(currentCar: userCar, userId: userMainViewModel.currentUser.id)
            
            carInfoViewModel.onCurrentOrderChanged = { [weak self] order in
                if order.assistant.fullName != "" {
                    self?.userMainViewModel.currentUser.userOrders.append(order)
                }
            }
            
            let vc = CarInfoVC(carInfoView: carInfoView, carInfoViewModel: carInfoViewModel)
            
            navigationController?.pushViewController(vc, animated: true)
            
        } else if userMainViewModel.currentCarHasOrder {
            AlertManager.showCurrentCarHasOrder(on: self)
        }
    }
    
    func presentGarageSheet() {
        let garageSheetView = GarageSheetView()
        let garageSheetViewModel = GarageSheetViewModel(userCars: userMainViewModel.currentUser.userCars)
        
        garageSheetView.addCarDetailsPushableDelegate = self
        garageSheetViewModel.onSavedCarChanged = {[weak self] car in
            self?.userMainViewModel.currentCar = car
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

extension UserMainVC: AddCarDetailsDelegate {
    func pushToAddCarDetailsPage() {
        let addCarDetailsView = AddCarDetailsView()
        let addCarDetailsViewModel = AddCarDetailsViewModel(userId: userMainViewModel.currentUser.id)
        addCarDetailsViewModel.onSelectedCarChanged = { [weak self] car in
            self?.userMainViewModel.currentCar = car
            self?.userMainViewModel.currentUser.userCars.append(car)
        }
        let vc = AddCarDetailsVC(addCardDetailsView: addCarDetailsView, addCardDetailsViewModel: addCarDetailsViewModel)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension UserMainVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isEqual(navigationController?.interactivePopGestureRecognizer) {
            navigationController?.popViewController(animated: true)
        }
        return false
    }
}
