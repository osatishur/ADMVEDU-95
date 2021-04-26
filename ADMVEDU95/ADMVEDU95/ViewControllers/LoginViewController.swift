//
//  LoginViewController.swift
//  ADMVEDU95
//
//  Created by Satsishur on 20.04.2021.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
<<<<<<< HEAD
    
    private let loginView = LoginView()
=======
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var EmailTF: AuthTextField!
    @IBOutlet weak var PasswordTF: AuthTextField!
    @IBOutlet weak var bottomButton: AuthBotomButton!
>>>>>>> ADMVEDU105
    
    let firebaseService = FirebaseService()

    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD
        view = loginView
        loginView.configureView(viewcontroller: self)
=======
        setupLayout()
>>>>>>> ADMVEDU105
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
<<<<<<< HEAD
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension LoginViewController: LogInDelegate {
    func resetPasswordClicked(_ loginView: LoginView) {
        navigationController?.pushViewController(ResetPasswordViewController(), animated: true)
    }
    
    func signInClicked(_ loginView: LoginView) {
        navigationController?.pushViewController(SignInViewController(), animated: true)
    }
    
    func logInClicked(_ loginView: LoginView) {
        logIn()
    }
    
    func logIn() {
        guard let email = loginView.emailTF.text,
              let password = loginView.passwordTF.text
=======
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
>>>>>>> ADMVEDU105
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
<<<<<<< HEAD
        print(text)
        loginView.setErrorLabelText(text: text)
        loginView.changeErrorLabelVisibility(isHidden: false)
    }
    
    func handleFailedToSuccessError() {
        loginView.setErrorLabelText(text: "Unknown error occurred".localized())
        loginView.changeErrorLabelVisibility(isHidden: false)
=======
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
>>>>>>> ADMVEDU105
    }
}
