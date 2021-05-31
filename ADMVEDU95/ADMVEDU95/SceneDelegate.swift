//
//  SceneDelegate.swift
//  FirstWorkProject
//
//  Created by Satsishur on 12.04.2021.
//

import FirebaseAuth
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var applicationRouter: ApplicationRouter?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        self.window = UIWindow(windowScene: windowScene)
        guard let window = self.window else {
            return
        }
        setApplicationRouter(with: window)
        applicationRouter?.mainRouter?.initialViewController()
        window.rootViewController = applicationRouter?.mainNavigationController
        window.makeKeyAndVisible()
    }

    private func setApplicationRouter(with window: UIWindow) {
        let dependencyAssembler = DependencyProvider.assembler.resolver
        if Auth.auth().currentUser == nil {
            applicationRouter = dependencyAssembler.resolve(ApplicationRouter.self, arguments: false, window)
        } else {
            applicationRouter = dependencyAssembler.resolve(ApplicationRouter.self, arguments: true, window)
        }
    }
}
