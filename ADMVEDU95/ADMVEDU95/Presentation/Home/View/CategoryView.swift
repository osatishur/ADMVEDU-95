//
//  CategoryView.swift
//  ADMVEDU95
//
//  Created by Satsishur on 19.04.2021.
//

import UIKit

class CategoryView: XibView {
    @IBOutlet private var categoryLabel: UILabel!

    func configureView(categoryTitle: String) {
        categoryLabel.text = categoryTitle
    }
}
