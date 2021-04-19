//
//  ViewController.swift
//  FirstWorkProject
//
//  Created by Satsishur on 12.04.2021.
//

import UIKit

class HomeViewController: UIViewController {
    struct Constants {
        static let searchCellIdentifier = "SearchResponceTableViewCell"
        static let estimatedRowHeight: CGFloat = 200
        static let topViewHeight: CGFloat = 56
        static let categoryViewHeight: CGFloat = 32
        static let categoryViewSideConstraint: CGFloat = 8
    }
    //MARK: Views
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchResponceTableViewCell.self, forCellReuseIdentifier: Constants.searchCellIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Constants.estimatedRowHeight
        return tableView
    }()
    
    private let topView = UIView()
    var searchController = UISearchController(searchResultsController: nil)
    let categoryView = CategoryView()
    //MARK: Properties
    var dataSource: [ApiResult]  = []
    var categoryTitle: Category = Category.all
    private let searchService = SearchService()
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupSearchBar()
    }
    
    //MARK: Setup Layout
    private func setupLayout() {
        setupSubviews()
        setupTableView()
        setupTopView()
        setupCategoryView()
    }
    
    private func setupSubviews() {
        view.addSubview(topView)
        view.addSubview(categoryView)
        topView.addSubview(searchController.searchBar)
        view.addSubview(tableView)
    }
    
    private func setupTopView() {
        topView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                       left: view.leftAnchor,
                       right: view.rightAnchor,
                       width: 0,
                       height: Constants.topViewHeight)
    }
    
    private func setupCategoryView() {
        categoryView.anchor(top: topView.bottomAnchor,
                            left: view.leftAnchor,
                            right: view.rightAnchor,
                            width: 0,
                            height: Constants.categoryViewHeight)
        categoryView.backgroundColor = UIColor.categoryViewColor
        categoryView.configureView(categoryTitle: NSLocalizedString(categoryTitle.rawValue, comment: ""))
                
        let tap = UITapGestureRecognizer(target: self, action: #selector(goToCategories))
        categoryView.isUserInteractionEnabled = true
        categoryView.addGestureRecognizer(tap)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.anchor(top: categoryView.bottomAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         left: view.leftAnchor,
                         right: view.rightAnchor,
                         width: 0,
                         height: 0)
    }
    
    private func setupSearchBar() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("Start searching", comment: "")
    }
    //MARK: goToCategory method
    @objc func goToCategories() {
        let vc = CategoryViewController()
        vc.delegate = self
        vc.categoryChosed = categoryTitle
        present(vc, animated: true)
    }
}
//MARK: SearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchBar = searchController.searchBar
        guard let searchTerm = searchBar.text else {return}
        searchITunes(searchTerm: searchTerm)
        searchController.isActive = false
    }
    
    private func searchITunes(searchTerm: String) {
        searchService.searchResults(searchTerm: searchTerm,
                                    filter: self.categoryTitle.rawValue) { (result: Result<Response, iTunesSearchError>) in
            switch result {
            case .success(let response):
                self.fetchDataFromResponse(response: response)
            case .failure(.unknown(let error)):
                print("unknown error", error ?? "error")
            case .failure(.emptyData):
                print("no data")
            case .failure(.parsingData(let error)):
                print("json error", error ?? "error")
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
            showAlert(titleMessage: NSLocalizedString("No data", comment: ""),
                      message: NSLocalizedString("Please, check for correct request", comment: ""))
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension HomeViewController {
    private func showAlert(titleMessage: String, message: String) {
        let alert = UIAlertController(title: titleMessage, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}






