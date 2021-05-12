//
//  BaseAuthViewController.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 30.04.2021.
//

import UIKit

class BaseAuthViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func createAttributedTitle(firstTtitle: String, secondTitle: String) -> NSMutableAttributedString {
        let font = UIFont.regularFont
        let subTitleKeys = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        let titleKeys = [NSAttributedString.Key.font: UIFont.regularFont, NSAttributedString.Key.foregroundColor: UIColor.black]
        let attributedTitle = NSMutableAttributedString(string: firstTtitle, attributes: titleKeys)
        attributedTitle.append(NSAttributedString(string: secondTitle, attributes: subTitleKeys))
        return attributedTitle
    }
}
