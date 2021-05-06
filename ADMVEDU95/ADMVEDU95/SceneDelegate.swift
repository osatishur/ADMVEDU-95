//
//  SceneDelegate.swift
//  FirstWorkProject
//
//  Created by Satsishur on 12.04.2021.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    let builder = ViewBuilder()
    var applicationRouter: ApplicationRouter?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        self.window = UIWindow(windowScene: windowScene)
        guard let window = self.window else {
            return
        }
        if Auth.auth().currentUser == nil {
            applicationRouter = ApplicationRouter(isHomeInitial: false, window: window)
        } else {
            applicationRouter = ApplicationRouter(isHomeInitial: true, window: window)
        }
        
        applicationRouter?.mainRouter?.initialViewController()
        window.rootViewController = applicationRouter?.mainNavigationController
        window.makeKeyAndVisible()
    }
    
//    func changeRootViewController(router: MainRouterProtocol, animated: Bool = true) {
//        guard let window = self.window else {
//            return
//        }
//        router.initialViewController()
//
//        window.rootViewController = router.navigationController
//        UIView.transition(with: window,
//                          duration: 0.8,
//                          options: [.transitionCrossDissolve],
//                          animations: nil,
//                          completion: nil)
//    }
}
