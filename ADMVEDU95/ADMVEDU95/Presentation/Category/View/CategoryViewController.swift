//
//  CategoryViewController.swift
//  ADMVEDU95
//
//  Created by Satsishur on 16.04.2021.
//

import UIKit

protocol CategoryDelegate {
    func fetchCategory(_ categoryViewController: CategoryViewController, category: Category)
}

class CategoryViewController: UIViewController {
    struct Constants {
        static let categoryCellIdentifier = "CategoryTableViewCell"
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
    var presenter: CategoryViewPresenterProtocol?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.categoryCellIdentifier)
    }
}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.dataSource.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.categoryCellIdentifier, for: indexPath)
        let category = presenter?.dataSource[indexPath.row].rawValue
        cell.textLabel?.text = category?.localized()
        cell.accessoryType = presenter?.dataSource[indexPath.row] == presenter?.categoryChosed ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let presenter = presenter else {
            return
        }
        presenter.delegate.fetchCategory(self, category: presenter.dataSource[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
}
