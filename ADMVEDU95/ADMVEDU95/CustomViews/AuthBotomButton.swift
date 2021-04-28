//
//  AuthBotomButton.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 23.04.2021.
//

import UIKit

class AuthBotomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    private func setupLayout() {
        layer.cornerRadius = CGFloat.regularCornerRadius
        setTitleColor(.white, for: .normal)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account?  ".localized(), attributes: [NSAttributedString.Key.font: UIFont.regularFont, NSAttributedString.Key.foregroundColor: UIColor.black])
        attributedTitle.append(NSAttributedString(string: "Sign in".localized(), attributes: [NSAttributedString.Key.font: UIFont.regularFont, NSAttributedString.Key.foregroundColor: UIColor.systemBlue]))
        setAttributedTitle(attributedTitle, for: .normal)
    }

}
