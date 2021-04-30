//
//  LoginViewController.swift
//  ADMVEDU95
//
//  Created by Satsishur on 20.04.2021.
//

import UIKit
import FirebaseAuth

class LoginViewController: AuthBaseViewController, UITextFieldDelegate {
    @IBOutlet private weak var topLabel: UILabel!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var emailTextField: AuthTextField!
    @IBOutlet private weak var passwordTextField: AuthTextField!
    @IBOutlet private weak var bottomButton: AuthBottomButton!
    
    var presenter: LogInViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setupLayout() {
        let attributedTitle = createAttributedTitle(firstTtitle: "Don't have an account?  ".localized(), secondTitle: "Sign in".localized())
        bottomButton.setAttributedTitle(attributedTitle, for: .normal)
    }
    
    @IBAction private func didTapLogInButton(_ sender: Any) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text
        else {
            return
        }
        presenter?.logIn(email: email, password: password)
    }
    
    @IBAction private func didTapForgorPasswordButton(_ sender: Any) {
        presenter?.navigateToResetPassword()
    }
    
    @IBAction private func didTapBottomButton(_ sender: Any) {
        presenter?.navigateToSignIn()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension LoginViewController: LogInViewProtocol {
    func successLogIn() {
        presenter?.navigateToHome()
    }
    
    func handleLogInError(error: Error) {
        let error = AuthErrorCode(rawValue: error._code)
        guard let text = error?.errorMessage else {
            return
        }
        errorLabel.text = text
        errorLabel.isHidden = false
    }
    
    func handleFailedToSuccessError() {
        errorLabel.text = "Unknown error occurred".localized()
        errorLabel.isHidden = false
    }
}
