//
//  BaseAuthPresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 30.04.2021.
//

import UIKit

protocol BaseAuthPresenterProtocol {
    func navigateToHome()
}

extension BaseAuthPresenterProtocol {
    func navigateToHome() {
        let sceneDelegate = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)
        guard let builder = sceneDelegate?.builder else {
            return
        }
        let navVC = UINavigationController()
        let router = HomeRouter(navigationController: navVC, builder: builder)
        sceneDelegate?.changeRootViewController(navigationController: navVC, router: router)
    }
}

