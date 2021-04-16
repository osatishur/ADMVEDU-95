//
//  String+LocaliseMethod.swift
//  ADMVEDU95
//
//  Created by Satsishur on 16.04.2021.
//

import Foundation

extension String {
    func localise(key: String, argument: String) -> String {
        let str = String(format: NSLocalizedString(key, comment: ""), argument)
        return str
    }
}

