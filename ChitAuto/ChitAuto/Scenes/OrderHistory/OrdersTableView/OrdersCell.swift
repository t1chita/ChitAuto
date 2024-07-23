//
//  OrdersCell.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 23.07.24.
//

import UIKit

final class OrdersCell: UITableViewCell {
    static let identifier: String = "OrdersCell"
    //MARK: - UIComponents
    private var cellContentView: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .clear
        return vw
    }()
    
    private var orderCardBackground: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .customCard
        vw.clipsToBounds = true
        vw.layer.cornerRadius = 22
        return vw
    }()
    
    private var assistantNumber: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 16, weight: .bold)
        lbl.textColor = .customLabel
        lbl.backgroundColor = .customBackground
        lbl.layer.masksToBounds = true
        lbl.text = "📲 +995597050897"
        lbl.layer.cornerRadius = 4
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let assistantContentBackground: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .customBackground
        vw.clipsToBounds = true
        vw.layer.cornerRadius = 22
        return vw
    }()
    
    private let assistantImage: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.layer.masksToBounds = true
        imgView.layer.cornerRadius = 35
        return imgView
    }()
    
    private lazy var assistantNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 16, weight: .bold)
        lbl.textColor = .customLabel
        lbl.backgroundColor = .customCard
        lbl.layer.masksToBounds = true
        lbl.layer.cornerRadius = 4
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var orderStatusButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "დეტალები"
        configuration.image = UIImage(systemName: "chevron.right")
        configuration.imagePlacement = .trailing
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
        configuration.titleAlignment = .leading
        configuration.baseForegroundColor = .customLabel
        configuration.background.backgroundColor = .customCard
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .fill
        return button
    }()
    
    private lazy var orderStatusLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 16, weight: .bold)
        lbl.textColor = .customLabel
        lbl.textAlignment = .center
        lbl.text = "შეკვეთა ჩაბარებულია✅"
        return lbl
    }()
    
    weak var orderStatusButtonDelegate: OrderStatusButtonDelegate?
    
    //MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    func configure(withAssistantName name: String,
                   imageUrl: String
    ) {
        guard let assistantImageUrl = URL(string: imageUrl) else { return }
        assistantImage.loadImage(from: assistantImageUrl)
        assistantNameLabel.text = name
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        setOrderContentBackground()
        setAssistantNumber()
        setAssistantContentBackground()
        setAssistantImage()
        setAssistantNameLabel()
        setOrderStatusButton()
        setOrderStatusLabel()
        setCellContentView()
    }
    
    
    private func setCellContentView() {
        addSubview(cellContentView)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            cellContentView.topAnchor.constraint(equalTo: topAnchor),
            cellContentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellContentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cellContentView.heightAnchor.constraint(equalToConstant: 310),
            cellContentView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
     
    
    private func setOrderContentBackground() {
        cellContentView.addSubview(orderCardBackground)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            orderCardBackground.topAnchor.constraint(equalTo: cellContentView.topAnchor, constant: 10),
            orderCardBackground.leadingAnchor.constraint(equalTo: cellContentView.leadingAnchor),
            orderCardBackground.trailingAnchor.constraint(equalTo: cellContentView.trailingAnchor),
            orderCardBackground.bottomAnchor.constraint(equalTo: cellContentView.bottomAnchor, constant: -10),
        ])
    }
    
    private func setAssistantContentBackground() {
        orderCardBackground.addSubview(assistantContentBackground)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            assistantContentBackground.topAnchor.constraint(equalTo: orderCardBackground.topAnchor, constant: 100),
            assistantContentBackground.leadingAnchor.constraint(equalTo: orderCardBackground.leadingAnchor, constant: 12),
            assistantContentBackground.trailingAnchor.constraint(equalTo: orderCardBackground.trailingAnchor, constant: -12),
            assistantContentBackground.bottomAnchor.constraint(equalTo: orderCardBackground.bottomAnchor, constant: -12),
        ])
    }
    
    private func setAssistantNumber() {
        orderCardBackground.addSubview(assistantNumber)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            assistantNumber.topAnchor.constraint(equalTo: orderCardBackground.topAnchor, constant: 34),
            assistantNumber.trailingAnchor.constraint(equalTo: orderCardBackground.trailingAnchor, constant: -24),
            assistantNumber.widthAnchor.constraint(equalToConstant: 180),
            assistantNumber.heightAnchor.constraint(equalToConstant: 36),
        ])
    }
    
    private func setAssistantNameLabel() {
        assistantContentBackground.addSubview(assistantNameLabel)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            assistantNameLabel.topAnchor.constraint(equalTo: assistantContentBackground.topAnchor, constant: 16),
            assistantNameLabel.trailingAnchor.constraint(equalTo: assistantContentBackground.trailingAnchor, constant: -30),
            assistantNameLabel.leadingAnchor.constraint(equalTo: assistantContentBackground.leadingAnchor, constant: 30),
            assistantNameLabel.heightAnchor.constraint(equalToConstant: 36),
        ])
    }
    
    private func setOrderStatusLabel() {
        assistantContentBackground.addSubview(orderStatusLabel)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            orderStatusLabel.topAnchor.constraint(equalTo: assistantNameLabel.bottomAnchor, constant: 10),
            orderStatusLabel.centerXAnchor.constraint(equalTo: assistantContentBackground.centerXAnchor),
            orderStatusLabel.heightAnchor.constraint(equalToConstant: 36),
        ])
    }
    
    private func setAssistantImage() {
        orderCardBackground.addSubview(assistantImage)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            assistantImage.centerYAnchor.constraint(equalTo: assistantNumber.centerYAnchor),
            assistantImage.leadingAnchor.constraint(equalTo: orderCardBackground.leadingAnchor, constant: 24),
            assistantImage.widthAnchor.constraint(equalToConstant: 70),
            assistantImage.heightAnchor.constraint(equalToConstant: 70),
        ])
    }
    
    private func setOrderStatusButton() {
        assistantContentBackground.addSubview(orderStatusButton)
        
        orderStatusButton.addAction(UIAction(title: "Go To Current Order Page", handler: {[weak self] _ in
            self?.orderStatusButtonDelegate?.handleOrderStatusButton()
        }), for: .touchUpInside)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            orderStatusButton.bottomAnchor.constraint(equalTo: assistantContentBackground.bottomAnchor, constant: -16),
            orderStatusButton.leadingAnchor.constraint(equalTo: assistantContentBackground.leadingAnchor, constant: 24),
            orderStatusButton.trailingAnchor.constraint(equalTo: assistantContentBackground.trailingAnchor, constant: -24),
        ])
    }
}
