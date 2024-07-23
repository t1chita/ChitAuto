//
//  CurrentOrderVC.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 18.07.24.
//

import UIKit
protocol CancelButtonDelegate: AnyObject {
    func handleCancelButton()
    func handleOrderIsDoneButton()
}

final class CurrentOrderVC: UIViewController {
    //MARK: - Properties
    private var currentOrderView: CurrentOrderView
    private var currentOrderViewModel: CurrentOrderViewModel
    
    //MARK: - Initialization
    init(currentOrderView: CurrentOrderView, currentOrderViewModel: CurrentOrderViewModel) {
        self.currentOrderView = currentOrderView
        self.currentOrderViewModel = currentOrderViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycles
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view = currentOrderView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        title = "მიმდინარე შეკვეთა"
        setupUI()
        handleDelegates()
    }
    
    //MARK: - Delegates
    private func handleDelegates() {
        getDelegatesFromView()
    }
    
    private func getDelegatesFromView() {
        currentOrderView.cancelButtonDelegate = self
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        removeDefaultBackButton()
        setAssistantImage()
        setOrderDescription()
    }
    
    //MARK: - Set UI Components
    private func removeDefaultBackButton() {
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    private func setAssistantImage() {
        guard let assistantImage = URL(string: currentOrderViewModel.orderToRemove.assistant.profilePicUrl) else { return }
        currentOrderView.orderDetailsView.assistantImageView.loadImage(from: assistantImage)
    }
    
    private func setOrderDescription() {
        guard let carBrandImage = URL(string: currentOrderViewModel.orderToRemove.car.carBrandImageUrl) else { return }
        currentOrderView.orderDetailsView.cityLabel.text = "ქალაქი: " + currentOrderViewModel.orderToRemove.city
        currentOrderView.orderDetailsView.dateLabel.text = "თარიღი: " + currentOrderViewModel.orderToRemove.date
        currentOrderView.orderDetailsView.timeLabel.text = "ასისტენტის მოსვლის პერიოდი: " + currentOrderViewModel.time
        currentOrderView.orderDetailsView.visualDamageLabel.text = "ვიზუალური დაზიანება: " + currentOrderViewModel.visualDamage
        currentOrderView.orderDetailsView.problemDescriptionTextView.text = currentOrderViewModel.orderToRemove.problemDescription
        currentOrderView.orderDetailsView.numberPlate.text = currentOrderViewModel.orderToRemove.car.plateNumber
        currentOrderView.orderDetailsView.carBrandImage.loadImage(from: carBrandImage)
    }
}

extension CurrentOrderVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isEqual(navigationController?.interactivePopGestureRecognizer) {
            navigationController?.popViewController(animated: true)
        }
        return false
    }
}

extension CurrentOrderVC: CancelButtonDelegate {
    func handleOrderIsDoneButton() {
        currentOrderViewModel.removeOrderWhenItsDone() { [weak self] success in
            if success {
                self?.navigationController?.popViewController(animated: true)
                print("Order Is Completed")
            } else {
                print("DEBUG: Can't Complete Order")
            }
        }
    }
    
    func handleCancelButton() {
        orderDeletion()
    }
    
    private func orderDeletion() {
        AlertManager.showDeleteConfirmation(on: self) { [weak self] didDelete in
            if (didDelete == true) {
                self?.currentOrderViewModel.removeOrderFromUser() { [weak self] success in
                    if success {
                        self?.navigationController?.popViewController(animated: true)
                    } else {
                        print("DEBUG: Can't Cancel Order")
                    }
                }
            }
        }
    }
}
