//
//  CustomStackView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 07.07.24.
//

import UIKit

final class CustomStackView: UIStackView {
    var titleText: String = "" {
          didSet {
              title.text = titleText
          }
      }
    
      var descrText: String = "" {
          didSet {
              descr.text = descrText
          }
      }
    
      var iconString: String = "" {
          didSet {
              iconImage.image = UIImage(systemName: iconString)
          }
      }
    
    private let textsStackView: UIStackView = {
        let stView = UIStackView()
        stView.axis = .vertical
        stView.alignment = .leading
        return stView
    }()
    
    private var title: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 18, weight: .bold)
        lbl.textColor = .label
        return lbl
    }()
    
    private var descr: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 16, weight: .regular)
        lbl.textColor = .customLabel
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private var iconImage: UIImageView = {
        let imView = UIImageView()
        imView.contentMode = .scaleAspectFit
        imView.tintColor = .black
        return imView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        configureUIComponents()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setTextsStackView()
        axis = .horizontal
        distribution = .fill
        spacing = 5
        addArrangedSubview(iconImage)
        addArrangedSubview(textsStackView)
    }
    
    private func setTextsStackView() {
        textsStackView.addArrangedSubview(title)
        textsStackView.addArrangedSubview(descr)
    }
    
    private func configureUIComponents() {
        title.text = titleText
        descr.text = descrText
        iconImage.image = UIImage(systemName: iconString)
    }
}
