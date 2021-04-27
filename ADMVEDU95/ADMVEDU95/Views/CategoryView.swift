//
//  CategoryView.swift
//  ADMVEDU95
//
//  Created by Satsishur on 19.04.2021.
//

import UIKit

class CategoryView: UIView {
    private struct Constants {
        static let nibName = "CategoryView"
    }
    
    @IBOutlet private weak var categoryLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit(nibName: Constants.nibName)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit(nibName: Constants.nibName)
    }
    
    func configureView(categoryTitle: String) {
        categoryLabel.text = categoryTitle
    }
}
