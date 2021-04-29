//
//  ModuleBuilder.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 27.04.2021.
//

import UIKit

protocol BuilderProtocol {
    func createHomeView(router: HomeRouterProtocol) -> UIViewController
    func createDetailView(dataKind: ResponseDataKind, model: ApiResult, router: HomeRouterProtocol) -> UIViewController
    func createCategoryView(categoryChosed: Category, delegate: CategoryDelegate, router: HomeRouterProtocol) -> UIViewController
    func createSignInView(router: AuthFlowRouter) -> UIViewController
    func createLogInView(router: AuthFlowRouter) -> UIViewController
    func createResetPasswordView(router: AuthFlowRouter) -> UIViewController
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
        let presenter = DetailPresenter(view: view,
                                        dataKind: dataKind, model: model,
                                        router: router)
        view.presenter = presenter
        view.configureView(model: model)
        return view
    }
    
    func createCategoryView(categoryChosed: Category, delegate: CategoryDelegate, router: HomeRouterProtocol) -> UIViewController {
        let view = CategoryViewController()
        let presenter = CategoryPresenter(view: view,
                                          categoryChosed: categoryChosed,
                                          delegate: delegate,
                                          router: router)
        view.presenter = presenter
        return view
    }
    
    func createSignInView(router: AuthFlowRouter) -> UIViewController {
        let view = SignInViewController()
        let firebaseService = FirebaseService()
        let presenter = SignInPresenter(view: view,
                                        firebaseService: firebaseService,
                                        router: router)
        view.presenter = presenter
        return view
    }
    
    func createLogInView(router: AuthFlowRouter) -> UIViewController {
        let view = LoginViewController()
        let firebaseService = FirebaseService()
        let presenter = LogInPresenter(view: view,
                                       firebaseService: firebaseService,
                                       router: router)
        view.presenter = presenter
        return view
    }
    
    func createResetPasswordView(router: AuthFlowRouter) -> UIViewController {
        let view = ResetPasswordViewController()
        let firebaseService = FirebaseService()
        let presenter = ResetPasswordPresenter(view: view,
                                               firebaseService: firebaseService,
                                               router: router)
        view.presenter = presenter
        return view
    }
}
