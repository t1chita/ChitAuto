//
//  BrandsAndModelsSheetsView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 10.07.24.
//

import UIKit

final class BrandsSheetsView: UIView {
    //MARK: - UIComponents
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "მწარმოებელი"
        lbl.textColor = .label
        lbl.font = .boldSystemFont(ofSize: 20)
        lbl.textAlignment = .center
        return lbl
    }()
    
    let brandsTableView: UITableView = {
        let tblView = UITableView()
        tblView.translatesAutoresizingMaskIntoConstraints = false
        tblView.register(BrandsCell.self, forCellReuseIdentifier: BrandsCell.identifier)
        tblView.separatorStyle = .none
        return tblView
    }()
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        setupTitleLabel()
        setBrandsTableView()
    }
    
    //MARK: - Set UI Components
    private func setupTitleLabel() {
         addSubview(titleLabel)

        NSLayoutConstraint.activate([
             titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
             titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
         ])
     }
    
    private func setBrandsTableView() {
        addSubview(brandsTableView)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            brandsTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            brandsTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            brandsTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            brandsTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension BrandsSheetsView: ReloadDelegate {
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.brandsTableView.reloadData()
        }
    }
}
