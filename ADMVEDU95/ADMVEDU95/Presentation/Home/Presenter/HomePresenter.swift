//
//  HomePresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 27.04.2021.
//
// swiftlint:disable line_length
import Foundation

protocol HomePresenterProtocol: AnyObject, BaseRouterProtocol {
    var dataSource: [ApiResult] { get set }
    var categoryTitle: Category { get set }
    func searchITunes(searchTerm: String, filter: String)
    func getResult(indexPath: IndexPath) -> ApiResult
    func getNumberOfResults() -> Int
    func getDataKind(model: ApiResult) -> ResponseDataKind
    func setErrorAlertMessage(error: SearchError) -> (title: String, messge: String)
    func logOutFromFirebase() -> Bool
    func navigateToCategory(categoryChosed: Category)
    func navigateToDetail(dataKind: ResponseDataKind, model: ApiResult)
}

class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
    let searchService: SearchServiceProtocol!
    let firebaseService: FirebaseServiceProtocol!
    var router: HomeRouterProtocol?
    var dataSource: [ApiResult] = []
    var categoryTitle = Category.all

    init(view: HomeViewProtocol, searchService: SearchServiceProtocol, firebaseService: FirebaseServiceProtocol, router: HomeRouterProtocol) {
        self.view = view
        self.searchService = searchService
        self.firebaseService = firebaseService
        self.router = router
    }

    func searchITunes(searchTerm: String, filter: String) {
        searchService.searchResults(searchTerm: searchTerm,
                                    filter: filter) { result in
            switch result {
            case let .success(response):
                self.fetchDataFromResponse(response: response)
                self.view?.successToGetData()
            case let .failure(error):
                let alertMessage = self.setErrorAlertMessage(error: error)
                self.view?.failedToGetData(title: alertMessage.title, message: alertMessage.messge)
            }
        }
    }

    private func fetchDataFromResponse(response: Response) {
        if !dataSource.isEmpty {
            dataSource = []
        }
        let results = response.results
        for result in results {
            if isResultPropertiesNotNil(result: result) { // check for insufficient data
                dataSource.append(result)
            }
        }
        if dataSource.isEmpty {
            view?.noDataFromRequest(title: "No data".localized(),
                                    message: "Please, check for correct request".localized())
        }
    }

    private func isResultPropertiesNotNil(result: ApiResult) -> Bool {
        if !(result.kind == nil || result.artistName == nil || result.trackName == nil) {
            return true
        } else {
            return false
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
        dataSource[indexPath.row]
    }

    func getNumberOfResults() -> Int {
        dataSource.count
    }

    func setErrorAlertMessage(error: SearchError) -> (title: String, messge: String) {
        switch error {
        case .unknown:
            return ("Error".localized(), "Unknown error".localized())
        case .emptyData:
            return ("Error".localized(), "No data".localized())
        case .parsingData:
            return ("Error".localized(), "Failed to get data from server".localized())
        }
    }

    func navigateToDetail(dataKind: ResponseDataKind, model: ApiResult) {
        router?.showDetail(dataKind: dataKind, model: model)
    }

    func navigateToCategory(categoryChosed _: Category) {
        router?.showCategory(categoryChosed: categoryTitle, delegate: self)
    }

    func logOutFromFirebase() -> Bool {
        firebaseService.logOut()
    }
}

extension HomePresenter: CategoryDelegate {
    func fetchCategory(_: CategoryViewProtocol, category: Category) {
        categoryTitle = category
        view?.updateCategory(category: category)
    }
}
