//
//  ViewController+ShowAlert.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 21.04.2021.
//

import UIKit

extension UIViewController {
    func showAlert(titleMessage: String, message: String) {
        let alert = UIAlertController(title: titleMessage,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.localizable.alertOkTitle(),
                                      style: .default))
        present(alert, animated: true, completion: nil)
    }

    func showAlertWithRetry(message: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: R.string.localizable.alertErrorTitle(),
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.localizable.alertRetryAction(),
                                      style: .default,
                                      handler: { _ in
                                          completion()
                                      }))

        alert.addAction(UIAlertAction(title: R.string.localizable.alertCancelAction(),
                                      style: .cancel))
        present(alert, animated: true, completion: nil)
    }
}
