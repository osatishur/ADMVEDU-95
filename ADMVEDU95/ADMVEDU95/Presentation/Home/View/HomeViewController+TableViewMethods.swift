//
//  HomeVC+TableViewMethods.swift
//  FirstWorkProject
//
//  Created by Satsishur on 14.04.2021.
//

import UIKit

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.dataSource.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifire, for: indexPath) as? SearchTableViewCell
        guard let presenter = presenter else {
            return UITableViewCell()
        }
        let model = presenter.dataSource[indexPath.row]
        cell?.configure(model: model)
        cell?.accessoryType = .disclosureIndicator
        return cell ?? UITableViewCell()
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let dataKind: ResponseDataKind
        guard let presenter = presenter else {
            return
        }
        let model = presenter.dataSource[indexPath.row]
        switch model.kind {
        case ResponseDataKind.movie.rawValue,
             ResponseDataKind.musicVideo.rawValue:
            dataKind = .movie
        default:
            dataKind = .song
        }
        let vc = ViewBuilder.createDetailView(dataKind: dataKind) as? DetailViewController
        vc?.configureView(model: model)
        present(vc ?? UIViewController(), animated: true)
    }
}
