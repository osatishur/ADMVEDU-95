//
//  SingInViewController.swift
//  ADMVEDU95
//
//  Created by Satsishur on 20.04.2021.
//

import UIKit
import Firebase

class SignInViewController: UIViewController, UITextFieldDelegate {
    let signView = SignInView()
    
    let firebaseService = FirebaseService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view = signView
        signView.configureView(viewcontroller: self)
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

extension SignInViewController: SignInDelegate {
    func logInClicked(_ signInView: SignInView) {
        navigationController?.popViewController(animated: true)
    }
    
    func signInClicked(_ signInView: SignInView) {
        signIn()
    }
    
    func signIn() {
        guard let email = signView.emailTF.text,
              let password = signView.passwordTF.text,
              let passwordRepeat = signView.repeatPasswordTF.text
        else {
            return
        }
        if password != passwordRepeat {
            handlePasswordMatchError()
        } else {
            createUser(email: email, password: password)
        }
    }
    
    func createUser(email: String, password: String) {
        firebaseService.createUser(email: email, password: password) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(true):
                self.showAlert(titleMessage: "OK".localized(), message: "Sign In is succesful".localized())
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(UINavigationController(rootViewController: HomeViewController()))
            case .failure(let error):
                let error = AuthErrorCode(rawValue: error._code)
                self.handleSignInError(error: error)
            case .success(false): 
                self.handleFailedToSuccessError()
            }
        }
    }
    
    func handlePasswordMatchError() {
        signView.setErrorLabelText(text: "Password doesn't match".localized())
        signView.changeErrorLabelVisibility(isHidden: false)
    }
    
    func handleSignInError(error: AuthErrorCode?) {
        guard let text = error?.errorMessage else {
            return
        }
        signView.setErrorLabelText(text: text)
        signView.changeErrorLabelVisibility(isHidden: false)
    }
    
    func handleFailedToSuccessError() {
        signView.setErrorLabelText(text: "Unknown error occurred".localized())
        signView.changeErrorLabelVisibility(isHidden: false)
    }
}
