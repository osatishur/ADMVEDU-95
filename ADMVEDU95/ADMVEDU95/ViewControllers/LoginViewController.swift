//
//  LoginViewController.swift
//  ADMVEDU95
//
//  Created by Satsishur on 20.04.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
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
}

extension LoginViewController: LogInDelegate {
    func signInClicked() {
        navigationController?.pushViewController(SignInViewController(), animated: true)
    }
    
    func logInClicked() {
        logIn()
    }
    
    func logIn() {
        guard let email = loginView.mailTF.text,
              let password = loginView.passwordTF.text
        else {
            return
        }
        firebaseService.logIn(email: email, pass: password) {[weak self] (result) in
            guard let self = self else {
                return
            }
            var message: String = ""
            switch result {
            case .success:
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(UINavigationController(rootViewController: HomeViewController()))
            case .failure(let error):
                message = error.localizedDescription

                self.showAlert(titleMessage: "OK", message: message)
            }
        }
    }
}

extension LoginViewController {
    private func showAlert(titleMessage: String, message: String) {
        let alert = UIAlertController(title: titleMessage, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK".localized(), style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}
