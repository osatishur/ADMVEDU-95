//
//  BaseRouterProtocol.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 30.04.2021.
//

import UIKit

protocol BaseRouterProtocol {
    func navigateToHome()
    func navigateToAuth()
}

extension BaseRouterProtocol {
    var sceneDelegate: SceneDelegate? {
        return (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)
    }
    var homeRouter: HomeRouter {
        let navVC = UINavigationController()
        let builder = ViewBuilder()
        return HomeRouter(navigationController: navVC, builder: builder)
    }
    
    var authRouter: AuthRouter {
        let navVC = UINavigationController()
        let builder = ViewBuilder()
        return AuthRouter(navigationController: navVC, builder: builder)
    }
    
    func navigateToHome() {
        sceneDelegate?.changeRootViewController(router: homeRouter)
    }
    
    func navigateToAuth() {
        sceneDelegate?.changeRootViewController(router: authRouter)
    }
}
