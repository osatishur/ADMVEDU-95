//
//  SettingsFrameworkCell.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 01.06.2021.
//

import UIKit

class SettingsFrameworkCell: UITableViewCell {
    func configure(model: FrameworkSectionData) {
        self.textLabel?.text = model.frameworkTitle
    }
}
