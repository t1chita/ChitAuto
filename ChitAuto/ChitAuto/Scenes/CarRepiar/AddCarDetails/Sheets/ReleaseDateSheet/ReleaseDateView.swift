//
//  ReleaseDateView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 11.07.24.
//

import UIKit

final class ReleaseDateView: UIView {
    //MARK: - UIComponents
    private let titleLabel: TitlesCustomLabel = {
        let lbl = TitlesCustomLabel()
        lbl.text = "გამოშვები წელი"
        return lbl
    }()
    
    let releaseDateTableView: UITableView = {
        let tblView = UITableView()
        tblView.translatesAutoresizingMaskIntoConstraints = false
        tblView.register(ReleaseDateCell.self, forCellReuseIdentifier: ReleaseDateCell.identifier)
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
        addSubview(releaseDateTableView)
        
        NSLayoutConstraint.activate([
            releaseDateTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            releaseDateTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            releaseDateTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            releaseDateTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
