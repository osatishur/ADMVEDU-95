//
//  ViewBuilderAssembly.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 26.05.2021.
//
// swiftlint:disable function_body_length closure_parameter_position
import Foundation
import Swinject

class ViewBuilderAssembly: Assembly {
    func assemble(container: Container) {

        let firebaseService = container.resolve(FirebaseServiceProtocol.self)!

        container.register(HomeViewProtocol.self) { (resolver, router: HomeRouterProtocol) in
            let view = HomeViewController()
            let searchService = resolver.resolve(SearchServiceProtocol.self)!
            let coreDataService = resolver.resolve(CoreDataServiceProtocol.self)!
            let presenter = HomePresenter(view: view,
                                          searchService: searchService,
                                          firebaseService: firebaseService,
                                          coreDataService: coreDataService,
                                          router: router)
            view.presenter = presenter
            return view
        }.inObjectScope(.container)

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

        container.register(SignInViewProtocol.self) { (resolver, router: AuthRouterProtocol) in
            let view = SignInViewController()
            let presenter = SignInPresenter(view: view,
                                            firebaseService: firebaseService,
                                            router: router)
            view.presenter = presenter
            return view
        }.inObjectScope(.container)

        container.register(LogInViewProtocol.self) { (resolver, router: AuthRouterProtocol) in
            let view = LoginViewController()
            let presenter = LogInPresenter(view: view,
                                           firebaseService: firebaseService,
                                           router: router)
            view.presenter = presenter
            return view
        }.inObjectScope(.container)

        container.register(ResetPasswordViewProtocol.self) { (resolver, router: AuthRouterProtocol) in
            let view = ResetPasswordViewController()
            let presenter = ResetPasswordPresenter(view: view,
                                                   firebaseService: firebaseService,
                                                   router: router)
            view.presenter = presenter
            return view
        }.inObjectScope(.container)
    }
}
