//
//  CategoryViewController.swift
//  ADMVEDU95
//
//  Created by Satsishur on 16.04.2021.
//

import UIKit

protocol CategoryViewProtocol: AnyObject {}

class CategoryViewController: UIViewController, CategoryViewProtocol {
    @IBOutlet private var tableView: UITableView!

    var viewModel: CategoryViewModelProtocol?

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
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        viewModel?.numberOfCategories() ?? .zero
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath)
        let categoryDescription = viewModel.getCategoryTitle(row: indexPath.row)
        let isCategoryMathced = viewModel.isCategoryMatched(row: indexPath.row)
        cell.textLabel?.text = categoryDescription
        cell.accessoryType = isCategoryMathced ? .checkmark : .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewModel = viewModel else {
            return
        }
        let category = viewModel.getCategory(row: indexPath.row)
        viewModel.onCellSelected(category: category)
    }
}
