//
//  String+Localise.swift
//  ADMVEDU95
//
//  Created by Satsishur on 19.04.2021.
//

import UIKit

extension String {
    func localized() -> String {
        let localizedString = NSLocalizedString(self, comment: "")
        return localizedString
    }
}
