//
//  ViewController+ShowAlert.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 21.04.2021.
//

import UIKit

extension UIViewController {
    func showAlert(titleMessage: String, message: String) {
        let alert = UIAlertController(title: titleMessage, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.localizable.oK(), style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithRetry(message: String, completion: @escaping () -> ()) {
        let alert = UIAlertController(title: R.string.localizable.error(), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.localizable.retry(), style: .default, handler: { (action: UIAlertAction!) in
              completion()
        }))

        alert.addAction(UIAlertAction(title: R.string.localizable.cancel(), style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
}
