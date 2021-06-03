//
//  HomePresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 27.04.2021.
//

import Foundation
import Swinject

protocol HomeViewModelProtocol: AnyObject {
    var dataSource: Observable<[ApiResult]> { get set }
    var category: Observable<Category> { get set }
    var alertInfo: Observable<(title: String, message: String)> { get set }
    var alertWithRetryInfo: Observable<String> { get set }
    func getCategoryTitle() -> String
    func getCategory() -> Category
    func searchITunes(searchTerm: String, filter: String)
    func getResult(indexPath: IndexPath) -> ApiResult
    func getNumberOfResults() -> Int
    func getDataKind(model: ApiResult) -> ResponseDataKind
    func getResultsFromCoreData()
    func getFilterParameter() -> String
    func didTapLogOutButton()
    func didTapOnSettingsBarButton()
    func didTapOnCategoryView(categoryChosed: Category)
    func didTapOnTableCell(dataKind: ResponseDataKind, model: ApiResult)
}

class HomeViewModel: HomeViewModelProtocol {
    private let searchService: SearchServiceProtocol?
    private let firebaseService: FirebaseServiceProtocol?
    private var coreDataService: CoreDataServiceProtocol?
    private var router: HomeRouterProtocol?
    var category: Observable<Category> = Observable(value: Category.all)
    var dataSource: Observable<[ApiResult]> = Observable(value: [])
    var alertInfo: Observable<(title: String, message: String)> = Observable(value: (title: "", message: ""))
    var alertWithRetryInfo: Observable<String> = Observable(value: "")

    init(searchService: SearchServiceProtocol,
         firebaseService: FirebaseServiceProtocol,
         coreDataService: CoreDataServiceProtocol,
         router: HomeRouterProtocol) {
        self.searchService = searchService
        self.firebaseService = firebaseService
        self.coreDataService = coreDataService
        self.router = router
    }

    func searchITunes(searchTerm: String, filter: String) {
        searchService?.searchResults(searchTerm: searchTerm,
                                     filter: filter) { result in
            self.clearOldResults()
            switch result {
            case let .success(response):
                self.fetchDataFromResponse(response: response)
            case let .failure(error):
                if !(error == .networkLoss) {
                    let alertMessage = self.getErrorMessage(error: error)
                    self.setAlertInfo(title: R.string.localizable.alertErrorTitle(),
                                      message: alertMessage)
                } else {
                    self.handleNetworkLoss()
                }
            }
        }
    }

    private func fetchDataFromResponse(response: Response) {
        coreDataService?.deleteAllResults()
        let results = response.results
        let dataSource = addResultsToDataSource(results: results)
        self.dataSource.value = dataSource
        if dataSource.isEmpty {
            let title = R.string.localizable.homeNoDataAlertTitle()
            let message = R.string.localizable.homeNoDataAlertMessage()
            setAlertInfo(title: title, message: message)
        }
    }

    private func addResultsToDataSource(results: [ApiResult]) -> [ApiResult] {
        var dataSource: [ApiResult] = []
        for result in results where !result.isInsufficient {
                dataSource.append(result)
                coreDataService?.saveResult(apiResult: result)
        }
        return dataSource
    }

    private func handleNetworkLoss() {
        NetworkReachabilityHandler.shared.handleNetworkLoss { result in
            switch result {
            case .reachedRetryLimit:
                self.getResultsFromCoreData()
            case .notReachedRetryLimit:
                self.setAlertWithRetryInfo(message: R.string.localizable.homeCheckConnectionAlertMessage())
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
        coreDataService?.fetchResults { results in
            self.dataSource.value = results ?? []
        }
    }

    func getResult(indexPath: IndexPath) -> ApiResult {
        dataSource.value[indexPath.row]
    }

    func getNumberOfResults() -> Int {
        dataSource.value.count
    }

    func getCategoryTitle() -> String {
        category.value.description
    }

    func getCategory() -> Category {
        category.value
    }

    func getFilterParameter() -> String {
        category.value.rawValue
    }

    func clearOldResults() {
        if !(dataSource.value.isEmpty) {
            dataSource.value = []
        }
    }

    func didTapOnTableCell(dataKind: ResponseDataKind, model: ApiResult) {
        router?.navigateToDetail(dataKind: dataKind, model: model)
    }

    func didTapOnCategoryView(categoryChosed _: Category) {
        router?.navigateToCategory(selectedCategory: category.value, delegate: self)
    }

    func didTapLogOutButton() {
        guard let firebaseService = firebaseService else {
            return
        }
        if firebaseService.logOut() {
            router?.navigateToAuth()
        } else {
            setAlertInfo(title: R.string.localizable.alertErrorTitle(),
                         message: R.string.localizable.homeLogOutFailedAlertMessage())
        }
    }

    func didTapOnSettingsBarButton() {
        router?.navigateToSettings()
    }

    func setAlertInfo(title: String, message: String) {
        alertInfo.value = (title: title, message: message)
    }

    func setAlertWithRetryInfo(message: String) {
        alertWithRetryInfo.value = message
    }
}

extension HomeViewModel: CategoryViewModelDelegate {
    func fetchCategory(_: CategoryViewModel, category: Category) {
        self.category.value = category
    }
}
