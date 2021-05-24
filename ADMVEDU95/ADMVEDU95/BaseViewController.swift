//
//  BaseViewController.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 21.05.2021.
//

import UIKit

protocol BaseControllerType {
    var navigationTitle: String { get }
}

extension BaseControllerType {
    var navigationTitle: String {
        "Default title"
    }
}

class BaseViewController: UIViewController, BaseControllerType {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = navigationTitle
    }
}
