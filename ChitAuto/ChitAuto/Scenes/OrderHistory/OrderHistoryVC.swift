//
//  OrderHistoryVC.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 22.07.24.
//

import UIKit

final class OrderHistoryVC: UIViewController {
    //MARK: - Properties
    private var orderHistoryView: OrderHistoryView
    var orderHistoryViewModel: OrderHistoryViewModel
    //MARK: - Initialization
    init(orderHistoryView: OrderHistoryView, orderHistoryViewModel: OrderHistoryViewModel) {
        self.orderHistoryView = orderHistoryView
        self.orderHistoryViewModel = orderHistoryViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - LifeCycles
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view = orderHistoryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleDelegates()
        setupUI()
        title = "შეკვეთების ისტორია"
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
        orderHistoryView.popViewControllerDelegate = self
        orderHistoryView.ordersTableView.delegate = self
        orderHistoryView.ordersTableView.dataSource = self
    }
    
    private func setNavigationItemsOnWelcomePage() {
        navigationItem.leftBarButtonItem = orderHistoryView.mainButton
    }
}

extension OrderHistoryVC: PopViewControllerDelegate {
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}
