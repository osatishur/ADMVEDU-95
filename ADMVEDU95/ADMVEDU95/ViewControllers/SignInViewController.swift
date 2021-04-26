//
//  SingInViewController.swift
//  ADMVEDU95
//
//  Created by Satsishur on 20.04.2021.
//

import UIKit
import Firebase

class SignInViewController: UIViewController, UITextFieldDelegate {
<<<<<<< HEAD
    let signView = SignInView()
=======
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTF: AuthTextField!
    @IBOutlet weak var passwordTF: AuthTextField!
    @IBOutlet weak var repeatPasswordTF: AuthTextField!
    @IBOutlet weak var bottomButton: AuthBotomButton!
>>>>>>> ADMVEDU105
    
    let firebaseService = FirebaseService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
<<<<<<< HEAD
        view = signView
        signView.configureView(viewcontroller: self)
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
=======
    func setupLayout() {
        let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ".localized(), attributes: [NSAttributedString.Key.font: UIFont.regularFont, NSAttributedString.Key.foregroundColor: UIColor.black])
        attributedTitle.append(NSAttributedString(string: "Log in".localized(), attributes: [NSAttributedString.Key.font: UIFont.regularFont, NSAttributedString.Key.foregroundColor: UIColor.systemBlue]))
        bottomButton.setAttributedTitle(attributedTitle, for: .normal)
    }
    
    @IBAction func didTapSignInButton(_ sender: Any) {
        signIn()
    }
    
    
    @IBAction func didTapBottomButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func signIn() {
        guard let email = emailTF.text,
              let password = passwordTF.text,
              let passwordRepeat = repeatPasswordTF.text
>>>>>>> ADMVEDU105
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
<<<<<<< HEAD
            case .success(false): 
=======
            case .success(false):
>>>>>>> ADMVEDU105
                self.handleFailedToSuccessError()
            }
        }
    }
    
    func handlePasswordMatchError() {
<<<<<<< HEAD
        signView.setErrorLabelText(text: "Password doesn't match".localized())
        signView.changeErrorLabelVisibility(isHidden: false)
=======
        errorLabel.text = "Password doesn't match".localized()
        errorLabel.isHidden = false
>>>>>>> ADMVEDU105
    }
    
    func handleSignInError(error: AuthErrorCode?) {
        guard let text = error?.errorMessage else {
            return
        }
<<<<<<< HEAD
        signView.setErrorLabelText(text: text)
        signView.changeErrorLabelVisibility(isHidden: false)
    }
    
    func handleFailedToSuccessError() {
        signView.setErrorLabelText(text: "Unknown error occurred".localized())
        signView.changeErrorLabelVisibility(isHidden: false)
    }
}
=======
        errorLabel.text = text.localized()
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

>>>>>>> ADMVEDU105
