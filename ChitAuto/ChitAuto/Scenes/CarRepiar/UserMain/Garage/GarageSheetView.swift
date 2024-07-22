//
//  GarageSheetView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 09.07.24.
//

import UIKit


final class GarageSheetView: UIView {
    //MARK: - UIComponents
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "ჩემი გარაჟი"
        lbl.font = .boldSystemFont(ofSize: 20)
        lbl.textAlignment = .center
        return lbl
    }()
    
    let carsTableView: UITableView = {
        let tblView = UITableView()
        tblView.translatesAutoresizingMaskIntoConstraints = false
        tblView.register(CarCell.self, forCellReuseIdentifier: CarCell.identifier)
        tblView.separatorStyle = .none
        return tblView
    }()
    
    private let addCarButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "დაამატე მანქანა"
        configuration.image = UIImage(systemName: "plus.app")
        configuration.imagePlacement = .leading
        configuration.baseForegroundColor = .customLabel
        configuration.background.backgroundColor = .customCard
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Delegates
    weak var addCarDetailsPushableDelegate: AddCarDetailsPushableDelegate?
    weak var garageSheetDismissible: GarageSheetDismissible?
    
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
        setAddCarButton()
        setupTitleLabel()
        setCarsTableView()
    }
    
    //MARK: - Set UI Components
    private func setupTitleLabel() {
         addSubview(titleLabel)

        NSLayoutConstraint.activate([
             titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
             titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
         ])
     }
    
    private func setCarsTableView() {
        addSubview(carsTableView)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            carsTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            carsTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            carsTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            carsTableView.bottomAnchor.constraint(equalTo: addCarButton.topAnchor, constant: -10),
        ])
    }
    
    private func setAddCarButton() {
        addSubview(addCarButton)
        
        addCarButton.addAction(UIAction(title: "Go To Car Details Page", handler: {[weak self]  _ in
            self?.addCarDetailsPushableDelegate?.pushToAddCarDetailsPage()
            self?.garageSheetDismissible?.dismissGarageSheet()
        }), for: .touchUpInside)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            addCarButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 48),
            addCarButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -48),
            addCarButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            addCarButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
