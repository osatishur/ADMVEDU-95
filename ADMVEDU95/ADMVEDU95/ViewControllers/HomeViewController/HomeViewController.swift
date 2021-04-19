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
        static let categoryViewColor = UIColor(red: 52/255, green: 59/255, blue: 70/255, alpha: 1)
    }
    //MARK: Views
    internal var searchController = UISearchController(searchResultsController: nil)
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchResponceTableViewCell.self, forCellReuseIdentifier: Constants.searchCellIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Constants.estimatedRowHeight
        return tableView
    }()
    
    private let topView = UIView()
    private let categoryView = UIView()
    let categoryLabel = UILabel()
    //MARK: Properties
    var dataSource: [iTunesResult]  = []
    private let searchService = SearchService()
    var categoryTitle: iTunesCategory = iTunesCategory.all
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupSearchBar()
    }
    
    override func viewDidLayoutSubviews() {
        categoryLabel.text = NSLocalizedString(categoryTitle.rawValue, comment: "")
    }
    //MARK: Setup Layout
    private func setupLayout() {
        setupSubviews()
        setupTableView()
        setupTopView()
        setupCategoryView()
        setupCategoryLabel()
    }
    
    private func setupSubviews() {
        view.addSubview(topView)
        view.addSubview(categoryView)
        topView.addSubview(searchController.searchBar)
        categoryView.addSubview(categoryLabel)
        view.addSubview(tableView)
    }
    
    private func setupTopView() {
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        topView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
    }
    
    private func setupCategoryView() {
        categoryView.translatesAutoresizingMaskIntoConstraints = false
        categoryView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        categoryView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        categoryView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        categoryView.heightAnchor.constraint(equalToConstant: Constants.categoryViewHeight).isActive = true
        categoryView.backgroundColor = Constants.categoryViewColor
        
        let arrowLabel = UILabel()
        categoryView.addSubview(arrowLabel)
        arrowLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowLabel.trailingAnchor.constraint(equalTo: categoryView.trailingAnchor, constant: -Constants.categoryViewSideConstraint).isActive = true
        arrowLabel.centerYAnchor.constraint(equalTo: categoryView.centerYAnchor).isActive = true
        arrowLabel.textColor = UIColor.white
        arrowLabel.text = ">"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(goToCategories))
        categoryView.isUserInteractionEnabled = true
        categoryView.addGestureRecognizer(tap)
    }
    
    private func setupCategoryLabel() {
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.centerYAnchor.constraint(equalTo: categoryView.centerYAnchor).isActive = true
        categoryLabel.leftAnchor.constraint(equalTo: categoryView.leftAnchor, constant: Constants.categoryViewSideConstraint).isActive = true
        categoryLabel.textColor = .white
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: categoryView.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
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
                                    filter: self.categoryTitle.rawValue) { (result: Result<iTunesResponse, iTunesSearchError>) in
            print(result)
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
    
    private func fetchDataFromResponse(response: iTunesResponse) {
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
            Alerts.showAlert(viewController: self,
                             titleMessage: NSLocalizedString("No data", comment: ""),
                             message: NSLocalizedString("Please, check for correct request", comment: ""))
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}






