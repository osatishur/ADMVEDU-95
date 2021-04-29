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

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        let router: RouterMain?
        let navigationController = UINavigationController()
        
        if Auth.auth().currentUser == nil {
            router = AuthFlowRouter(navigationController: navigationController, builder: builder)
        } else {
            router = HomeRouter(navigationController: navigationController, builder: builder)
        }
        
        router?.initialViewController()
        self.window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func changeRootViewController(navigationController: UINavigationController, router: RouterMain, animated: Bool = true) {
        guard let window = self.window else {
            return
        }
        router.initialViewController()
        
        window.rootViewController = navigationController
        UIView.transition(with: window,
                          duration: 0.8,
                          options: [.transitionCrossDissolve],
                          animations: nil,
                          completion: nil)
    }
}
