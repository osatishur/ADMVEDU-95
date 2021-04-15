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
        static let searhBarPlaceholder = "Start searching"
    }
    //MARK: Views
    internal var searchController = UISearchController(searchResultsController: nil)
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SearchResponceTableViewCell.self, forCellReuseIdentifier: Constants.searchCellIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        return tableView
    }()
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
    }
    
    private func setupSubviews() {
        view.addSubview(searchController.searchBar)
        view.addSubview(tableView)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    private func setupSearchBar() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Constants.searhBarPlaceholder
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





