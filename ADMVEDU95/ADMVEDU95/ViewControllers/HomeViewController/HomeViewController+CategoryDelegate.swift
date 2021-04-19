//
//  HomeViewController+CategoryDelegate.swift
//  ADMVEDU95
//
//  Created by Satsishur on 19.04.2021.
//

import UIKit

extension HomeViewController: CategoryDelegate  {
    func fetchCategory(category: iTunesCategory) {
        categoryTitle = category
        categoryLabel.text = category.rawValue
    }
}
