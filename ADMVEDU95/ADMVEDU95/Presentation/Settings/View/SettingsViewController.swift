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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
    }
}

extension SettingsViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return presenter?.getSectionsCount() ?? 1
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter?.getSectionTitle()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getRowsInSectionCount(section: section) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath)
        cell.textLabel?.text = presenter?.getOptionTitle(row: indexPath.row)
        cell.accessoryType = (presenter?.isOptionsMatched(row: indexPath.row))! ? .checkmark : .none
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.networkOptionSelected(row: indexPath.row)
    }
}

extension SettingsViewController: SettingsViewProtocol {
    func updateView() {
        tableView.reloadData()
    }
}
