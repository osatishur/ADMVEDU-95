//
//  SettindsPresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 27.05.2021.
//

import Foundation

enum NetworkServiceSelected: String, CaseIterable {
    case alamofire = "Alamofire"
    case moya = "Moya"
}

protocol SettingsPresenterProtocol {
    var networkServiceSelected: NetworkServiceSelected? { get set }
    func getSectionsCount() -> Int
    func getRowsInSectionCount(section: Int) -> Int
    func getSectionTitle() -> String
    func getOptionTitle(row: Int) -> String
    func isOptionsMatched(row: Int) -> Bool
    func networkOptionSelected(row: Int)
}

class SettingsPresenter: SettingsPresenterProtocol {
    weak var view: SettingsViewProtocol?
    private var router: HomeRouterProtocol?
    var networkServiceSelected: NetworkServiceSelected?
    private var dataSource = [
        [
            (title: "Alamofire", option: NetworkServiceSelected.alamofire),
            (title: "Moya", option: NetworkServiceSelected.moya)
        ]
    ]

    init(view: SettingsViewProtocol, router: HomeRouterProtocol) {
        self.view = view
        self.router = router
    }

    func getSectionsCount() -> Int {
        return dataSource.count
    }

    func getRowsInSectionCount(section: Int) -> Int {
        return dataSource[section].count
    }

    func getSectionTitle() -> String {
        return "Network service options"
    }

    func getOptionTitle(row: Int) -> String {
        let optionSection = dataSource[0]
        let optionTitle = optionSection[row].title
        return optionTitle
    }

    func isOptionsMatched(row: Int) -> Bool {
        let optionSection = dataSource[0]
        let optionInRow = optionSection[row].option

        return optionInRow == networkServiceSelected
    }

    func networkOptionSelected(row: Int) {
        let optionSection = dataSource[0]
        let optionSelected = optionSection[row].option
        self.networkServiceSelected = optionSelected
        setNetworkOption()
        view?.updateView()
    }

    private func setNetworkOption() {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(self.networkServiceSelected?.rawValue, forKey: "networkOption")
    }
}
