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
        if Auth.auth().currentUser == nil {
            applicationRouter = ApplicationRouter(isHomeInitial: false, window: window)
        } else {
            applicationRouter = ApplicationRouter(isHomeInitial: true, window: window)
        }
    }
}
