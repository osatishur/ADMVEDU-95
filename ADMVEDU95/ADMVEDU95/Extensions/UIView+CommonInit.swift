//
//  UIView+CommonInit.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 27.04.2021.
//

import UIKit

extension UIView {
    func commonInit(nibName: String) {
        let viewFromXib = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)!.first as? UIView
        guard let view = viewFromXib
        else {
            return
        }
        view.frame = self.bounds
        addSubview(view)
    }
}

