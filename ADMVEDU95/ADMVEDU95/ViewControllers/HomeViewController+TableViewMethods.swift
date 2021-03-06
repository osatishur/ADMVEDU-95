//
//  HomeVC+TableViewMethods.swift
//  FirstWorkProject
//
//  Created by Satsishur on 14.04.2021.
//

import UIKit

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.searchCellIdentifier, for: indexPath) as! SearchResponceTableViewCell
        let model = dataSource[indexPath.row]
        cell.configure(model: model)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailViewController()
        let model = dataSource[indexPath.row]
        vc.configureView(model: model)
        if model.kind == "feature-movie" {
            vc.iTunesDataType = .movie
        }
        present(vc, animated: true)
    }
}


