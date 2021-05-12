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
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier, for: indexPath) as? SearchTableViewCell
        guard let presenter = presenter,
              let cell = cell else {
            return UITableViewCell()
        }
        let model = presenter.getResult(indexPath: indexPath)
        cell.configure(model: model)
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let presenter = presenter else {
            return
        }
        let model = presenter.getResult(indexPath: indexPath)
        let dataKind: ResponseDataKind = presenter.getDataKind(model: model)
        presenter.didTapOnTableCell(dataKind: dataKind, model: model)
    }
}
