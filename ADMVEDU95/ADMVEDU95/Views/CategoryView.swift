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
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let viewFromXib = Bundle.main.loadNibNamed(Constants.nibName, owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        viewFromXib.backgroundColor = UIColor.categoryViewColor
        addSubview(viewFromXib)
    }

    func configureView(categoryTitle: String) {
        categoryLabel.text = categoryTitle
    }
}
