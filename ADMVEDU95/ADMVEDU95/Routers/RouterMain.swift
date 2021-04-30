//
//  RouterMain.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 30.04.2021.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var builder: BuilderProtocol? { get set }
    func initialViewController()
}
