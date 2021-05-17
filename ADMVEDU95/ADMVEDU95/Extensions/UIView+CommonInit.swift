//
//  UIView+CommonInit.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 27.04.2021.
//

import UIKit

extension UIView {
    func commonInit() {
        let nibName = String(describing: type(of: self))
        guard let viewFromXib = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView else {
            return
        }
        viewFromXib.frame = bounds
        addSubview(viewFromXib)
    }
}
