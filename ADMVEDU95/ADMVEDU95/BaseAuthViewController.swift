//
//  BaseAuthViewController.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 30.04.2021.
//

import UIKit

class BaseAuthViewController: UIViewController {
    override func viewWillAppear(_: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    func createAttributedTitle(title: String, subTitle: String) -> NSMutableAttributedString {
        let titleColor = UIColor.attributedButtonTitle
        let subtitleColor = UIColor.attributedButtonSubTitle
        let font = UIFont.regularFont
        let titleKeys = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: titleColor]
        let subTitleKeys = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: subtitleColor]
        let attributedTitle = NSMutableAttributedString(string: title, attributes: titleKeys)
        attributedTitle.append(NSAttributedString(string: subTitle, attributes: subTitleKeys))
        return attributedTitle
    }
}
