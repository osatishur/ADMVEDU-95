//
//  ResetPasswordViewController.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 21.04.2021.
//

import UIKit
import FirebaseAuth

class ResetPasswordViewController: UIViewController, UITextFieldDelegate {
    
<<<<<<< HEAD
    let resetPasswordView = ResetPasswordView()
=======
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var emailTF: AuthTextField!
    
>>>>>>> ADMVEDU105
    let firebaseService = FirebaseService()

    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD
        view = resetPasswordView
        resetPasswordView.configureView(viewController: self)
=======
>>>>>>> ADMVEDU105
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Password recovery".localized()
    }
    
<<<<<<< HEAD
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension ResetPasswordViewController: ResetPasswordDelegate {
    func requestRecovery() {
        guard let email = resetPasswordView.emailTF.text else {
=======
    
    @IBAction func didTapSendButton(_ sender: Any) {
        requestRecovery()
    }
    
    func requestRecovery() {
        guard let email = emailTF.text else {
>>>>>>> ADMVEDU105
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
<<<<<<< HEAD
=======
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
>>>>>>> ADMVEDU105
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
