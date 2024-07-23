//
//  OrderDetailsVC.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 23.07.24.
//

import UIKit

final class OrderDetailsVC: UIViewController {
    //MARK: - UIComponents
    private var orderDetailsView: OrderDetailsView
    private var orderDetailsViewModel: OrderDetailsViewModel
    
    //MARK: - Initialization
    init(orderDetailsView: OrderDetailsView, orderDetailsViewModel: OrderDetailsViewModel) {
        self.orderDetailsView = orderDetailsView
        self.orderDetailsViewModel = orderDetailsViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycles
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view = orderDetailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        setAssistantImage()
        setOrderDescription()
        setNavigationItems()
    }
    
    //MARK: - Set UI Components
    private func setAssistantImage() {
        guard let assistantImage = URL(string: orderDetailsViewModel.order.assistant.profilePicUrl) else { return }
        orderDetailsView.assistantImageView.loadImage(from: assistantImage)
    }
    
    private func setOrderDescription() {
        guard let carBrandImage = URL(string: orderDetailsViewModel.order.car.carBrandImageUrl) else { return }
        orderDetailsView.cityLabel.text = "ქალაქი: " + orderDetailsViewModel.order.city
        orderDetailsView.dateLabel.text = "თარიღი: " + orderDetailsViewModel.order.date
        orderDetailsView.timeLabel.text = "ასისტენტის მოსვლის პერიოდი: " + orderDetailsViewModel.time
        orderDetailsView.visualDamageLabel.text = "ვიზუალური დაზიანება: " + orderDetailsViewModel.visualDamage
        orderDetailsView.problemDescriptionTextView.text = orderDetailsViewModel.order.problemDescription
        orderDetailsView.numberPlate.text = orderDetailsViewModel.order.car.plateNumber
        orderDetailsView.carBrandImage.loadImage(from: carBrandImage)
    }
    
    private func setNavigationItems() {
        navigationItem.setHidesBackButton(true, animated: true)
        title = "შეკვეთის ისტორია"
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}

extension OrderDetailsVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isEqual(navigationController?.interactivePopGestureRecognizer) {
            navigationController?.popViewController(animated: true)
        }
        return false
    }
}
