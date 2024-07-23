//
//  TimeSheetView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 17.07.24.
//

import UIKit

final class TimeSheetView: UIView {
    //MARK: - UIComponents
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "დღის მონაკვეთი"
        lbl.textColor = .label
        lbl.font = .boldSystemFont(ofSize: 20)
        lbl.textAlignment = .center
        return lbl
    }()
    
    let timeTableView: UITableView = {
        let tblView = UITableView()
        tblView.translatesAutoresizingMaskIntoConstraints = false
        tblView.register(TimeCell.self, forCellReuseIdentifier: TimeCell.identifier)
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
        setModelsTableView()
    }
    
    //MARK: - Set UI Components
    private func setupTitleLabel() {
         addSubview(titleLabel)

        NSLayoutConstraint.activate([
             titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
             titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
         ])
     }
    
    private func setModelsTableView() {
        addSubview(timeTableView)
        
        NSLayoutConstraint.activate([
            timeTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            timeTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            timeTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            timeTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

