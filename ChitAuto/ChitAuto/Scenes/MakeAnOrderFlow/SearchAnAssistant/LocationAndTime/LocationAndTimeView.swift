//
//  LocationAndTimeView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 15.07.24.
//

import UIKit

final class LocationAndTimeView: UIView {
    //MARK: - UIComponents
    private let scrollView: UIScrollView = {
        let scrView = UIScrollView()
        scrView.translatesAutoresizingMaskIntoConstraints = false
        scrView.showsVerticalScrollIndicator = false
        return scrView
    }()
    
    private let contentView: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
    private let carInfoBackground: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.layer.cornerRadius = 20
        vw.backgroundColor = .customCard
        return vw
    }()
    
    private let locationTitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 16, weight: .regular)
        lbl.numberOfLines = 0
        lbl.textColor = .customLabel
        lbl.textAlignment = .left
        lbl.text = "სად მოვიდეს ავტოასისტენტი?"
        return lbl
    }()
    
    let citiesButton: CarInfoButton = {
        let button = CarInfoButton()
        return button
    }()
    
    private let addressTitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 16, weight: .regular)
        lbl.numberOfLines = 0
        lbl.textColor = .customLabel
        lbl.textAlignment = .left
        lbl.text = "ჩაწერეთ ზუსტი მისამართი"
        return lbl
    }()
    
    private let addressTextField: MyTextFieldWithPadding = {
        let textField = MyTextFieldWithPadding()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "მაგ: ვარკეთილი,მე-3 მკრ..."
        textField.backgroundColor = .customBackground
        textField.layer.cornerRadius = 6
        return textField
    }()
    
    private let dayTitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 16, weight: .regular)
        lbl.numberOfLines = 0
        lbl.textColor = .customLabel
        lbl.textAlignment = .left
        lbl.text = "როდის მოვიდეს?"
        return lbl
    }()
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .date
        picker.tintColor = .customLabel
        picker.minimumDate = Date()
        return picker
    }()
    
    private let timeTitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 16, weight: .regular)
        lbl.numberOfLines = 0
        lbl.textColor = .customLabel
        lbl.textAlignment = .left
        lbl.text = "დღის რომელ მონაკვეთში?"
        return lbl
    }()
    
    let timeButton: CarInfoButton = {
        let button = CarInfoButton()
        return button
    }()
    
    let bottomButtonsStackView: BottomButtonsStackView = {
        let stView = BottomButtonsStackView()
        stView.saveButton.setTitle("შემდეგი", for: .normal)
        return stView
    }()
    //MARK: - Delegates
    weak var dateChoseDelegate: DateChoseDelegate?
    
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
        setScrollView()
        setContentView()
        
        setCarInfoBackground()
        
        setLocationTitle()
        setCitiesButton()
        setAddressTitle()
        setAddressTextField()
        setDayTitle()
        setDatePicker()
        setTimeTitle()
        setTimeButton()
        setBottomButtonsStackView()
    }
    //MARK: - Set UI Components
    private func setScrollView() {
        addSubview(scrollView)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func setContentView() {
        scrollView.addSubview(contentView)
        let heightAnchor = contentView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor)
        heightAnchor.priority = .defaultHigh
        
        //Set Constraints
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            heightAnchor
        ])
    }
    
    private func setCarInfoBackground() {
        contentView.addSubview(carInfoBackground)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            carInfoBackground.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -100),
            carInfoBackground.heightAnchor.constraint(equalToConstant: 450),
            carInfoBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            carInfoBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
        ])
    }
    
    private func setLocationTitle() {
        carInfoBackground.addSubview(locationTitle)
        
        NSLayoutConstraint.activate([
            locationTitle.topAnchor.constraint(equalTo: carInfoBackground.topAnchor, constant: 16),
            locationTitle.leadingAnchor.constraint(equalTo: carInfoBackground.leadingAnchor, constant: 16),
            locationTitle.heightAnchor.constraint(equalToConstant: 20),
            ])
    }
    
    private func setCitiesButton() {
        carInfoBackground.addSubview(citiesButton)
        
        
        NSLayoutConstraint.activate([
            citiesButton.topAnchor.constraint(equalTo: locationTitle.bottomAnchor, constant: 16),
            citiesButton.leadingAnchor.constraint(equalTo: carInfoBackground.leadingAnchor, constant: 16),
            citiesButton.trailingAnchor.constraint(equalTo: carInfoBackground.trailingAnchor, constant: -16),

        ])
    }
    
    private func setAddressTitle() {
        carInfoBackground.addSubview(addressTitle)
        
        NSLayoutConstraint.activate([
            addressTitle.topAnchor.constraint(equalTo: citiesButton.bottomAnchor, constant: 16),
            addressTitle.leadingAnchor.constraint(equalTo: locationTitle.leadingAnchor),
            addressTitle.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    private func setAddressTextField() {
        carInfoBackground.addSubview(addressTextField)
        
        NSLayoutConstraint.activate([
            addressTextField.topAnchor.constraint(equalTo: addressTitle.bottomAnchor, constant: 16),
            
            addressTextField.leadingAnchor.constraint(equalTo: citiesButton.leadingAnchor),
            addressTextField.trailingAnchor.constraint(equalTo: citiesButton.trailingAnchor),
            addressTextField.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func setDayTitle() {
        carInfoBackground.addSubview(dayTitle)
        
        NSLayoutConstraint.activate([
            dayTitle.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 16),
            dayTitle.leadingAnchor.constraint(equalTo: locationTitle.leadingAnchor),
            dayTitle.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    private func setDatePicker() {
        carInfoBackground.addSubview(datePicker)
        
        datePicker.addAction(UIAction(title: "Handle Choosing Date", handler: {[weak self] _ in
            self?.dateChoseDelegate?.dateValueChanged()
        }), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: dayTitle.bottomAnchor, constant: 16),
            datePicker.leadingAnchor.constraint(equalTo: citiesButton.leadingAnchor),
            datePicker.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func setTimeTitle() {
        carInfoBackground.addSubview(timeTitle)
        
        NSLayoutConstraint.activate([
            timeTitle.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 16),
            timeTitle.leadingAnchor.constraint(equalTo: locationTitle.leadingAnchor),
            timeTitle.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    private func setTimeButton() {
        carInfoBackground.addSubview(timeButton)
        
        NSLayoutConstraint.activate([
            timeButton.topAnchor.constraint(equalTo: timeTitle.bottomAnchor, constant: 16),
            timeButton.leadingAnchor.constraint(equalTo: carInfoBackground.leadingAnchor, constant: 16),
            timeButton.trailingAnchor.constraint(equalTo: carInfoBackground.trailingAnchor, constant: -16),
        ])
    }
    
    private func setBottomButtonsStackView() {
        carInfoBackground.addSubview(bottomButtonsStackView)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            bottomButtonsStackView.topAnchor.constraint(equalTo: timeButton.bottomAnchor, constant: 12),
            bottomButtonsStackView.leadingAnchor.constraint(equalTo: citiesButton.leadingAnchor),
            bottomButtonsStackView.trailingAnchor.constraint(equalTo: citiesButton.trailingAnchor),
            bottomButtonsStackView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}

class MyTextFieldWithPadding: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
