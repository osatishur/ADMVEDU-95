//
//  SingInViewController.swift
//  ADMVEDU95
//
//  Created by Satsishur on 20.04.2021.
//

import Firebase
import UIKit

protocol SignInViewProtocol: AnyObject {
    func setErrorLabelHidden(isHidden: Bool)
    func setErrorLabelText(text: String)
}

class SignInViewController: BaseAuthViewController, UITextFieldDelegate {
    @IBOutlet private var topLabel: UILabel!
    @IBOutlet private var errorLabel: UILabel!
    @IBOutlet private var emailTextField: AuthTextField!
    @IBOutlet private var passwordTextField: AuthTextField!
    @IBOutlet private var repeatPasswordTextField: AuthTextField!
    @IBOutlet private var bottomButton: UIButton!

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
        let attributedTitle = createAttributedTitle(title: R.string.localizable.alreadyHaveAnAccount(),
                                                    subTitle: R.string.localizable.logIn())
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
        presenter?.didTapSignInButton()
    }

    func textFieldShouldReturn(_: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}

extension SignInViewController: SignInViewProtocol {
    func setErrorLabelHidden(isHidden: Bool) {
        errorLabel.isHidden = isHidden
    }

    func setErrorLabelText(text: String) {
        errorLabel.text = text
    }
}
