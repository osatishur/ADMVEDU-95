//
//  SettingsViewModel.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 02.06.2021.
//

import UIKit

protocol SettingsViewModelProtocol {
    func getSectionsCount() -> Int
    func getRowsInSectionCount(section: Int) -> Int
    func getSectionTitle(section: Int) -> String
    func isFrameworkMatched(framework: NetworkFrameworkSelected) -> Bool
    func onFrameworkCellSelected(framework: NetworkFrameworkSelected)
    func getCellType(section: Int, row: Int) -> SettingsType
    var networkFrameworkSelected: Observable<NetworkFrameworkSelected>? { get set }
}

class SettingsViewModel: SettingsViewModelProtocol {
    private var router: HomeRouterProtocol?
    var networkFrameworkSelected: Observable<NetworkFrameworkSelected>?
    private var dataSource = [SettingsSection(sectionTitle: R.string.localizable.settingsNetworksAvailableSectionTitle(), data:
                                                [.framworkCell(model: FrameworkSectionData(frameworkTitle: "Alamofire",
                                                                         framework: NetworkFrameworkSelected.alamofire)),
                                                 .framworkCell(model: FrameworkSectionData(frameworkTitle: "Moya",
                                                                          framework: NetworkFrameworkSelected.moya))
                                                ])
    ]

    init(router: HomeRouterProtocol, networkFrameworkSelected: NetworkFrameworkSelected) {
        self.router = router
        self.networkFrameworkSelected = Observable(value: networkFrameworkSelected)
    }

    func getSectionsCount() -> Int {
        return dataSource.count
    }

    func getRowsInSectionCount(section: Int) -> Int {
        return dataSource[section].data.count
    }

    func getSectionTitle(section: Int) -> String {
        return dataSource[section].sectionTitle
    }

    func getCellType(section: Int, row: Int) -> SettingsType {
        let type = dataSource[section].data[row]
        return type
    }

    func isFrameworkMatched(framework: NetworkFrameworkSelected) -> Bool {
        return framework == networkFrameworkSelected?.value
    }

    func onFrameworkCellSelected(framework: NetworkFrameworkSelected) {
        self.networkFrameworkSelected?.value = framework
        setNetworkOption()
    }

    private func setNetworkOption() {
        UserDefaults.setNetworkFramework(framework: self.networkFrameworkSelected?.value ?? .alamofire)
    }
}
