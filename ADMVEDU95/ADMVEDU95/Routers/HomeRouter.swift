//
//  HomeRouter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 29.04.2021.
//

import UIKit

protocol HomeRouterProtocol: MainRouterProtocol {
    func navigateToCategory(selectedCategory: Category, delegate: CategoryPresenterDelegate)
    func navigateToDetail(dataKind: ResponseDataKind, model: ApiResult)
    func navigateToAuth()
    func navigateToSettings()
    func popToHome()
}

class HomeRouter: HomeRouterProtocol {
    var navigationController: UINavigationController?
    var builder: BuilderProtocol?
    var window: UIWindow?

    var authRouter: AuthRouter {
        let navVC = UINavigationController()
        let builder = ViewBuilder()
        return AuthRouter(navigationController: navVC, builder: builder, window: window ?? UIWindow())
    }

    init(navigationController: UINavigationController, builder: BuilderProtocol, window: UIWindow) {
        self.navigationController = navigationController
        self.builder = builder
        self.window = window
    }

    func initialViewController() {
        guard let navigationController = navigationController,
              let homeViewController = builder?.createHomeView(router: self) else {
            return
        }
        navigationController.viewControllers = [homeViewController]
    }

    func navigateToCategory(selectedCategory: Category, delegate: CategoryPresenterDelegate) {
        guard let navigationController = navigationController,
              let categoryViewController = builder?.createCategoryView(selectedCategory: selectedCategory,
                                                                       delegate: delegate,
                                                                       router: self) else {
            return
        }
        navigationController.pushViewController(categoryViewController, animated: true)
    }

    func navigateToDetail(dataKind: ResponseDataKind, model: ApiResult) {
        guard let navigationController = navigationController,
              let detailViewController = builder?.createDetailView(dataKind: dataKind, model: model, router: self) else {
            return
        }
        navigationController.pushViewController(detailViewController, animated: true)
    }

    func navigateToSettings() {
        guard let navigationController = navigationController,
              let settingsViewController = builder?.createSettingsView(router: self) else {
            return
        }
        navigationController.pushViewController(settingsViewController, animated: true)
    }

    func popToHome() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }

    func navigateToAuth() {
        changeRootViewController(window: window, router: authRouter)
    }
}
