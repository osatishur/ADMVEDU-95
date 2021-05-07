//
//  SingInViewController.swift
//  ADMVEDU95
//
//  Created by Satsishur on 20.04.2021.
//

import Firebase
import UIKit

protocol SignInViewProtocol: AnyObject {
    func successSignIn()
    func handlePasswordMatchError(errorText: String)
    func handleSignInError(error: AuthErrorCode?)
    func handleFailedToSuccessError(errorText: String)
}

class SignInViewController: BaseAuthViewController, UITextFieldDelegate {
    @IBOutlet private var topLabel: UILabel!
    @IBOutlet private var errorLabel: UILabel!
    @IBOutlet private var emailTextField: AuthTextField!
    @IBOutlet private var passwordTextField: AuthTextField!
    @IBOutlet private var repeatPasswordTextField: AuthTextField!
    @IBOutlet private var bottomButton: AuthBottomButton!

    var presenter: SignInPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
        let attributedTitle = createAttributedTitle(firstTtitle: "Already have an account?  ".localized(), secondTitle: "Log in".localized())
        bottomButton.setAttributedTitle(attributedTitle, for: .normal)
    }

    @IBAction private func didTapSignInButton(_: Any) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let passwordRepeat = repeatPasswordTextField.text
        else {
            return
        }
        presenter?.signIn(email: email, password: password, repeatPassword: passwordRepeat)
    }

    @IBAction private func didTapBottomButton(_: Any) {
        presenter?.navigateToLogIn()
    }

    func textFieldShouldReturn(_: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}

extension SignInViewController: SignInViewProtocol {
    func successSignIn() {
        presenter?.navigateToHome()
    }

    func handlePasswordMatchError(errorText: String) {
        errorLabel.text = errorText
        errorLabel.isHidden = false
    }

    func handleSignInError(error: AuthErrorCode?) {
        guard let text = error?.errorMessage else {
            return
        }
        errorLabel.text = text.localized()
        errorLabel.isHidden = false
    }

    func handleFailedToSuccessError(errorText: String) {
        errorLabel.text = errorText
        errorLabel.isHidden = false
    }
}
