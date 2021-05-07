//
//  ResetPasswordViewController.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 21.04.2021.
//

import FirebaseAuth
import UIKit

protocol ResetPasswordViewProtocol: AnyObject {
    func successRequest(title: String, message: String)
    func handleAuthError(_ error: Error, alertTitle: String)
}

class ResetPasswordViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet private var topLabel: UILabel!
    @IBOutlet private var emailTextField: AuthTextField!

    var presenter: ResetPasswordPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func setupNavigationBar() {
        navigationItem.title = "Password recovery".localized()
    }

    @IBAction private func didTapSendButton(_: Any) {
        guard let email = emailTextField.text else {
            return
        }
        presenter?.requestRecovery(email: email)
    }

    func textFieldShouldReturn(_: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}

extension ResetPasswordViewController: ResetPasswordViewProtocol {
    func successRequest(title: String, message: String) {
        DispatchQueue.main.async {
            self.showAlert(titleMessage: title, message: message)
        }
        presenter?.navigateToLogIn()
    }

    func handleAuthError(_ error: Error, alertTitle: String) {
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            showAlert(titleMessage: alertTitle, message: errorCode.errorMessage.localized())
        }
    }
}
