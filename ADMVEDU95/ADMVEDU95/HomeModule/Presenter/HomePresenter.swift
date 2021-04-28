//
//  HomePresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 27.04.2021.
//

import Foundation

protocol HomeViewProtocol: class {
    func success()
    func failure(error: iTunesSearchError)
    func noData()
}

protocol HomeViewPresenterProtocol: class {
    init(view: HomeViewProtocol, searchService: SearchServiceProtocol, firebaseService: FirebaseServiceProtocol)
    var dataSource: [ApiResult] { get set }
    var categoryTitle: Category { get set }
    func searchITunes(searchTerm: String, filter: String)
    func logOutFromFirebase() -> Bool
}

class HomePresenter: HomeViewPresenterProtocol {
    
    weak var view: HomeViewProtocol?
    let searchService: SearchServiceProtocol!
    let firebaseService: FirebaseServiceProtocol!
    var dataSource: [ApiResult]  = []
    var categoryTitle: Category = Category.all
    
    required init(view: HomeViewProtocol, searchService: SearchServiceProtocol, firebaseService: FirebaseServiceProtocol) {
        self.view = view
        self.searchService = searchService
        self.firebaseService = firebaseService
    }
    
    func searchITunes(searchTerm: String, filter: String) {
        searchService.searchResults(searchTerm: searchTerm,
                                    filter: filter) { result in
            switch result {
            case .success(let response):
                self.fetchDataFromResponse(response: response)
                self.view?.success()
            case .failure(let error):
                self.view?.failure(error: error)
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
            self.view?.noData()
        }
    }
    
    func logOutFromFirebase() -> Bool {
        return firebaseService.logOut()
    }
}
