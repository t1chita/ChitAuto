//
//  OnBoardingView.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 02.07.24.
//

import UIKit

protocol NavigateToSignInSignUpPageDelegate: AnyObject {
    func navigateToSignIn()
    func navigateToSignUp()
}

final class OnBoardingView: UIView {
    //MARK: - UIComponents
    private let appLogo: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(resource: .logo)
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    let registrationButton: CustomGeneralButton = {
        let button = CustomGeneralButton()
        button.backgroundColor = .customCard
        return button
    }()
    
    private let signInStackView: UIStackView = {
        let stView = UIStackView()
        stView.translatesAutoresizingMaskIntoConstraints = false
        stView.distribution = .fillProportionally
        stView.axis = .horizontal
        return stView
    }()
    
    let signInLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 16, weight: .regular)
        lbl.textColor = .customLabel
        lbl.textAlignment = .center
        return lbl
    }()
    
    let signInButton: UIButton = {
        let underlineAttributeString = NSAttributedString(string: "attriString",
                                                          attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        let button = UIButton()
        button.titleLabel?.attributedText = underlineAttributeString
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.contentHorizontalAlignment = .leading
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    //MARK: - Delegates
    weak var navigationDelegate: NavigateToSignInSignUpPageDelegate?
    
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
        setAppLogo()
        setRegistrationButton()
        setSignInStackView()
    }
    
    //MARK: - Set UI Components
    private func setAppLogo() {
        addSubview(appLogo)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            appLogo.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            appLogo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            appLogo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            appLogo.heightAnchor.constraint(equalToConstant: 400),
        ])
    }
    
    private func setRegistrationButton() {
        addSubview(registrationButton)
        
        //Add Action To Registration Button
        registrationButton.addAction(UIAction(title: "Go To Sign In Page", handler: { [weak self] _ in
            self?.navigationDelegate?.navigateToSignUp()
        }), for: .touchUpInside)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            registrationButton.topAnchor.constraint(equalTo: appLogo.bottomAnchor, constant: 50),
            registrationButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            registrationButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            registrationButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
    
    private func setSignInStackView() {
        addSubview(signInStackView)
        
        //Add Arranged Subviews
        signInStackView.addArrangedSubview(signInLabel)
        signInStackView.addArrangedSubview(signInButton)
        
        //Add Action To Sign In Button
        signInButton.addAction(UIAction(title: "Go To Sign In Page", handler: { [weak self] _ in
            self?.navigationDelegate?.navigateToSignIn()
        }), for: .touchUpInside)
        
        //Set Constraints
        NSLayoutConstraint.activate([
            signInStackView.topAnchor.constraint(equalTo: registrationButton.bottomAnchor, constant: 16),
            signInStackView.centerXAnchor.constraint(equalTo: registrationButton.centerXAnchor),
            signInStackView.widthAnchor.constraint(equalTo: registrationButton.widthAnchor, multiplier: 0.9),
            signInStackView.heightAnchor.constraint(equalToConstant: 27),
        ])
    }
}
