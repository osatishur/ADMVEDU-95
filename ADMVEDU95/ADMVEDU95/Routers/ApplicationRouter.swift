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

    init(isHomeInitial: Bool, window: UIWindow) {
        let dependencyAssembler = DependencyProvider.assembler.resolver
        if isHomeInitial {
            mainRouter = dependencyAssembler.resolve(HomeRouterProtocol.self, arguments: mainNavigationController, viewBuilder, window)
        } else {
            mainRouter = dependencyAssembler.resolve(AuthRouterProtocol.self, arguments: mainNavigationController, viewBuilder, window)
        }
    }
}
