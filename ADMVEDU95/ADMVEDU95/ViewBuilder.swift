//
//  ViewBuilder.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 27.04.2021.
//

import UIKit

protocol BuilderProtocol {
    func createHomeView(router: HomeRouterProtocol) -> UIViewController
    func createDetailView(dataKind: ResponseDataKind,
                          model: ApiResult,
                          router: HomeRouterProtocol) -> UIViewController
    func createCategoryView(selectedCategory: Category,
                            delegate: CategoryViewModelDelegate,
                            router: HomeRouterProtocol) -> UIViewController
    func createSettingsView(router: HomeRouterProtocol) -> UIViewController
    func createSignInView(router: AuthRouterProtocol) -> UIViewController
    func createLogInView(router: AuthRouterProtocol) -> UIViewController
    func createResetPasswordView(router: AuthRouterProtocol) -> UIViewController
}

class ViewBuilder: BuilderProtocol {
    let dependencyAssembler = DependencyProvider.assembler.resolver

    func createHomeView(router: HomeRouterProtocol) -> UIViewController {
        let view = dependencyAssembler.resolve(HomeViewProtocol.self,
                                                argument: router)
        guard let view = view as? UIViewController else {
            return UIViewController()
        }
        return view
    }

    func createDetailView(dataKind: ResponseDataKind, model: ApiResult, router: HomeRouterProtocol) -> UIViewController {
        let view = dependencyAssembler.resolve(DetailViewProtocol.self, arguments: dataKind, model, router)
        guard let view = view as? UIViewController else {
            return UIViewController()
        }
        return view
    }

    func createCategoryView(selectedCategory: Category,
                            delegate: CategoryViewModelDelegate,
                            router: HomeRouterProtocol) -> UIViewController {
        let view = dependencyAssembler.resolve(CategoryViewProtocol.self, arguments: selectedCategory, delegate, router)
        guard let view = view as? UIViewController else {
            return UIViewController()
        }
        return view
    }

    func createSettingsView(router: HomeRouterProtocol) -> UIViewController {
        let view = dependencyAssembler.resolve(SettingsViewProtocol.self, argument: router)
        guard let view = view as? UIViewController else {
            return UIViewController()
        }
        return view
    }

    func createSignInView(router: AuthRouterProtocol) -> UIViewController {
        let view = dependencyAssembler.resolve(SignInViewProtocol.self, argument: router)
        guard let view = view as? UIViewController else {
            return UIViewController()
        }
        return view
    }

    func createLogInView(router: AuthRouterProtocol) -> UIViewController {
        let view = dependencyAssembler.resolve(LogInViewProtocol.self, argument: router)
        guard let view = view as? UIViewController else {
            return UIViewController()
        }
        return view
    }

    func createResetPasswordView(router: AuthRouterProtocol) -> UIViewController {
        let view = dependencyAssembler.resolve(ResetPasswordViewProtocol.self, argument: router)
        guard let view = view as? UIViewController else {
            return UIViewController()
        }
        return view
    }
}
