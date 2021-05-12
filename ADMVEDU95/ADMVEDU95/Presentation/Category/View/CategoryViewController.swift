//
//  CategoryViewController.swift
//  ADMVEDU95
//
//  Created by Satsishur on 16.04.2021.
//

import UIKit

protocol CategoryViewProtocol: AnyObject {

}

class CategoryViewController: UIViewController, CategoryViewProtocol {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var presenter: CategoryPresenterProtocol?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
    }
}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfCategories() ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath)
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
        presenter.onCellSelected(category: category)
        presenter.navigateToHome()
    }
}
