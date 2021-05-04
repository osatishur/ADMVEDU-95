//
//  AuthBaseViewController.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 30.04.2021.
//

import UIKit

class AuthBaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func createAttributedTitle(firstTtitle: String, secondTitle: String) -> NSMutableAttributedString {
        let attributedTitle = NSMutableAttributedString(string: firstTtitle, attributes: [NSAttributedString.Key.font: UIFont.regularFont, NSAttributedString.Key.foregroundColor: UIColor.black])
        attributedTitle.append(NSAttributedString(string: secondTitle, attributes: [NSAttributedString.Key.font: UIFont.regularFont, NSAttributedString.Key.foregroundColor: UIColor.systemBlue]))
        return attributedTitle
    }
}
