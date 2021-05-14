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
    func getResultsFromCoreData()
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
    var retryNumber = 0
    var coreDataStack = CoreDataService()
    
    init(view: HomeViewProtocol, searchService: SearchServiceProtocol, firebaseService: FirebaseServiceProtocol, router: HomeRouterProtocol) {
        self.view = view
        self.searchService = searchService
        self.firebaseService = firebaseService
        self.router = router
    }
    
    func searchITunes(searchTerm: String, filter: String) {
        searchService?.searchResults(searchTerm: searchTerm,
                                    filter: filter) { result in
            if !self.dataSource.isEmpty {
                self.dataSource = []
                self.view?.updateSearchResults()
            }
            switch result {
            case .success(let response):
                self.fetchDataFromResponse(response: response)
                self.view?.updateSearchResults()
            case .failure(let error):
                let alertMessage = self.getErrorMessage(error: error)
                self.handleRetry(message: alertMessage)
            }
        }
    }
    
    private func fetchDataFromResponse(response: Response) {
        self.coreDataStack.deleteAllResults()
        let results = response.results
        for result in results {
            print(result)
            addResultToDataSource(result: result)
            self.coreDataStack.saveResult(apiResult: result)
        }
        if dataSource.isEmpty {
            self.view?.showAlert(title: R.string.localizable.noData(), message: R.string.localizable.pleaseCheckForCorrectRequest())
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
    
    private func getErrorMessage(error: SearchError) -> String {
        switch error {
        case .unknown:
            return (R.string.localizable.unknownError())
        case .emptyData:
            return (R.string.localizable.noData())
        case .parsingData:
            return (R.string.localizable.failedToGetDataFromServer())
        }
    }
    
    private func handleRetry(message: String) {
        increaseRetryNumber()
        if retryNumber > 2 {
            resetRetryNumber()
            getResultsFromCoreData()
        } else {
            self.view?.showAlertWithRetry(message: message)
        }
    }
    
    func getResultsFromCoreData() {
        self.coreDataStack.fetchResults { results in
            self.dataSource = results ?? []
            self.view?.updateSearchResults()
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
    
    private func increaseRetryNumber() {
        retryNumber += 1
    }
    
    private func resetRetryNumber() {
        retryNumber = 0
    }
    
    func didTapOnTableCell(dataKind: ResponseDataKind, model: ApiResult) {
        print(model)
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
            view?.showAlert(title: R.string.localizable.error(), message: R.string.localizable.failedToLogOut())
        }
    }
}

extension HomePresenter: CategoryPresenterDelegate {
    func fetchCategory(_ categoryPresenter: CategoryPresenter, category: Category) {
        self.category = category
        view?.updateCategory(category: category.rawValue.localized())
    }
}
