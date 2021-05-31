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
    func getCellTitle(section: Int, row: Int) -> String
    func isFrameworkMatched(section: Int, row: Int) -> Bool
    func onCellSelected(section: Int, row: Int)
}

class SettingsPresenter: SettingsPresenterProtocol {
    weak var view: SettingsViewProtocol?
    private var router: HomeRouterProtocol?
    var networkFrameworkSelected: NetworkFrameworkSelected?
    private var dataSource = [SettingsSection(sectionTitle: "Network frameworks available",
                                              data:
                                [FrameworkSectionData(frameworkTitle: "Alamofire",
                                                      framework: NetworkFrameworkSelected.alamofire),
                                 FrameworkSectionData(frameworkTitle: "Moya",
                                                      framework: NetworkFrameworkSelected.moya)
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

    func getCellTitle(section: Int, row: Int) -> String {
        let title = dataSource[section].data[row].frameworkTitle
        return title
    }

    func isFrameworkMatched(section: Int, row: Int) -> Bool {
        let framework = dataSource[section].data[row].framework
        return framework == networkFrameworkSelected
    }

    func onCellSelected(section: Int, row: Int) {
        let frameworkSelected = dataSource[section].data[row].framework
        self.networkFrameworkSelected = frameworkSelected
        setNetworkOption()
        view?.updateView()
    }

    private func setNetworkOption() {
        UserDefaults.setNetworkFramework(framework: self.networkFrameworkSelected ?? .alamofire)
    }
}
