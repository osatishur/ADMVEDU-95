//
//  Router.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 29.04.2021.
//

import UIKit

protocol HomeRouterProtocol: RouterMain {
    func showCategory(categoryChosed: Category, delegate: CategoryDelegate)
    func showDetail(dataKind: ResponseDataKind, model: ApiResult)
    func popToHome()
}

class HomeRouter: HomeRouterProtocol {
    var navigationController: UINavigationController?
    var builder: BuilderProtocol?
    
    init(navigationController: UINavigationController, builder: BuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let homeViewController = builder?.createHomeView(router: self) else {
                return
            }
            navigationController.viewControllers = [homeViewController]
        }
    }
    
    func showCategory(categoryChosed: Category, delegate: CategoryDelegate) {
        if let navigationController = navigationController {
            guard let categoryViewController = builder?.createCategoryView(categoryChosed: categoryChosed, delegate: delegate, router: self) else {
                return
            }
            navigationController.pushViewController(categoryViewController, animated: true)
        }
    }
    
    func showDetail(dataKind: ResponseDataKind, model: ApiResult) {
        if let navigationController = navigationController {
            guard let detailViewController = builder?.createDetailView(dataKind: dataKind, model: model, router: self) else {
                return
            }
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
    
    func popToHome() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
}
