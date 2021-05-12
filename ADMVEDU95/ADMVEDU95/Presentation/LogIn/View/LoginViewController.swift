//
//  LoginViewController.swift
//  ADMVEDU95
//
//  Created by Satsishur on 20.04.2021.
//

import FirebaseAuth
import UIKit

protocol LogInViewProtocol: AnyObject {
    func successLogIn()
    func handleLogInError(error: Error)
    func handleFailedToSuccessError(errorText: String)
}

class LoginViewController: BaseAuthViewController, UITextFieldDelegate {
    @IBOutlet private var topLabel: UILabel!
    @IBOutlet private var errorLabel: UILabel!
    @IBOutlet private var emailTextField: AuthTextField!
    @IBOutlet private var passwordTextField: AuthTextField!
    @IBOutlet private var bottomButton: AuthBottomButton!

    var presenter: LogInPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    override func viewWillAppear(_: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    func setupLayout() {
        let firstTitle = "Don't have an account?  ".localized()
        let secondTitle = "Sign in".localized()
        let attributedTitle = createAttributedTitle(firstTtitle: firstTitle, secondTitle: secondTitle)
        bottomButton.setAttributedTitle(attributedTitle, for: .normal)
    }

    @IBAction private func didTapLogInButton(_: Any) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text
        else {
            return
        }
        presenter?.logIn(email: email, password: password)
    }

    @IBAction private func didTapForgorPasswordButton(_: Any) {
        presenter?.navigateToResetPassword()
    }

    @IBAction private func didTapBottomButton(_: Any) {
        presenter?.navigateToSignIn()
    }

    func textFieldShouldReturn(_: UITextField) -> Bool {
        view.endEditing(true)
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

    func handleFailedToSuccessError(errorText: String) {
        errorLabel.text = errorText
        errorLabel.isHidden = false
    }
}
