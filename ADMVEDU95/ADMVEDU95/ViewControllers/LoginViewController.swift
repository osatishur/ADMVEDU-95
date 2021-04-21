//
//  LoginViewController.swift
//  ADMVEDU95
//
//  Created by Satsishur on 20.04.2021.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    private let loginView = LoginView()
    
    let firebaseService = FirebaseService()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = loginView
        loginView.configureView(viewcontroller: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension LoginViewController: LogInDelegate {
    func resetPasswordClicked() {
        navigationController?.pushViewController(ResetPasswordViewController(), animated: true)
    }
    
    func signInClicked() {
        navigationController?.pushViewController(SignInViewController(), animated: true)
    }
    
    func logInClicked() {
        logIn()
    }
    
    func logIn() {
        guard let email = loginView.emailTF.text,
              let password = loginView.passwordTF.text
        else {
            return
        }
        firebaseService.logIn(email: email, pass: password) {[weak self] (result) in
            guard let self = self else {
                return
            }
            switch result {
            case .success:
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(UINavigationController(rootViewController: HomeViewController()))
            case .failure(let error):
                let error = AuthErrorCode(rawValue: error._code)
                self.handleLogInError(error: error)
            }
        }
    }
    
    func handleLogInError(error: AuthErrorCode?) {
        guard let text = error?.errorMessage else {
            return
        }
        print(text)
        loginView.setErrorLabelText(text: text)
        loginView.changeErrorLabelVisibility(isHidden: false)
    }
}
