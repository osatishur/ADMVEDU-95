//
//  UITableViewCell+Identifiers.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 12.05.2021.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        let identifier = String(describing: self)
        return identifier
    }
}
