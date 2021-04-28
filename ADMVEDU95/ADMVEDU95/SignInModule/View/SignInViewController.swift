//
//  SingInViewController.swift
//  ADMVEDU95
//
//  Created by Satsishur on 20.04.2021.
//

import UIKit
import Firebase

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet private weak var topLabel: UILabel!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var emailTextField: AuthTextField!
    @IBOutlet private weak var passwordTextField: AuthTextField!
    @IBOutlet private weak var repeatPasswordTextField: AuthTextField!
    @IBOutlet private weak var bottomButton: AuthBotomButton!
    
    var presenter: SignInViewPresenterProtocol!
    
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
        let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ".localized(), attributes: [NSAttributedString.Key.font: UIFont.regularFont, NSAttributedString.Key.foregroundColor: UIColor.black])
        attributedTitle.append(NSAttributedString(string: "Log in".localized(), attributes: [NSAttributedString.Key.font: UIFont.regularFont, NSAttributedString.Key.foregroundColor: UIColor.systemBlue]))
        bottomButton.setAttributedTitle(attributedTitle, for: .normal)
    }
    
    @IBAction private func didTapSignInButton(_ sender: Any) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let passwordRepeat = repeatPasswordTextField.text
        else {
            return
        }
        presenter.signIn(email: email, password: password, repeatPassword: passwordRepeat)
    }
    
    @IBAction private func didTapBottomButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension SignInViewController: SignInViewProtocol {
    func successSignIn() {
        self.showAlert(titleMessage: "OK".localized(), message: "Sign In is succesful".localized())
        let vc = ModuleBuilder.createHomeModule()
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(UINavigationController(rootViewController: vc))
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

