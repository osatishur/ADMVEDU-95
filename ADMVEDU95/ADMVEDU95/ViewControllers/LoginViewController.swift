//
//  LoginViewController.swift
//  ADMVEDU95
//
//  Created by Satsishur on 20.04.2021.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var EmailTF: AuthTextField!
    @IBOutlet weak var PasswordTF: AuthTextField!
    @IBOutlet weak var bottomButton: AuthBotomButton!
    
    let firebaseService = FirebaseService()

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
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account?  ".localized(), attributes: [NSAttributedString.Key.font: UIFont.regularFont, NSAttributedString.Key.foregroundColor: UIColor.black])
        attributedTitle.append(NSAttributedString(string: "Sign in".localized(), attributes: [NSAttributedString.Key.font: UIFont.regularFont, NSAttributedString.Key.foregroundColor: UIColor.systemBlue]))
        bottomButton.setAttributedTitle(attributedTitle, for: .normal)
    }
    
    @IBAction func didTapLogInButton(_ sender: Any) {
        logIn()
    }
    
    @IBAction func didTapForgorPasswordButton(_ sender: Any) {
        navigationController?.pushViewController(ResetPasswordViewController(), animated: true)
    }
    
    @IBAction func didTapBottomButton(_ sender: Any) {
        navigationController?.pushViewController(SignInViewController(), animated: true)
    }
    
    func logIn() {
        guard let email = EmailTF.text,
              let password = PasswordTF.text
        else {
            return
        }
        firebaseService.logIn(email: email, pass: password) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(true):
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(UINavigationController(rootViewController: HomeViewController()))
            case .failure(let error):
                self.handleLogInError(error: error)
            case .success(false):
                self.handleFailedToSuccessError()
            }
        }
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
