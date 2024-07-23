//
//  OrderHistoryView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 22.07.24.
//

import UIKit

final class OrderHistoryView: UIView {
    //MARK: - UIComponents
    lazy var mainButton: UIBarButtonItem = {
        let customButton = UIButton()
        customButton.addAction(UIAction(title: "Go To Welcome Page", handler: { [weak self] _ in
            self?.popViewControllerDelegate?.popViewController()
        }), for: .touchUpInside)
        customButton.setImage(.mainButton, for: .normal)
        let button = UIBarButtonItem(customView: customButton)
        return button
    }()
    let ordersTableView: UITableView = {
        let tblView = UITableView()
        tblView.translatesAutoresizingMaskIntoConstraints = false
        tblView.register(OrdersCell.self, forCellReuseIdentifier: OrdersCell.identifier)
        tblView.separatorStyle = .none
        tblView.backgroundColor = .clear
        tblView.rowHeight = UITableView.automaticDimension
        return tblView
    }()
    
    //MARK: - Delegates
    weak var popViewControllerDelegate: PopViewControllerDelegate?
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        backgroundColor = .customBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    //MARK: - Setup UI
    private func setupUI() {
        setOrdersTableView()
    }
    //MARK: - Set UI Components
    private func setOrdersTableView() {
        addSubview(ordersTableView)
        
        NSLayoutConstraint.activate([
            ordersTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            ordersTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            ordersTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            ordersTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
