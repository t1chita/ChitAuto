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
    
    private var assistantNumber: GeneralLabel = {
        let lbl = GeneralLabel()
        lbl.backgroundColor = .customBackground
        lbl.layer.masksToBounds = true
        lbl.text = "📲 +995597050897"
        lbl.layer.cornerRadius = 4
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let assistantImage: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.layer.masksToBounds = true
        imgView.layer.cornerRadius = 35
        return imgView
    }()
    
    private lazy var assistantNameLabel: GeneralLabel = {
        let lbl = GeneralLabel()
        lbl.backgroundColor = .customCard
        lbl.layer.masksToBounds = true
        lbl.layer.cornerRadius = 4
        lbl.textAlignment = .center
        return lbl
    }()
    
    weak var orderStatusButtonDelegate: OrderStatusDelegate?
    
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
        setAssistantImage()
        setAssistantNameLabel()
        setCellContentView()
    }
    
    
    private func setCellContentView() {
        addSubview(cellContentView)
        
        NSLayoutConstraint.activate([
            cellContentView.topAnchor.constraint(equalTo: topAnchor),
            cellContentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellContentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cellContentView.heightAnchor.constraint(equalToConstant: 140),
            cellContentView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setOrderContentBackground() {
        cellContentView.addSubview(orderCardBackground)
        
        NSLayoutConstraint.activate([
            orderCardBackground.topAnchor.constraint(equalTo: cellContentView.topAnchor, constant: 10),
            orderCardBackground.leadingAnchor.constraint(equalTo: cellContentView.leadingAnchor),
            orderCardBackground.trailingAnchor.constraint(equalTo: cellContentView.trailingAnchor),
            orderCardBackground.bottomAnchor.constraint(equalTo: cellContentView.bottomAnchor, constant: -10),
        ])
    }
    
    private func setAssistantNumber() {
        orderCardBackground.addSubview(assistantNumber)
        
        NSLayoutConstraint.activate([
            assistantNumber.topAnchor.constraint(equalTo: orderCardBackground.topAnchor, constant: 34),
            assistantNumber.trailingAnchor.constraint(equalTo: orderCardBackground.trailingAnchor, constant: -24),
            assistantNumber.widthAnchor.constraint(equalToConstant: 180),
            assistantNumber.heightAnchor.constraint(equalToConstant: 36),
        ])
    }
    
    private func setAssistantNameLabel() {
        orderCardBackground.addSubview(assistantNameLabel)
        
        NSLayoutConstraint.activate([
            assistantNameLabel.topAnchor.constraint(equalTo: assistantNumber.bottomAnchor),
            assistantNameLabel.trailingAnchor.constraint(equalTo: assistantNumber.trailingAnchor),
            assistantNameLabel.heightAnchor.constraint(equalToConstant: 36),
        ])
    }
    
    private func setAssistantImage() {
        orderCardBackground.addSubview(assistantImage)
        
        NSLayoutConstraint.activate([
            assistantImage.centerYAnchor.constraint(equalTo: assistantNumber.centerYAnchor),
            assistantImage.leadingAnchor.constraint(equalTo: orderCardBackground.leadingAnchor, constant: 24),
            assistantImage.widthAnchor.constraint(equalToConstant: 70),
            assistantImage.heightAnchor.constraint(equalToConstant: 70),
        ])
    }
}
