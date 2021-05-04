//
//  AuthRouter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 29.04.2021.
//

import UIKit

protocol AuthRouterProtocol: MainRouterProtocol {
    func initialViewController()
    func showSignIn()
    func showResetPassword()
    func popToLogIn()
}

class AuthRouter: AuthRouterProtocol {
    var navigationController: UINavigationController?
    var builder: BuilderProtocol?
    
    init(navigationController: UINavigationController, builder: BuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let logInViewController = builder?.createLogInView(router: self) else {
                return
            }
            navigationController.viewControllers = [logInViewController]
        }
    }
    
    func showSignIn() {
        if let navigationController = navigationController {
            guard let signInViewController = builder?.createSignInView(router: self) else {
                return
            }
            navigationController.pushViewController(signInViewController, animated: true)
        }
    }
    
    func showResetPassword() {
        if let navigationController = navigationController {
            guard let resetPasswordViewController = builder?.createResetPasswordView(router: self) else {
                return
            }
            navigationController.pushViewController(resetPasswordViewController, animated: true)
        }
    }
        
    func popToLogIn() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
}
