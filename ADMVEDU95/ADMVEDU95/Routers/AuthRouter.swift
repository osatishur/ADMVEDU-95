//
//  AuthRouter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 29.04.2021.
//

import UIKit

protocol AuthRouterProtocol: MainRouterProtocol {
    func initialViewController()
    func navigateToSignIn()
    func navigateToResetPassword()
    func popToLogIn()
    func navigateToHome()
}

class AuthRouter: AuthRouterProtocol {
    var navigationController: UINavigationController?
    var builder: BuilderProtocol?
    var window: UIWindow?
    
    var homeRouter: HomeRouter {
        let navVC = UINavigationController()
        let builder = ViewBuilder()
        return HomeRouter(navigationController: navVC, builder: builder, window: window ?? UIWindow())
    }
    
    init(navigationController: UINavigationController, builder: BuilderProtocol, window: UIWindow) {
        self.navigationController = navigationController
        self.builder = builder
        self.window = window
    }
    
    func initialViewController() {
        guard let navigationController = navigationController,
              let logInViewController = builder?.createLogInView(router: self) else {
            return
        }
        navigationController.viewControllers = [logInViewController]
    }
    
    func navigateToSignIn() {
        guard let navigationController = navigationController,
              let signInViewController = builder?.createSignInView(router: self) else {
            return
        }
        navigationController.pushViewController(signInViewController, animated: true)
    }
    
    func navigateToResetPassword() {
        guard let navigationController = navigationController,
              let resetPasswordViewController = builder?.createResetPasswordView(router: self) else {
            return
        }
        navigationController.pushViewController(resetPasswordViewController, animated: true)
    }
    
    func popToLogIn() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    func navigateToHome() {
        changeRootViewController(window: window, router: homeRouter)
    }
}
