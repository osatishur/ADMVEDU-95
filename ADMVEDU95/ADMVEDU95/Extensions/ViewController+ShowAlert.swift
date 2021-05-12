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
        alert.addAction(UIAlertAction(title: "OK".localized(), style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithRetry(message: String, completion: @escaping () -> ()) {
        let alert = UIAlertController(title: "Error".localized(), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry".localized(), style: .default, handler: { (action: UIAlertAction!) in
              completion()
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
}
