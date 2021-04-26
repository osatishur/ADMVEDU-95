//
//  ViewController.swift
//  FirstWorkProject
//
//  Created by Satsishur on 12.04.2021.
//

import UIKit

class HomeViewController: UIViewController {
    struct Constants {
        static let searchCellIdentifier = "SearchTableViewCell"
        static let estimatedRowHeight: CGFloat = 200
        static let topViewHeight: CGFloat = 56
        static let categoryViewHeight: CGFloat = 32
        static let categoryViewSideConstraint: CGFloat = 8
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var categoryView: CategoryView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Properties
    var dataSource: [ApiResult]  = []
    var categoryTitle: Category = Category.all
    private let searchService = SearchService()
    private let firebaseService = FirebaseService()
    
<<<<<<< HEAD
    //weak var coordinator: MainCoordinator?
=======
>>>>>>> ADMVEDU105
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupSearchBar()
    }
    
    //MARK: Setup Layout
    private func setupLayout() {
<<<<<<< HEAD
        setupSubviews()
=======
>>>>>>> ADMVEDU105
        setupNavigationBar()
        setupTableView()
        setupCategoryView()
    }
    
<<<<<<< HEAD
    private func setupSubviews() {
        view.addSubview(topView)
        view.addSubview(categoryView)
        topView.addSubview(searchController.searchBar)
        view.addSubview(tableView)
    }
    
=======
>>>>>>> ADMVEDU105
    private func setupNavigationBar() {
        let logoutBarButtonItem = UIBarButtonItem(title: "Logout".localized(), style: .done, target: self, action: #selector(logoutUser))
        navigationItem.rightBarButtonItem  = logoutBarButtonItem
        navigationItem.title = "Search".localized()
<<<<<<< HEAD
    }
    
    private func setupTopView() {
        topView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                       left: view.leftAnchor,
                       right: view.rightAnchor)
        topView.dimension(width: .zero,
                          height: Constants.topViewHeight)
=======
>>>>>>> ADMVEDU105
    }
    
    private func setupCategoryView() {
        categoryView.configureView(categoryTitle: NSLocalizedString(categoryTitle.rawValue, comment: ""))
                
        let tap = UITapGestureRecognizer(target: self, action: #selector(goToCategories))
        categoryView.isUserInteractionEnabled = true
        categoryView.addGestureRecognizer(tap)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        let cell = UINib(nibName: Constants.searchCellIdentifier, bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: Constants.searchCellIdentifier)
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Start searching".localized()
    }
    //MARK: goToCategory method
    @objc func goToCategories() {
        let vc = CategoryViewController()
        vc.delegate = self
        vc.categoryChosed = categoryTitle
        present(vc, animated: true)
    }
    //MARK: log out method
    @objc func logoutUser() {
        let isLoggedOut = firebaseService.logOut()
        if isLoggedOut {
            let navVC = UINavigationController(rootViewController: LoginViewController())
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(navVC)
        } else {
            self.showAlert(titleMessage: "Error".localized(), message: "Failed to log out".localized())
        }
    }
}
//MARK: SearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
<<<<<<< HEAD
        let searchBar = searchController.searchBar
=======
        //let searchBar = searchController.searchBar
>>>>>>> ADMVEDU105
        guard let searchTerm = searchBar.text
        else {
            return
        }
        searchITunes(searchTerm: searchTerm)
        searchBar.endEditing(true)
    }
    
    private func searchITunes(searchTerm: String) {
        searchService.searchResults(searchTerm: searchTerm,
                                    filter: self.categoryTitle.rawValue) { result in
            switch result {
            case .success(let response):
                self.fetchDataFromResponse(response: response)
            case .failure(.unknown):
                self.showAlert(titleMessage: "Error".localized(), message: "Unknown error".localized())
            case .failure(.emptyData):
                self.showAlert(titleMessage: "Error".localized(), message: "No data".localized())
            case .failure(.parsingData):
                self.showAlert(titleMessage: "Error".localized(), message: "Failed to get data from server".localized())
            }
        }
    }
    
    private func fetchDataFromResponse(response: Response) {
        if !self.dataSource.isEmpty {
            self.dataSource = []
        }
        let results = response.results
        for result in results {
            if !(result.kind == nil || result.artistName == nil || result.trackName == nil) { //check for insufficient data
                self.dataSource.append(result)
            }
        }
        if dataSource.isEmpty {
            showAlert(titleMessage: "No data".localized(),
                      message: "Please, check for correct request".localized())
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
