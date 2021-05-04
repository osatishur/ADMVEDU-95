//
//  HomeVC+TableViewMethods.swift
//  FirstWorkProject
//
//  Created by Satsishur on 14.04.2021.
//

import UIKit

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getNumberOfResults() ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifire, for: indexPath) as? SearchTableViewCell
        guard let presenter = presenter,
              let cell = cell else {
            return UITableViewCell()
        }
        let model = presenter.getResult(indexPath: indexPath)
        cell.configure(model: model)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let presenter = presenter else {
            return
        }
        let model = presenter.getResult(indexPath: indexPath)
        let dataKind: ResponseDataKind = presenter.getDataKind(model: model)
        presenter.navigateToDetail(dataKind: dataKind, model: model)
    }
}
