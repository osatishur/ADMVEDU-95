//
//  CategoryView.swift
//  ADMVEDU95
//
//  Created by Satsishur on 19.04.2021.
//

import UIKit

class CategoryView: UIView {
    struct Constants {
        static let categoryViewSideConstraint: CGFloat = 8
    }
    
    let categoryLabel = UILabel()
    let arrowLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    private func setupLayout() {
        setupSubviews()
        setupCategoryLabel()
        setupArrorLabel()
    }
    
    private func setupSubviews() {
        self.addSubview(categoryLabel)
        self.addSubview(arrowLabel)
    }
    
    private func setupCategoryLabel() {
        categoryLabel.textColor = .white
        categoryLabel.anchor( left: self.leftAnchor,
                              paddingLeft: Constants.categoryViewSideConstraint,
                              centerY: self.centerYAnchor,
                              width: 0,
                              height: 0)
    }
    
    private func setupArrorLabel() {
        arrowLabel.textColor = UIColor.white
        arrowLabel.text = ">"
        arrowLabel.anchor(right: self.rightAnchor,
                          paddingRight: Constants.categoryViewSideConstraint,
                          centerY: self.centerYAnchor,
                          width: 0,
                          height: 0)
    }
    
    func configureView(categoryTitle: String) {
        categoryLabel.text = categoryTitle
    }
}
