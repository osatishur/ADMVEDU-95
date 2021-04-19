//
//  HomeViewController+CategoryDelegate.swift
//  ADMVEDU95
//
//  Created by Satsishur on 19.04.2021.
//

import UIKit

extension HomeViewController: CategoryDelegate  {
    func fetchCategory(_ categoryViewController: CategoryViewController, category: Category) {
        categoryTitle = category
        categoryView.configureView(categoryTitle: NSLocalizedString(categoryTitle.rawValue, comment: ""))
    }
}
