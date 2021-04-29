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
        let viewFromXib = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView
        guard let view = viewFromXib else {
            return
        }
        view.frame = self.bounds
        addSubview(view)
    }
}

//extension UIView {
//    class func fromNib<T: UIView>() -> T {
//        let view = Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)?.first as? T ?? T()
//        view.frame = T.self.bound
//        return view
//    }
//}

