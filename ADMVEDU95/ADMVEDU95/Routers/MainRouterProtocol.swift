//
//  RouterMain.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 30.04.2021.
//

import UIKit

protocol MainRouterProtocol {
    var navigationController: UINavigationController? { get set }
    var builder: BuilderProtocol? { get set }
    func initialViewController()
    func changeRootViewController(window: UIWindow?, router: MainRouterProtocol, animated: Bool)
}

extension MainRouterProtocol {
    func changeRootViewController(window: UIWindow?, router: MainRouterProtocol, animated: Bool = true) {
        guard let window = window else {
            return
        }
        router.initialViewController()
        
        window.rootViewController = router.navigationController
        UIView.transition(with: window,
                          duration: 0.8,
                          options: [.transitionCrossDissolve],
                          animations: nil,
                          completion: nil)
    }
}
