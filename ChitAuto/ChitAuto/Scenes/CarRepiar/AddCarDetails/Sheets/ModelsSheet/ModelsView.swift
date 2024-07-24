//
//  ModelsView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 11.07.24.
//

import UIKit

final class ModelsView: UIView {
    //MARK: - UIComponents
    private let titleLabel: TitlesCustomLabel = {
        let lbl = TitlesCustomLabel()
        lbl.text = "მოდელი"
        return lbl
    }()
    
    let modelsTableView: UITableView = {
        let tblView = UITableView()
        tblView.translatesAutoresizingMaskIntoConstraints = false
        tblView.register(ModelsCell.self, forCellReuseIdentifier: ModelsCell.identifier)
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
        addSubview(modelsTableView)
        
        NSLayoutConstraint.activate([
            modelsTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            modelsTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            modelsTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            modelsTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension ModelsView: ReloadDelegate {
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.modelsTableView.reloadData()
        }
    }
}
