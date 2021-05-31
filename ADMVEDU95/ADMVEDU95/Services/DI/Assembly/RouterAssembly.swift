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
        assembleApplicationRouter(container: container)
        assembleAuthRouter(container: container)
        assembleHomeRouter(container: container)
    }

    private func assembleApplicationRouter(container: Container) {
        container.register(ApplicationRouter.self) { (_, isHomeInitial: Bool, window: UIWindow) in
            let router = ApplicationRouter(isHomeInitial: isHomeInitial, window: window)
            return router
        }.inObjectScope(.container)
    }

    private func assembleAuthRouter(container: Container) {
        container.register(AuthRouterProtocol.self) { (_,
                                                       navigationController: UINavigationController,
                                                       builder: ViewBuilder,
                                                       window: UIWindow) in
            let router = AuthRouter(navigationController: navigationController, builder: builder, window: window)
            return router
        }.inObjectScope(.container)
    }

    private func assembleHomeRouter(container: Container) {
        container.register(HomeRouterProtocol.self) { (_,
                                                       navigationController: UINavigationController,
                                                       builder: ViewBuilder,
                                                       window: UIWindow) in
            let router = HomeRouter(navigationController: navigationController, builder: builder, window: window)
            return router
        }.inObjectScope(.container)
    }
}
