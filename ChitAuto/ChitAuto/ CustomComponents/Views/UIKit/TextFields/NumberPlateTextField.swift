//
//  NumberPlateTextField.swift
//  ChitAuto
//
//  Created by Temur Chitashvili on 12.07.24.
//


import UIKit

protocol NumberPlateTextFieldDelegate: AnyObject {
    func didChangeText(_ text: String)
}

final class NumberPlateTextField: UITextField {
    
    weak var numberPlateDelegate: NumberPlateTextFieldDelegate?
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup() {
        delegate = self
        addAction(UIAction(handler: { [weak self] _ in self?.textFieldDidChange() }), for: .editingChanged)
        autocapitalizationType = .allCharacters
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        placeholder = "XX-000-XX"
        textColor = .customLabel
        textAlignment = .center
        font = .systemFont(ofSize: 32, weight: .bold)
        backgroundColor = .customBackground
        setIcon(.carPlate)
    }
    
    // MARK: - Text formatting
    private func formatText(_ text: String) -> String {
        var formattedText = text.replacingOccurrences(of: "-", with: "")
        if formattedText.count > 2 {
            let startIndex = formattedText.startIndex
            let thirdIndex = formattedText.index(startIndex, offsetBy: 2)
            formattedText.insert("-", at: thirdIndex)
        }
        if formattedText.count > 6 {
            let startIndex = formattedText.startIndex
            let seventhIndex = formattedText.index(startIndex, offsetBy: 6)
            formattedText.insert("-", at: seventhIndex)
        }
        return String(formattedText.prefix(9)).uppercased()
    }
    
    private func isValidLicensePlate(_ text: String) -> Bool {
        let licensePlateRegex = "^[A-Z]{2}-[0-9]{3}-[A-Z]{2}$"
        let licensePlatePredicate = NSPredicate(format: "SELF MATCHES %@", licensePlateRegex)
        return licensePlatePredicate.evaluate(with: text)
    }
}

// MARK: - UITextFieldDelegate
extension NumberPlateTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = (textField.text ?? "") as NSString
        let updatedText = currentText.replacingCharacters(in: range, with: string).uppercased()
        
        // Limit input length
        if updatedText.count > 9 {
            return false
        }
        
        // Check for valid characters
        let validCharacters = CharacterSet.alphanumerics.union(CharacterSet(charactersIn: "-"))
        if string.rangeOfCharacter(from: validCharacters.inverted) != nil {
            return false
        }
        
        return true // Allow character insertion
    }
    
    func textFieldDidChange() {
        guard let text = self.text else { return }
        let formattedText = formatText(text)
        self.text = formattedText
        numberPlateDelegate?.didChangeText(formattedText)
    }
}
