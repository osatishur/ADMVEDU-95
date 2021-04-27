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
    
    let firebaseService = FirebaseService()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Password recovery".localized()
    }
    
    
    @IBAction private func didTapSendButton(_ sender: Any) {
        requestRecovery()
    }
    
    private func requestRecovery() {
        guard let email = emailTextField.text else {
            return
        }
        firebaseService.sendPasswordReset(email: email) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.showAlert(titleMessage: "Success".localized(),
                                   message: "Check your email for the next step".localized())
                }
                self.navigationController?.popViewController(animated: true)
            case .failure(let error):
                self.handleAuthError(error)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension ResetPasswordViewController {
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
