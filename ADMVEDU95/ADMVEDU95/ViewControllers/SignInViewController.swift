//
//  SingInViewController.swift
//  ADMVEDU95
//
//  Created by Satsishur on 20.04.2021.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
    let signView = SingInView()
    
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
}

extension SignInViewController: SignInDelegate {
    func logInClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    func signInClicked() {
        signIn()
    }
    
    func signIn() {
        guard let email = signView.mailTF.text,
              let password = signView.passwordTF.text,
              let passwordRepeat = signView.repeatPasswordTF.text
        else {
            return
        }
        if password != passwordRepeat {
            showAlert(titleMessage: "Error", message: "Passwords don't match")
            return
        }
        firebaseService.createUser(email: email, password: password) {[weak self] (result) in
            guard let self = self else {
                return
            }
            var message: String = ""
            switch result {
            case .success:
                self.showAlert(titleMessage: "OK", message: "Sign in is succesful")
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(UINavigationController(rootViewController: HomeViewController()))
            case .failure(let error):
                message = error.localizedDescription
                self.showAlert(titleMessage: "Error", message: message)
            }
        }
    }
}

extension SignInViewController {
    private func showAlert(titleMessage: String, message: String) {
        let alert = UIAlertController(title: titleMessage, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK".localized(), style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}
