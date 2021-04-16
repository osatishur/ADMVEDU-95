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
        static let topViewHeight: CGFloat = 44
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
    //MARK: Properties
    internal var dataSource: [iTunesResult]  = []
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
    }
    
    private func setupSubviews() {
        view.addSubview(topView)
        topView.addSubview(searchController.searchBar)
        view.addSubview(tableView)
    }
    
    private func setupTopView() {
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        topView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func setupSearchBar() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("Start searching", comment: "")
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
        searchService.searchResults(searchTerm: searchTerm) { (result: Result<iTunesResponse, iTunesSearchError>) in
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
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}





