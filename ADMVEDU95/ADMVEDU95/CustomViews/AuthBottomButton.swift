//
//  AuthBottomButton.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 23.04.2021.
//

import UIKit

class AuthBottomButton: UIButton {
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
    }
}
