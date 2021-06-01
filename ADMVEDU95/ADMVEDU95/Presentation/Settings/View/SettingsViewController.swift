//
//  SettingsViewController.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 27.05.2021.
//

import UIKit

protocol SettingsViewProtocol: AnyObject {
    func updateView()
}

class SettingsViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    var presenter: SettingsPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }

    private func setupNavigationBar() {
        let title = R.string.localizable.settingsNavigationItemTitle()
        navigationItem.title = title
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let cellFramework = UINib(nibName: SettingsFrameworkCell.reuseIdentifier, bundle: nil)
        tableView.register(cellFramework, forCellReuseIdentifier: SettingsFrameworkCell.reuseIdentifier)
        let cellCoreData = UINib(nibName: SettingsCoreDataCell.reuseIdentifier, bundle: nil)
        tableView.register(cellCoreData, forCellReuseIdentifier: SettingsCoreDataCell.reuseIdentifier)
    }
}

extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.getSectionsCount() ?? 0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter?.getSectionTitle(section: section)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getRowsInSectionCount(section: section) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = presenter else {
            return UITableViewCell()
        }

        let type = presenter.getCellType(section: indexPath.section, row: indexPath.row)
        switch type {
        case .framworkCell(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsFrameworkCell.reuseIdentifier,
                                                           for: indexPath) as? SettingsFrameworkCell else {
                return UITableViewCell()
            }

            cell.configure(model: model)
            cell.accessoryType = (presenter.isFrameworkMatched(framework: model.framework)) ? .checkmark : .none
            return cell
        }
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let presenter = presenter else {
            return
        }
        let type = presenter.getCellType(section: indexPath.section, row: indexPath.row)
        switch type {
        case .framworkCell(let model):
            presenter.onFrameworkCellSelected(framework: model.framework)
        }
    }
}

extension SettingsViewController: SettingsViewProtocol {
    func updateView() {
        tableView.reloadData()
    }
}
