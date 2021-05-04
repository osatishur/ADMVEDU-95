//
//  SingInViewController.swift
//  ADMVEDU95
//
//  Created by Satsishur on 20.04.2021.
//

import UIKit
import Firebase

class SignInViewController: AuthBaseViewController, UITextFieldDelegate {
    
    @IBOutlet private weak var topLabel: UILabel!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var emailTextField: AuthTextField!
    @IBOutlet private weak var passwordTextField: AuthTextField!
    @IBOutlet private weak var repeatPasswordTextField: AuthTextField!
    @IBOutlet private weak var bottomButton: AuthBottomButton!
    
    var presenter: SignInPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
        let attributedTitle = createAttributedTitle(firstTtitle: "Already have an account?  ".localized(), secondTitle: "Log in".localized())
        bottomButton.setAttributedTitle(attributedTitle, for: .normal)
    }
    
    @IBAction private func didTapSignInButton(_ sender: Any) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let passwordRepeat = repeatPasswordTextField.text else {
            return
        }
        presenter?.signIn(email: email, password: password, repeatPassword: passwordRepeat)
    }
    
    @IBAction private func didTapBottomButton(_ sender: Any) {
        presenter?.navigateToLogIn()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension SignInViewController: SignInViewProtocol {
    func successSignIn() {
        presenter?.navigateToHome()
    }
    
    func handlePasswordMatchError() {
        errorLabel.text = "Password doesn't match".localized()
        errorLabel.isHidden = false
    }
    
    func handleSignInError(error: AuthErrorCode?) {
        guard let text = error?.errorMessage else {
            return
        }
        errorLabel.text = text.localized()
        errorLabel.isHidden = false
    }
    
    func handleFailedToSuccessError() {
        errorLabel.text = "Unknown error occurred".localized()
        errorLabel.isHidden = false
    }
}

