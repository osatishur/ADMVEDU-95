//
//  ViewController.swift
//  FirstWorkProject
//
//  Created by Satsishur on 12.04.2021.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var categoryView: CategoryView!
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: Properties
    var presenter: HomePresenterProtocol?
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupSearchBar()
    }
        
    //MARK: Setup Layout
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
    //MARK: goToCategory method
    @objc func goToCategories() {
        guard let presenter = presenter else {
            return
        }
        presenter.navigateToCategory(categoryChosed: presenter.categoryTitle, delegate: self)
    }
    //MARK: log out method
    @objc func logoutUser() {
        let isLoggedOut = presenter?.logOutFromFirebase() ?? false
        if isLoggedOut {
            presenter?.navigateToAuth()
        } else {
            self.showAlert(titleMessage: "Error".localized(), message: "Failed to log out".localized())
        }
    }
}
//MARK: SearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text,
              let presenter = presenter else {
            return
        }
        presenter.searchITunes(searchTerm: searchTerm, filter: presenter.categoryTitle.rawValue)
        searchBar.endEditing(true)
    }
}

extension HomeViewController: HomeViewProtocol {
    func success() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func failure(error: SearchError) {
        switch error {
        case .unknown:
            self.showAlert(titleMessage: "Error".localized(), message: "Unknown error".localized())
        case .emptyData:
            self.showAlert(titleMessage: "Error".localized(), message: "No data".localized())
        case .parsingData:
            self.showAlert(titleMessage: "Error".localized(), message: "Failed to get data from server".localized())
        }
    }
    
    func noData() {
        showAlert(titleMessage: "No data".localized(),
                  message: "Please, check for correct request".localized())
    }
}
//MARK: HomeVC + CategoryDelegate
extension HomeViewController: CategoryDelegate  {
    func fetchCategory(_ categoryViewController: CategoryViewController, category: Category) {
        presenter?.categoryTitle = category
        categoryView.configureView(categoryTitle: category.rawValue.localized())
    }
}
