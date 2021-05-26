//
//  XibView.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 29.04.2021.
//

import UIKit

class XibView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
}
