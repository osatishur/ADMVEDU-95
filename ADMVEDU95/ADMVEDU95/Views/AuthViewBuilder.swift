//
//  AuthViewBuilder.swift
//  ADMVEDU95
//
//  Created by Satsishur on 20.04.2021.
//

import UIKit

protocol AuthViewBuilder {
    func buildTextField(placegolder: String, isSecureTextEnter: Bool, sideWidth: CGFloat) -> UITextField
    func buildLabel(text: String, font: UIFont) -> UILabel
    func buildButton(title: String, titleColor: UIColor, backgroundColor: UIColor, font: UIFont?) -> UIButton
}

extension AuthViewBuilder {
    func buildTextField(placegolder: String, isSecureTextEnter: Bool, sideWidth: CGFloat) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leftView = UIView(frame: CGRect(x: .zero,
                                                  y: .zero,
                                                  width: sideWidth,
                                                  height: textField.frame.height))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: .zero,
                                                   y: .zero,
                                                   width: sideWidth,
                                                   height: textField.frame.height))
        textField.rightViewMode = .always
        textField.layer.cornerRadius = CGFloat.regularCornerRadius
        textField.placeholder = placegolder
        textField.isSecureTextEntry = isSecureTextEnter
        textField.font = UIFont.regularFont
        textField.backgroundColor = UIColor.textFieldAuth
        return textField
    }
    
    func buildLabel(text: String, font: UIFont) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = font
        label.textAlignment = .center
        label.numberOfLines = .zero
        return label
    }
    
    func buildButton(title: String, titleColor: UIColor, backgroundColor: UIColor, font: UIFont? = UIFont.regularFont) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = CGFloat.regularCornerRadius
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = font
        button.backgroundColor = backgroundColor
        return button
    }
}
