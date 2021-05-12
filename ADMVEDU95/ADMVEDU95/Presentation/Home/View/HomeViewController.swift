//
//  ViewController.swift
//  FirstWorkProject
//
//  Created by Satsishur on 12.04.2021.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func successToGetData()
    func failedToGetData(title: String, message: String)
    func noDataFromRequest(title: String, message: String)
    func updateCategory(category: Category)
}

class HomeViewController: UIViewController {
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var categoryView: CategoryView!
    @IBOutlet private var tableView: UITableView!

    // MARK: Properties

    var presenter: HomePresenterProtocol?

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupSearchBar()
    }

    // MARK: Setup Layout

    private func setupViews() {
        setupNavigationBar()
        setupTableView()
        setupCategoryView()
    }

    private func setupNavigationBar() {
        let barButtonTitle = "Logout".localized()
        let logoutBarButtonItem = UIBarButtonItem(title: barButtonTitle, style: .done, target: self, action: #selector(logOut))
        navigationItem.rightBarButtonItem = logoutBarButtonItem
        navigationItem.title = "Search".localized()
    }

    private func setupCategoryView() {
        guard let presenter = presenter else {
            return
        }
        categoryView.configureView(categoryTitle: presenter.categoryTitle.rawValue.localized())

        let tap = UITapGestureRecognizer(target: self, action: #selector(goToCategories))
        categoryView.isUserInteractionEnabled = true
        categoryView.addGestureRecognizer(tap)
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        let cell = UINib(nibName: SearchTableViewCell.reuseIdentifire, bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: SearchTableViewCell.reuseIdentifire)
    }

    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Start searching".localized()
    }

    // MARK: goToCategory method

    @objc
    func goToCategories() {
        guard let presenter = presenter else {
            return
        }
        presenter.navigateToCategory(categoryChosed: presenter.categoryTitle)
    }

    // MARK: log out method

    @objc
    func logOut() {
        let isLoggedOut = presenter?.logOutFromFirebase() ?? false
        if isLoggedOut {
            presenter?.navigateToAuth()
        } else {
            showAlert(titleMessage: "Error".localized(), message: "Failed to log out".localized())
        }
    }
}

// MARK: SearchBarDelegate

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text,
              let presenter = presenter
        else {
            return
        }
        presenter.searchITunes(searchTerm: searchTerm, filter: presenter.categoryTitle.rawValue)
        searchBar.endEditing(true)
    }
}

extension HomeViewController: HomeViewProtocol {
    func updateCategory(category: Category) {
        categoryView.configureView(categoryTitle: category.rawValue.localized())
    }

    func successToGetData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func failedToGetData(title: String, message: String) {
        showAlert(titleMessage: title, message: message)
    }

    func noDataFromRequest(title: String, message: String) {
        showAlert(titleMessage: title, message: message)
    }
}
