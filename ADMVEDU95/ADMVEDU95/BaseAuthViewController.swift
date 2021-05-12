//
//  BaseAuthViewController.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 30.04.2021.
//

import UIKit

class BaseAuthViewController: UIViewController {    
    func createAttributedTitle(title: String, subTitle: String) -> NSMutableAttributedString {
        let attributedTitle = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.regularFont, NSAttributedString.Key.foregroundColor: UIColor.black])
        attributedTitle.append(NSAttributedString(string: subTitle, attributes: [NSAttributedString.Key.font: UIFont.regularFont, NSAttributedString.Key.foregroundColor: UIColor.systemBlue]))
        return attributedTitle
    }
}
