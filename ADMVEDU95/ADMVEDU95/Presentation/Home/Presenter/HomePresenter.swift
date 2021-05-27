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
    func getFilterParameter() -> String
    func didTapLogOutButton()
    func didTapOnCategoryView(categoryChosed: Category)
    func didTapOnTableCell(dataKind: ResponseDataKind, model: ApiResult)
}

class HomePresenter: HomePresenterProtocol {
    private weak var view: HomeViewProtocol?
    private let searchService: SearchServiceProtocol?
    private let firebaseService: FirebaseServiceProtocol?
    private var router: HomeRouterProtocol?
    private var dataSource: [ApiResult] = []
    private var category = Category.all
    private var coreDataStack = CoreDataService()

    init(view: HomeViewProtocol,
         searchService: SearchServiceProtocol,
         firebaseService: FirebaseServiceProtocol,
         router: HomeRouterProtocol) {
        self.view = view
        self.searchService = searchService
        self.firebaseService = firebaseService
        self.router = router
    }

    func searchITunes(searchTerm: String, filter: String) {
        searchService?.searchResults(searchTerm: searchTerm,
                                     filter: filter) { result in
            self.clearOldResults()
            switch result {
            case let .success(response):
                self.fetchDataFromResponse(response: response)
                self.view?.updateSearchResults()
            case let .failure(error):
                if !(error == .networkLoss) {
                    let alertMessage = self.getErrorMessage(error: error)
                    self.view?.showAlert(title: R.string.localizable.alertErrorTitle(), message: alertMessage)
                } else {
                    self.handleNetworkLoss()
                }
            }
        }
    }

    private func fetchDataFromResponse(response: Response) {
        coreDataStack.deleteAllResults()
        let results = response.results
        for result in results {
            print(result)
            addResultToDataSource(result: result)
            coreDataStack.saveResult(apiResult: result)
        }
        if dataSource.isEmpty {
            let title = R.string.localizable.homeNoDataAlertTitle()
            let message = R.string.localizable.homeNoDataAlertMessage()
            view?.showAlert(title: title, message: message)
        }
    }

    private func addResultToDataSource(result: ApiResult) {
        if !result.isInsufficient {
            dataSource.append(result)
        }
    }

    private func handleNetworkLoss() {
        NetworkReachabilityHandler.shared.handleNetworkLoss { result in
            switch result {
            case .reachedRetryLimit:
                self.getResultsFromCoreData()
            case .notReachedRetryLimit:
                self.view?.showAlertWithRetry(message: "Please, check your internet connection")
            }
        }
    }

    func getDataKind(model: ApiResult) -> ResponseDataKind {
        switch model.kind {
        case ResponseDataKind.movie.rawValue,
             ResponseDataKind.musicVideo.rawValue,
             ResponseDataKind.tvShow.rawValue:
            return .movie
        default:
            return .song
        }
    }

    private func getErrorMessage(error: NetworkError) -> String {
        switch error {
        case .unknown:
            return R.string.localizable.homeUnknownErrorAlertMessage()
        case .emptyData:
            return R.string.localizable.homeNoDataAlertMessage()
        case .parsingData:
            return R.string.localizable.homeParsingDataErrorAlertMessage()
        case .networkLoss:
            return R.string.localizable.homeCheckConnectionAlertMessage()
        }
    }

    func getResultsFromCoreData() {
        coreDataStack.fetchResults { results in
            self.dataSource = results ?? []
            self.view?.updateSearchResults()
        }
    }

    func getResult(indexPath: IndexPath) -> ApiResult {
        dataSource[indexPath.row]
    }

    func getNumberOfResults() -> Int {
        dataSource.count
    }

    func getCategoryTitle() -> String {
        category.description
    }

    func getCategory() -> Category {
        category
    }

    func getFilterParameter() -> String {
        category.rawValue
    }

    func clearOldResults() {
        if !dataSource.isEmpty {
            dataSource = []
            view?.updateSearchResults()
        }
    }

    func didTapOnTableCell(dataKind: ResponseDataKind, model: ApiResult) {
        router?.navigateToDetail(dataKind: dataKind, model: model)
    }

    func didTapOnCategoryView(categoryChosed _: Category) {
        router?.navigateToCategory(selectedCategory: category, delegate: self)
    }

    func didTapLogOutButton() {
        guard let firebaseService = firebaseService else {
            return
        }
        if firebaseService.logOut() {
            router?.navigateToAuth()
        } else {
            view?.showAlert(title: R.string.localizable.alertErrorTitle(),
                            message: R.string.localizable.homeLogOutFailedAlertMessage())
        }
    }
}

extension HomePresenter: CategoryPresenterDelegate {
    func fetchCategory(_: CategoryPresenter, category: Category) {
        self.category = category
        view?.updateCategory(category: category.description)
    }
}
