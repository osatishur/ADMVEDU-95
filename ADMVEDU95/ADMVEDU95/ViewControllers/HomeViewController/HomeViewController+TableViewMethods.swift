//
//  HomeVC+TableViewMethods.swift
//  FirstWorkProject
//
//  Created by Satsishur on 14.04.2021.
//

import UIKit

extension HomeViewController: UITableViewDataSource {
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
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailViewController()
        let model = dataSource[indexPath.row]
        vc.configureView(model: model)
        switch model.kind {
        case ResponseDataKind.movie.rawValue,
             ResponseDataKind.musicVideo.rawValue:
            vc.iTunesDataType = .movie
        default:
            vc.iTunesDataType = .song
        }
        present(vc, animated: true)
    }
}


