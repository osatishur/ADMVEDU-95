//
//  ViewController.swift
//  FirstWorkProject
//
//  Created by Satsishur on 12.04.2021.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func updateSearchResults()
    func updateCategory(category: String)
    func showAlert(title: String, message: String)
    func showAlertWithRetry(message: String)
}

class HomeViewController: UIViewController {
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var categoryView: CategoryView!
    @IBOutlet private var tableView: UITableView!

    // MARK: Properties

    var viewModel: HomeViewModelProtocol?

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupSearchBar()
        viewModel?.getResultsFromCoreData()
        viewModel?.dataSource.bind({ [weak self] _ in
            self?.updateSearchResults()
        })
        viewModel?.category.bind({ [weak self] value in
            self?.updateCategory(category: value?.description ?? "")
        })
        viewModel?.alertInfo.bind({ [weak self] value in
            self?.showAlert(title: value?.title ?? "",
                            message: value?.message ?? "")
        })
        viewModel?.alertWithRetryInfo.bind({ [weak self] value in
            self?.showAlertWithRetry(message: value ?? "")
        })
    }

    // MARK: Setup Layout

    private func setupViews() {
        setupNavigationBar()
        setupTableView()
        setupCategoryView()
    }

    private func setupNavigationBar() {
        let title = R.string.localizable.homeLogoutButtonTitle()
        let logoutBarButtonItem = UIBarButtonItem(title: title,
                                                  style: .done,
                                                  target: self,
                                                  action: #selector(logoutUser))
        let settingsBarButtonItem = UIBarButtonItem(image: UIImageView.settingsBarButtonImage,
                                                    style: .done, target: self,
                                                    action: #selector(goToSettings))
        navigationItem.rightBarButtonItems = [logoutBarButtonItem, settingsBarButtonItem ]
        navigationItem.title = R.string.localizable.homeNavigationItemTitle()
    }

    private func setupCategoryView() {
        guard let viewModel = viewModel else {
            return
        }
        categoryView.configureView(categoryTitle: viewModel.getCategoryTitle().localized())

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
        searchBar.placeholder = R.string.localizable.homeSearchBarPlaceholder()
    }

    // MARK: goToCategory method

    @objc
    private func goToCategories() {
        guard let viewModel = viewModel else {
            return
        }
        viewModel.didTapOnCategoryView(categoryChosed: viewModel.getCategory())
    }

    // MARK: log out method

    @objc
    private func logoutUser() {
        viewModel?.didTapLogOutButton()
    }

    @objc
    private func goToSettings() {
        viewModel?.didTapOnSettingsBarButton()
    }
}

// MARK: SearchBarDelegate

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text,
              let viewModel = viewModel
        else {
            return
        }
        viewModel.searchITunes(searchTerm: searchTerm, filter: viewModel.getFilterParameter())
        searchBar.endEditing(true)
    }
}

extension HomeViewController: HomeViewProtocol {
    func showAlertWithRetry(message: String) {
        showAlertWithRetry(message: message) {
            guard let searchTerm = self.searchBar.text,
                  let viewModel = self.viewModel else {
                return
            }
            viewModel.searchITunes(searchTerm: searchTerm, filter: viewModel.getFilterParameter())
        }
    }

    func updateCategory(category: String) {
        categoryView.configureView(categoryTitle: category)
    }

    func updateSearchResults() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func showAlert(title: String, message: String) {
        showAlert(titleMessage: title, message: message)
    }
}
