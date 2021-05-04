//
//  CategoryPresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 27.04.2021.
//

import Foundation

protocol CategoryPresenterProtocol: AnyObject {
    var selectedCategory: Category { get set }
    var delegate: CategoryDelegate? {get set}
    func naviagateToHome()
    func getCategory(indexPath: IndexPath) -> Category
    func getSelectedCategory() -> Category
    func numberOfCategories() -> Int
}

class CategoryPresenter: CategoryPresenterProtocol {
    weak var view: CategoryViewController?
    var router: HomeRouterProtocol?
    var selectedCategory: Category
    weak var delegate: CategoryDelegate?
    var dataSource: [Category] = {
        var data: [Category] = []
        for category in Category.allCases {
            data.append(category)
        }
        return data
    }()
    
    init(view: CategoryViewController, categoryChosed: Category, delegate: CategoryDelegate, router: HomeRouterProtocol) {
        self.view = view
        self.selectedCategory = categoryChosed
        self.delegate = delegate
        self.router = router
    }
    
    func getCategory(indexPath: IndexPath) -> Category {
        return dataSource[indexPath.row]
    }
    
    func getSelectedCategory() -> Category {
        return selectedCategory
    }
    
    func numberOfCategories() -> Int {
        return dataSource.count
    }
    
    func naviagateToHome() {
        router?.popToHome()
    }
}
