//
//  SettindsPresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 27.05.2021.
//

import Foundation

protocol SettingsPresenterProtocol {
    func getSectionsCount() -> Int
    func getRowsInSectionCount(section: Int) -> Int
    func getSectionTitle(section: Int) -> String
    func isFrameworkMatched(framework: NetworkFrameworkSelected) -> Bool
    func onFrameworkCellSelected(framework: NetworkFrameworkSelected)
    func getCellType(section: Int, row: Int) -> SettingsType
}

class SettingsPresenter: SettingsPresenterProtocol {
    weak var view: SettingsViewProtocol?
    private var router: HomeRouterProtocol?
    var networkFrameworkSelected: NetworkFrameworkSelected?
    private var dataSource = [SettingsSection(sectionTitle: R.string.localizable.settingsNetworksAvailableSectionTitle(), data:
                                                [.framworkCell(model: FrameworkSectionData(frameworkTitle: "Alamofire",
                                                                         framework: NetworkFrameworkSelected.alamofire)),
                                                 .framworkCell(model: FrameworkSectionData(frameworkTitle: "Moya",
                                                                          framework: NetworkFrameworkSelected.moya))
                                                ])
    ]

    init(view: SettingsViewProtocol, router: HomeRouterProtocol) {
        self.view = view
        self.router = router
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
        return framework == networkFrameworkSelected
    }

    func onFrameworkCellSelected(framework: NetworkFrameworkSelected) {
        self.networkFrameworkSelected = framework
        setNetworkOption()
        view?.updateView()
    }

    private func setNetworkOption() {
        UserDefaults.setNetworkFramework(framework: self.networkFrameworkSelected ?? .alamofire)
    }
}
