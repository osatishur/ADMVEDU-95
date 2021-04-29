//
//  CategoryPresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 27.04.2021.
//

import Foundation

protocol CategoryViewPresenterProtocol: class {
    init(view: CategoryViewController, categoryChosed: Category, delegate: CategoryDelegate, router: HomeRouterProtocol)
    var dataSource: [Category] { get set }
    var categoryChosed: Category! { get set }
    var delegate: CategoryDelegate { get set }
    func naviagateToHome()
}

class CategoryPresenter: CategoryViewPresenterProtocol {
    weak var view: CategoryViewController?
    var router: HomeRouterProtocol?
    var categoryChosed: Category!
    var delegate: CategoryDelegate
    var dataSource: [Category] = {
        var data: [Category] = []
        for category in Category.allCases {
            data.append(category)
        }
        return data
    }()
    
    required init(view: CategoryViewController, categoryChosed: Category, delegate: CategoryDelegate, router: HomeRouterProtocol) {
        self.view = view
        self.categoryChosed = categoryChosed
        self.delegate = delegate
        self.router = router
    }
    
    func naviagateToHome() {
        router?.popToHome()
    }
}
