//
//  CategoryPresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 27.04.2021.
//

import Foundation

protocol CategoryPresenterProtocol: AnyObject {
    var selectedCategory: Category { get set }
    func getCategory(indexPath: IndexPath) -> Category
    func getSelectedCategory() -> Category
    func numberOfCategories() -> Int
    func onCellSelected(category: Category)
    func navigateToHome()
}

class CategoryPresenter: CategoryPresenterProtocol {
    weak var view: CategoryViewProtocol?
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

    init(view: CategoryViewProtocol, categoryChosed: Category, delegate: CategoryDelegate, router: HomeRouterProtocol) {
        self.view = view
        selectedCategory = categoryChosed
        self.delegate = delegate
        self.router = router
    }

    func getCategory(indexPath: IndexPath) -> Category {
        dataSource[indexPath.row]
    }

    func getSelectedCategory() -> Category {
        selectedCategory
    }

    func numberOfCategories() -> Int {
        dataSource.count
    }

    func onCellSelected(category: Category) {
        guard let view = view else {
            return
        }
        delegate?.fetchCategory(view, category: category)
    }

    func navigateToHome() {
        router?.popToHome()
    }
}
