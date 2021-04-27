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
    
    private let dataSource: [Category] = {
        var data: [Category] = []
        for category in Category.allCases {
            data.append(category)
        }
        return data
    }()
    
    var delegate: CategoryDelegate?
    var categoryChosed: Category?
    
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
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.categoryCellIdentifier, for: indexPath)
        let category = dataSource[indexPath.row].rawValue
        cell.textLabel?.text = category.localized()
        cell.accessoryType = dataSource[indexPath.row] == categoryChosed ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.fetchCategory(self, category: dataSource[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
}
