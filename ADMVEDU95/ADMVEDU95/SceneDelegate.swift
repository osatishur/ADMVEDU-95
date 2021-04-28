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
    var initialVC = UIViewController()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        if Auth.auth().currentUser == nil {
            initialVC = ModuleBuilder.createLogInModule()
        } else {
            initialVC = ModuleBuilder.createHomeModule()
        }
        self.window?.rootViewController = UINavigationController(rootViewController: initialVC)
        window?.makeKeyAndVisible()
    }
    
    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else {
            return
        }
        window.rootViewController = vc
        UIView.transition(with: window,
                          duration: 0.8,
                          options: [.transitionCrossDissolve],
                          animations: nil,
                          completion: nil)
    }
}
