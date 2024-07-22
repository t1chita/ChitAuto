//
//  TransmissionTypeView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 12.07.24.
//

import UIKit

final class TransmissionTypeView: UIView {
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "გადაცემათა კოლოფი"
        lbl.textColor = .label
        lbl.font = .boldSystemFont(ofSize: 20)
        lbl.textAlignment = .center
        return lbl
    }()
    
    let transmissionTypeTableView: UITableView = {
        let tblView = UITableView()
        tblView.translatesAutoresizingMaskIntoConstraints = false
        tblView.register(TransmissionTypeCell.self, forCellReuseIdentifier: TransmissionTypeCell.identifier)
        tblView.separatorStyle = .none
        return tblView
    }()
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .customBackground
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        setupTitleLabel()
        setFuelTypeTableView()
    }
    
    //MARK: - Set UI Components
    private func setupTitleLabel() {
         addSubview(titleLabel)

        NSLayoutConstraint.activate([
             titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
             titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
         ])
     }
    
    private func setFuelTypeTableView() {
        addSubview(transmissionTypeTableView)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            transmissionTypeTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            transmissionTypeTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            transmissionTypeTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            transmissionTypeTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension TransmissionTypeView: ReloadDelegate {
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.transmissionTypeTableView.reloadData()
        }
    }
}

