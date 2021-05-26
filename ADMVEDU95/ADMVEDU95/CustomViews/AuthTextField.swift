//
//  AuthTextField.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 04.05.2021.
//

import UIKit

class AuthTextField: UITextField {
    private enum Constants {
        static let sideWidth: CGFloat = 20
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }

    private func setupLayout() {
        leftView = UIView(frame: CGRect(x: .zero,
                                        y: .zero,
                                        width: Constants.sideWidth,
                                        height: frame.height))
        leftViewMode = .always
        rightView = UIView(frame: CGRect(x: .zero,
                                         y: .zero,
                                         width: Constants.sideWidth,
                                         height: frame.height))
        rightViewMode = .always
        layer.cornerRadius = CGFloat.regularCornerRadius
        font = UIFont.regularFont
        backgroundColor = UIColor.textFieldAuth
    }
}
