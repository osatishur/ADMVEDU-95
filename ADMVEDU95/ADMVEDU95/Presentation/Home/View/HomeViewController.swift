//
//  ViewController.swift
//  FirstWorkProject
//
//  Created by Satsishur on 12.04.2021.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func successToGetData()
    func updateCategoryView(category: String)
    func showAlert(title: String, message: String)
}

class HomeViewController: UIViewController {
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var categoryView: CategoryView!
    @IBOutlet private weak var tableView: UITableView!
    
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
        let logoutBarButtonItem = UIBarButtonItem(title: "Logout".localized(), style: .done, target: self, action: #selector(logoutUser))
        navigationItem.rightBarButtonItem  = logoutBarButtonItem
        navigationItem.title = "Search".localized()
    }
    
    private func setupCategoryView() {
        guard let presenter = presenter else {
            return
        }
        categoryView.configureView(categoryTitle: presenter.getCategoryTitle().localized())
                
        let tap = UITapGestureRecognizer(target: self, action: #selector(goToCategories))
        categoryView.isUserInteractionEnabled = true
        categoryView.addGestureRecognizer(tap)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        let cell = UINib(nibName: SearchTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: SearchTableViewCell.reuseIdentifier)
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Start searching".localized()
    }
// MARK: goToCategory method
    @objc private func goToCategories() {
        guard let presenter = presenter else {
            return
        }
        presenter.didTapOnCategoryView(categoryChosed: presenter.getCategory())
    }
// MARK: log out method
    @objc private func logoutUser() {
        presenter?.didTapLogOutButton()
    }
}
// MARK: SearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text,
              let presenter = presenter else {
            return
        }
        presenter.searchITunes(searchTerm: searchTerm, filter: presenter.getCategoryTitle())
        searchBar.endEditing(true)
    }
}

extension HomeViewController: HomeViewProtocol {
    func updateCategoryView(category: String) {
        categoryView.configureView(categoryTitle: category)
    }
    
    func successToGetData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showAlert(title: String, message: String) {
        showAlert(titleMessage: title, message: message)
    }
}
