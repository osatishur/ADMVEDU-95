//
//  ApplicationRouter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 04.05.2021.
//

import UIKit

class ApplicationRouter {
    var mainRouter: MainRouterProtocol?
    var mainNavigationController = UINavigationController()
    var viewBuilder = ViewBuilder()

    init(isHomeInitial: Bool) {
        if isHomeInitial {
            mainRouter = HomeRouter(navigationController: mainNavigationController, builder: viewBuilder)
        } else {
            mainRouter = AuthRouter(navigationController: mainNavigationController, builder: viewBuilder)
        }
    }
}
