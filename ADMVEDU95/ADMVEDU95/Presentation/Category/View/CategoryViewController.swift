//
//  CategoryViewController.swift
//  ADMVEDU95
//
//  Created by Satsishur on 16.04.2021.
//

import UIKit

protocol CategoryDelegate: AnyObject {
    func fetchCategory(_ categoryViewController: CategoryViewController, category: Category)
}

class CategoryViewController: UIViewController {
    struct Constants {
        static let categoryCellIdentifier = "CategoryTableViewCell"
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
    var presenter: CategoryPresenterProtocol?
        
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
        return presenter?.numberOfCategories() ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.categoryCellIdentifier, for: indexPath)
        let category = presenter?.getCategory(indexPath: indexPath)
        let selectedCategory = presenter?.getSelectedCategory()
        cell.textLabel?.text = category?.rawValue.localized()
        cell.accessoryType = category == selectedCategory ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let presenter = presenter else {
            return
        }
        let category = presenter.getCategory(indexPath: indexPath)
        presenter.delegate?.fetchCategory(self, category: category)
        presenter.naviagateToHome()
    }
}
