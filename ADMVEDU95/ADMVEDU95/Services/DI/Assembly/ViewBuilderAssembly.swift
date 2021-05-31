//
//  ViewBuilderAssembly.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 26.05.2021.
//
// swiftlint:disable closure_parameter_position
import Foundation
import Swinject

class ViewBuilderAssembly: Assembly {
    func assemble(container: Container) {
        let firebaseService: FirebaseServiceProtocol = {
            guard let service = container.resolve(FirebaseServiceProtocol.self) else {
                return FirebaseService()
            }
            return service
        }()

        assembleHomeView(container: container, firebaseService: firebaseService)
        assembleDetailView(container: container)
        assembleCategoryView(container: container)
        assembleSettingsView(container: container)
        assembleSignInView(container: container, firebaseService: firebaseService)
        assembleLogInView(container: container, firebaseService: firebaseService)
        assembleResetPasswordView(container: container, firebaseService: firebaseService)
    }

    private func assembleHomeView(container: Container, firebaseService: FirebaseServiceProtocol) {
        container.register(HomeViewProtocol.self) { (_, router: HomeRouterProtocol) in
            let searchService: SearchServiceProtocol = {
                guard let service = container.resolve(SearchServiceProtocol.self) else {
                    return SearchService()
                }
                return service
            }()
            let coreDataService: CoreDataServiceProtocol = {
                guard let service = container.resolve(CoreDataServiceProtocol.self) else {
                    return CoreDataService()
                }
                return service
            }()
            let view = HomeViewController()
            let presenter = HomePresenter(view: view,
                                          searchService: searchService,
                                          firebaseService: firebaseService,
                                          coreDataService: coreDataService,
                                          router: router)
            view.presenter = presenter
            return view
        }.inObjectScope(.container)
    }

    private func assembleDetailView(container: Container) {
        container.register(DetailViewProtocol.self) { (_,
                                                       dataKind: ResponseDataKind,
                                                       model: ApiResult,
                                                       router: HomeRouterProtocol) in
            let view = DetailViewController()
            let presenter: DetailPresenterProtocol
            if dataKind == .song {
                presenter = AudioPresenter(view: view, model: model, router: router)
            } else {
                presenter = VideoPresenter(view: view, model: model, router: router)
            }
            view.presenter = presenter
            return view
        }.inObjectScope(.container)
    }

    private func assembleCategoryView(container: Container) {
        container.register(CategoryViewProtocol.self) { (_,
                                                         selectedCategory: Category,
                                                         delegate: CategoryPresenterDelegate,
                                                         router: HomeRouterProtocol) in
            let view = CategoryViewController()
            let presenter = CategoryPresenter(view: view,
                                              selectedCategory: selectedCategory,
                                              delegate: delegate,
                                              router: router)
            view.presenter = presenter
            return view
        }.inObjectScope(.container)
    }

    private func assembleSettingsView(container: Container) {
        container.register(SettingsViewProtocol.self) { (_,
                                                         router: HomeRouterProtocol) in
            let view = SettingsViewController()
            let presenter = SettingsPresenter(view: view,
                                              router: router)
            presenter.networkServiceSelected = self.getNetworkOption()
            view.presenter = presenter
            return view
        }.inObjectScope(.container)
    }

    private func getNetworkOption() -> NetworkServiceSelected {
        let userDefaults = UserDefaults.standard
        if let networkServiceSelected = userDefaults.object(forKey: "networkOption") as? String {
            return NetworkServiceSelected(rawValue: networkServiceSelected) ?? .alamofire
        } else {
            userDefaults.setValue(NetworkServiceSelected.alamofire.rawValue, forKey: "networkOption")
            return .alamofire
        }
    }

    private func assembleSignInView(container: Container, firebaseService: FirebaseServiceProtocol) {
        container.register(SignInViewProtocol.self) { (_, router: AuthRouterProtocol) in
            let view = SignInViewController()
            let presenter = SignInPresenter(view: view,
                                            firebaseService: firebaseService,
                                            router: router)
            view.presenter = presenter
            return view
        }.inObjectScope(.container)
    }

    private func assembleLogInView(container: Container, firebaseService: FirebaseServiceProtocol) {
        container.register(LogInViewProtocol.self) { (_, router: AuthRouterProtocol) in
            let view = LoginViewController()
            let presenter = LogInPresenter(view: view,
                                           firebaseService: firebaseService,
                                           router: router)
            view.presenter = presenter
            return view
        }.inObjectScope(.container)
    }

    private func assembleResetPasswordView(container: Container, firebaseService: FirebaseServiceProtocol) {
        container.register(ResetPasswordViewProtocol.self) { (_, router: AuthRouterProtocol) in
            let view = ResetPasswordViewController()
            let presenter = ResetPasswordPresenter(view: view,
                                                   firebaseService: firebaseService,
                                                   router: router)
            view.presenter = presenter
            return view
        }.inObjectScope(.container)
    }
}
