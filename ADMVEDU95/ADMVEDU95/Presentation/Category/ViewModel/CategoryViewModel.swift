//
//  CategoryPresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 27.04.2021.
//

import Foundation

protocol CategoryViewModelDelegate: AnyObject {
    func fetchCategory(_ categoryViewModel: CategoryViewModel, category: Category)
}

protocol CategoryViewModelProtocol: AnyObject {
    func getCategory(row: Int) -> Category
    func getCategoryTitle(row: Int) -> String
    func numberOfCategories() -> Int
    func onCellSelected(category: Category)
    func isCategoryMatched(row: Int) -> Bool
}

class CategoryViewModel: CategoryViewModelProtocol {
    private var router: HomeRouterProtocol?
    var selectedCategory: Category
    weak var delegate: CategoryViewModelDelegate?
    private var dataSource: [Category] = {
        var data: [Category] = []
        for category in Category.allCases {
            data.append(category)
        }
        return data
    }()

    init(selectedCategory: Category, delegate: CategoryViewModelDelegate, router: HomeRouterProtocol) {
        self.selectedCategory = selectedCategory
        self.delegate = delegate
        self.router = router
    }

    func getCategoryTitle(row: Int) -> String {
        dataSource[row].description
    }

    func getCategory(row: Int) -> Category {
        dataSource[row]
    }

    func numberOfCategories() -> Int {
        dataSource.count
    }

    func isCategoryMatched(row: Int) -> Bool {
        let isMatched = dataSource[row] == selectedCategory
        print(isMatched)
        return isMatched
    }

    func onCellSelected(category: Category) {
        delegate?.fetchCategory(self, category: category)
        router?.popToHome()
    }
}
