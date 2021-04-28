//
//  CategoryPresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 27.04.2021.
//

import Foundation

protocol CategoryViewPresenterProtocol: class {
    init(view: CategoryViewController, categoryChosed: Category, delegate: CategoryDelegate)
    var dataSource: [Category] { get set }
    var categoryChosed: Category! { get set }
    var delegate: CategoryDelegate { get set }
}

class CategoryPresenter: CategoryViewPresenterProtocol {
    weak var view: CategoryViewController?
    var categoryChosed: Category!
    var delegate: CategoryDelegate
    var dataSource: [Category] = {
        var data: [Category] = []
        for category in Category.allCases {
            data.append(category)
        }
        return data
    }()
    
    required init(view: CategoryViewController, categoryChosed: Category, delegate: CategoryDelegate) {
        self.view = view
        self.categoryChosed = categoryChosed
        self.delegate = delegate
    }
}
