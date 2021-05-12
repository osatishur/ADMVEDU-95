//
//  HomePresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 27.04.2021.
//

import Foundation

protocol HomePresenterProtocol: AnyObject {
    func getCategoryTitle() -> String
    func getCategory() -> Category
    func searchITunes(searchTerm: String, filter: String)
    func getResult(indexPath: IndexPath) -> ApiResult
    func getNumberOfResults() -> Int
    func getDataKind(model: ApiResult) -> ResponseDataKind
    func didTapLogOutButton()
    func didTapOnCategoryView(categoryChosed: Category)
    func didTapOnTableCell(dataKind: ResponseDataKind, model: ApiResult)
}

class HomePresenter: HomePresenterProtocol {    
    weak var view: HomeViewProtocol?
    let searchService: SearchServiceProtocol?
    let firebaseService: FirebaseServiceProtocol?
    var router: HomeRouterProtocol?
    var dataSource: [ApiResult]  = []
    var category: Category = Category.all
    
    init(view: HomeViewProtocol, searchService: SearchServiceProtocol, firebaseService: FirebaseServiceProtocol, router: HomeRouterProtocol) {
        self.view = view
        self.searchService = searchService
        self.firebaseService = firebaseService
        self.router = router
    }
    
    func searchITunes(searchTerm: String, filter: String) {
        searchService?.searchResults(searchTerm: searchTerm,
                                    filter: filter) { result in
            switch result {
            case .success(let response):
                self.fetchDataFromResponse(response: response)
                self.view?.successToGetData()
            case .failure(let error):
                let alertMessage = self.getErrorAlertMessage(error: error)
                self.view?.showAlert(title: "Error".localized(),
                                     message: alertMessage)
            }
        }
    }
    
    private func fetchDataFromResponse(response: Response) {
        if !self.dataSource.isEmpty {
            self.dataSource = []
        }
        let results = response.results
        for result in results {
            addResultToDataSource(result: result) 
        }
        if dataSource.isEmpty {
            view?.showAlert(title: "No data".localized(),
                            message: "Please, check for correct request".localized())
        }
    }
    
    private func addResultToDataSource(result: ApiResult) {
        if !result.isInsufficient {
            self.dataSource.append(result)
        }
    }
    
    func getDataKind(model: ApiResult) -> ResponseDataKind {
        switch model.kind {
        case ResponseDataKind.movie.rawValue,
             ResponseDataKind.musicVideo.rawValue:
            return .movie
        default:
            return .song
        }
    }
    
    func getResult(indexPath: IndexPath) -> ApiResult {
        return dataSource[indexPath.row]
    }
    
    func getNumberOfResults() -> Int {
        return dataSource.count
    }
    
    func getCategoryTitle() -> String {
        return category.rawValue
    }
    
    func getCategory() -> Category {
        return category
    }
    
    private func getErrorAlertMessage(error: SearchError) -> String {
        switch error {
        case .unknown:
            return ("Unknown error".localized())
        case .emptyData:
            return ("No data".localized())
        case .parsingData:
            return ("Failed to get data from server".localized())
        }
    }
    
    func didTapOnTableCell(dataKind: ResponseDataKind, model: ApiResult) {
        router?.navigateToDetail(dataKind: dataKind, model: model)
    }
    
    func didTapOnCategoryView(categoryChosed: Category) {
        router?.navigateToCategory(categorySelected: category, delegate: self)
    }
    
    func didTapLogOutButton() {
        guard let firebaseService = firebaseService else {
            return 
        }
        if firebaseService.logOut() {
            router?.navigateToAuth()
        } else {
            view?.showAlert(title: "Error".localized(), message: "Failed to log out".localized())
        }
    }
}

extension HomePresenter: CategoryPresenterDelegate {
    func fetchCategory(_ categoryPresenter: CategoryPresenter, category: Category) {
        self.category = category
        view?.updateCategoryView(category: category.rawValue.localized())
    }
}
