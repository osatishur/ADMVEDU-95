//
//  CategoryPresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 27.04.2021.
//

import Foundation

protocol CategoryPresenterDelegate: AnyObject {
    func fetchCategory(_ categoryPresenter: CategoryPresenter, category: Category)
}

protocol CategoryPresenterProtocol: AnyObject {
    func getCategory(indexPath: IndexPath) -> Category
    func getCategoryTitle(indexPath: IndexPath) -> String
    func getSelectedCategoryTitle() -> String
    func numberOfCategories() -> Int
    func onCellSelected(category: Category)
}

class CategoryPresenter: CategoryPresenterProtocol {
    weak var view: CategoryViewProtocol?
    private var router: HomeRouterProtocol?
    private var selectedCategory: Category
    weak var delegate: CategoryPresenterDelegate?
    private var dataSource: [Category] = {
        var data: [Category] = []
        for category in Category.allCases {
            data.append(category)
        }
        return data
    }()

    init(view: CategoryViewProtocol,
         selectedCategory: Category,
         delegate: CategoryPresenterDelegate,
         router: HomeRouterProtocol) {
        self.view = view
        self.selectedCategory = selectedCategory
        self.delegate = delegate
        self.router = router
    }

    func getCategoryTitle(indexPath: IndexPath) -> String {
        dataSource[indexPath.row].description
    }

    func getSelectedCategoryTitle() -> String {
        selectedCategory.description
    }

    func getCategory(indexPath: IndexPath) -> Category {
        dataSource[indexPath.row]
    }

    func numberOfCategories() -> Int {
        dataSource.count
    }

    func onCellSelected(category: Category) {
        delegate?.fetchCategory(self, category: category)
        router?.popToHome()
    }
}
