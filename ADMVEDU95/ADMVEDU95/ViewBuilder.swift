//
//  ViewBuilder.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 27.04.2021.
//

import UIKit

protocol BuilderProtocol {
    func createHomeView(router: HomeRouterProtocol) -> UIViewController
    func createDetailView(dataKind: ResponseDataKind, model: ApiResult, router: HomeRouterProtocol) -> UIViewController
    func createCategoryView(selectedCategory: Category, delegate: CategoryPresenterDelegate, router: HomeRouterProtocol) -> UIViewController
    func createSignInView(router: AuthRouter) -> UIViewController
    func createLogInView(router: AuthRouter) -> UIViewController
    func createResetPasswordView(router: AuthRouter) -> UIViewController
}

class ViewBuilder: BuilderProtocol {
    func createHomeView(router: HomeRouterProtocol) -> UIViewController {
        let view = HomeViewController()
        let searchService = SearchService()
        let firebaseService = FirebaseService()
        let presenter = HomePresenter(view: view,
                                      searchService: searchService,
                                      firebaseService: firebaseService,
                                      router: router)
        view.presenter = presenter
        return view
    }
    
    func createDetailView(dataKind: ResponseDataKind, model: ApiResult, router: HomeRouterProtocol) -> UIViewController {
        let view = DetailViewController()
        let presenter: DetailPresenterProtocol
        if dataKind == .song {
            presenter = AudioPresenter(view: view,
                                       model: model,
                                       router: router)
        } else {
            presenter = VideoPresenter(view: view,
                                       model: model,
                                       router: router)
        }
        view.presenter = presenter
        return view
    }
    
    func createCategoryView(selectedCategory: Category, delegate: CategoryPresenterDelegate, router: HomeRouterProtocol) -> UIViewController {
        let view = CategoryViewController()
        let presenter = CategoryPresenter(view: view,
                                          selectedCategory: selectedCategory,
                                          delegate: delegate,
                                          router: router)
        view.presenter = presenter
        return view
    }
    
    func createSignInView(router: AuthRouter) -> UIViewController {
        let view = SignInViewController()
        let firebaseService = FirebaseService()
        let presenter = SignInPresenter(view: view,
                                        firebaseService: firebaseService,
                                        router: router)
        view.presenter = presenter
        return view
    }
    
    func createLogInView(router: AuthRouter) -> UIViewController {
        let view = LoginViewController()
        let firebaseService = FirebaseService()
        let presenter = LogInPresenter(view: view,
                                       firebaseService: firebaseService,
                                       router: router)
        view.presenter = presenter
        return view
    }
    
    func createResetPasswordView(router: AuthRouter) -> UIViewController {
        let view = ResetPasswordViewController()
        let firebaseService = FirebaseService()
        let presenter = ResetPasswordPresenter(view: view,
                                               firebaseService: firebaseService,
                                               router: router)
        view.presenter = presenter
        return view
    }
}
