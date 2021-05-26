//
//  RoterAssembler.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 26.05.2021.
//
// swiftlint:disable closure_parameter_position
import Foundation
import Swinject

class RouterAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ApplicationRouter.self) { (_, isHomeInitial: Bool, window: UIWindow) in
            let router = ApplicationRouter(isHomeInitial: isHomeInitial, window: window)
            return router
        }.inObjectScope(.container)

        container.register(AuthRouterProtocol.self) { (_,
                                                       navigationController: UINavigationController,
                                                       builder: ViewBuilder,
                                                       window: UIWindow) in
            let router = AuthRouter(navigationController: navigationController, builder: builder, window: window)
            return router
        }.inObjectScope(.container)

        container.register(HomeRouterProtocol.self) { (_,
                                                       navigationController: UINavigationController,
                                                       builder: ViewBuilder,
                                                       window: UIWindow) in
            let router = HomeRouter(navigationController: navigationController, builder: builder, window: window)
            return router
        }.inObjectScope(.container)
    }
}
