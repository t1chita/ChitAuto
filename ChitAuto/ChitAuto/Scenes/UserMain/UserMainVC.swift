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

protocol GarageAndOrderFlowRepresentableDelegate: AnyObject {
    func presentGarageSheet()
    func makeAnOrder()
}

protocol AddCarDetailsPushableDelegate: AnyObject {
    func pushToAddCarDetailsPage()
}

protocol OrderStatusButtonDelegate: AnyObject {
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
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        setNavigationItemsOnWelcomePage()
        setDefaultSelectedCar()
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
    private func setNavigationItemsOnWelcomePage() {
        navigationItem.leftBarButtonItem = userMainView.mainButton
    }
    
    private func setCarBrandImageWithData() {
        guard let unwrappedImageUrl = URL(string: userMainViewModel.currentCar?.carBrandImageUrl ?? "") else { return }
        userMainView.carBrandImage.loadImage(from: unwrappedImageUrl)
    }
    
    private func setCarPlateNumber() {
        userMainView.numberPlate.text = userMainViewModel.currentCar?.plateNumber
    }
    
    private func setAssistantName() {
        userMainView.assistantName.text = userMainViewModel.selectedOrder?.assistant.fullName
    }
    
    private func setDefaultSelectedCar() {
        userMainViewModel.currentCar = userMainViewModel.currentUser.userCars.first
    }
    
    private func setAssistantImage() {
        guard let imageUrl = URL(string: userMainViewModel.selectedOrder?.assistant.profilePicUrl ?? "") else { return }
        userMainView.assistantImage.loadImage(from: imageUrl)
    }
    
    private func updateCarInfo() {
        setCarBrandImageWithData()
        setCarPlateNumber()
        setAssistantName()
        setAssistantImage()
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

extension UserMainVC: OrderStatusButtonDelegate {
    func handleOrderStatusButton() {
        let currentOrderView = CurrentOrderView()
           let currentOrderViewModel = CurrentOrderViewModel(userID: userMainViewModel.currentUser.id, orderToRemove: userMainViewModel.selectedOrder!.id)
           
           currentOrderViewModel.onOrderRemoved = { [weak self] in
               guard let self = self else { return }
               print("Order removed closure called")
               self.userMainViewModel.currentUser = {
                   var user = self.userMainViewModel.currentUser
                   user.userOrders.removeAll(where: { $0.id == self.userMainViewModel.selectedOrder?.id })
                   return user
               }()
               self.updateUI()
           }
           
           let vc = CurrentOrderVC(currentOrderView: currentOrderView, currentOrderViewModel: currentOrderViewModel)
           
           navigationController?.pushViewController(vc, animated: true)
       }
}

extension UserMainVC: GarageAndOrderFlowRepresentableDelegate {
    func makeAnOrder() {
        if userMainViewModel.userHasCars {
            guard let userCar = userMainViewModel.currentCar else { return }
            
            let carInfoView = CarInfoView()
            let carInfoViewModel = CarInfoViewModel(currentCar: userCar, userId: userMainViewModel.currentUser.id)
            
            carInfoViewModel.onCurrentOrderChanged = { [weak self] order in
                self?.userMainViewModel.currentUser.userOrders.removeAll(where: {$0.id == order.id})
                self?.userMainViewModel.currentUser.userOrders.append(order)
            }
            
            let vc = CarInfoVC(carInfoView: carInfoView, carInfoViewModel: carInfoViewModel)
            
            navigationController?.pushViewController(vc, animated: true)
            
        } else {
            print("DEBUG: User Don't Have Cars.")
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

extension UserMainVC: AddCarDetailsPushableDelegate {
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
