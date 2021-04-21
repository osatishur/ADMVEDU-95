//
//  UIView+Anchor.swift
//  ADMVEDU95
//
//  Created by Satsishur on 19.04.2021.
//

import UIKit

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat = .zero,
                bottom: NSLayoutYAxisAnchor? = nil, paddingBottom: CGFloat = .zero,
                left: NSLayoutXAxisAnchor? = nil, paddingLeft: CGFloat = .zero,
                right: NSLayoutXAxisAnchor? = nil, paddingRight: CGFloat = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
    }
    
    func centerAnchor(centerX: NSLayoutXAxisAnchor? = nil, centerY: NSLayoutYAxisAnchor? = nil) {
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }
    
    func dimension(width: CGFloat, height: CGFloat) {
        if width != .zero {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != .zero {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
