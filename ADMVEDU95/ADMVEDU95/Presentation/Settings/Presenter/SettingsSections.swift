//
//  SettingsSections.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 01.06.2021.
//

import Foundation

struct SettingsSection<T: Codable> {
    var sectionTitle: String
    var data: [T]
}

struct FrameworkSectionData: Codable {
    var frameworkTitle: String
    var framework: NetworkFrameworkSelected
}
