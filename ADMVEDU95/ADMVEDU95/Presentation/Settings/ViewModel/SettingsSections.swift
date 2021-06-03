//
//  SettingsSections.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 01.06.2021.
//

import Foundation

enum SettingsType {
    case framworkCell(model: FrameworkSectionData)
    //case coreDataCell(model: CoreDataSectionData)
}

struct SettingsSection {
    var sectionTitle: String
    var data: [SettingsType]
}

struct FrameworkSectionData: Codable {
    var frameworkTitle: String
    var framework: NetworkFrameworkSelected
}

//struct CoreDataSectionData: Codable {
//    var title: String
//    var isEnabled: Bool
//}
