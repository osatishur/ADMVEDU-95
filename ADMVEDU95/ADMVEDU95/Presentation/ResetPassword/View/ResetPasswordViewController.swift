//
//  ResetPasswordViewController.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 21.04.2021.
//

import UIKit
import FirebaseAuth

class ResetPasswordViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet private weak var topLabel: UILabel!
    @IBOutlet private weak var emailTextField: AuthTextField!
    
    var presenter: ResetPasswordPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Password recovery".localized()
    }
    
    @IBAction private func didTapSendButton(_ sender: Any) {
        guard let email = emailTextField.text else {
            return
        }
        presenter?.requestRecovery(email: email)
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension ResetPasswordViewController: ResetPasswordViewProtocol {
    func successRequest() {
        DispatchQueue.main.async {
            self.showAlert(titleMessage: "Success".localized(),
                           message: "Check your email for the next step".localized())
        }
        presenter?.navigateToLogIn()
    }
    
    func handleAuthError(_ error: Error) {
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            print(errorCode.errorMessage)
            let alert = UIAlertController(title: "Error".localized(), message: errorCode.errorMessage, preferredStyle: .alert)

            let okAction = UIAlertAction(title: "OK".localized(), style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
