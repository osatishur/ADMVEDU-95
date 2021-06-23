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
            let viewModel = HomeViewModel(searchService: searchService,
                                          firebaseService: firebaseService,
                                          coreDataService: coreDataService,
                                          router: router)
            view.viewModel = viewModel
            return view
        }.inObjectScope(.container)
    }

    private func assembleDetailView(container: Container) {
        container.register(DetailViewProtocol.self) { (_,
                                                       dataKind: ResponseDataKind,
                                                       model: ApiResult,
                                                       router: HomeRouterProtocol) in
            if dataKind == .song {
                let view = DetailAudioViewController()
                let viewModel = AudioViewModel(model: model, router: router)
                view.viewModel = viewModel
                return view
            } else {
                let view = DetailVideoViewController()
                let viewModel = VideoViewModel(model: model, router: router)
                view.viewModel = viewModel
                return view
            }
        }
    }

    private func assembleCategoryView(container: Container) {
        container.register(CategoryViewProtocol.self) { (_,
                                                         selectedCategory: Category,
                                                         delegate: CategoryViewModelDelegate,
                                                         router: HomeRouterProtocol) in
            let view = CategoryViewController()
            let viewModel = CategoryViewModel(selectedCategory: selectedCategory, delegate: delegate, router: router)
            view.viewModel = viewModel
            return view
        }
    }

    private func assembleSettingsView(container: Container) {
        container.register(SettingsViewProtocol.self) { (_,
                                                         router: HomeRouterProtocol) in
            let view = SettingsViewController()

            let networkFrameworkSelected = UserDefaults.getNetworkFramework()
            let viewModel = SettingsViewModel(router: router, networkFrameworkSelected: networkFrameworkSelected)
            view.viewModel = viewModel
            return view
        }.inObjectScope(.container)
    }

    private func assembleSignInView(container: Container, firebaseService: FirebaseServiceProtocol) {
        container.register(SignInViewProtocol.self) { (_, router: AuthRouterProtocol) in
            let view = SignInViewController()
            let viewModel = SignInViewModel(firebaseService: firebaseService, router: router)
            view.viewModel = viewModel
            return view
        }.inObjectScope(.container)
    }

    private func assembleLogInView(container: Container, firebaseService: FirebaseServiceProtocol) {
        container.register(LogInViewProtocol.self) { (_, router: AuthRouterProtocol) in
            let view = LoginViewController()
            let viewModel = LogInViewModel(firebaseService: firebaseService, router: router)
            view.viewModel = viewModel
            return view
        }.inObjectScope(.container)
    }

    private func assembleResetPasswordView(container: Container, firebaseService: FirebaseServiceProtocol) {
        container.register(ResetPasswordViewProtocol.self) { (_, router: AuthRouterProtocol) in
            let view = ResetPasswordViewController()
            let viewModel = ResetPasswordViewModel(firebaseService: firebaseService, router: router)
            view.viewModel = viewModel
            return view
        }.inObjectScope(.container)
    }
}
