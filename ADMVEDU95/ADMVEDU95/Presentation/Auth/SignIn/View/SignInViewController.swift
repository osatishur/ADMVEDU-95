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
    @IBOutlet private var signInButton: AuthButton!

    var viewModel: SignInViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        viewModel?.errorText.bind({ [weak self] value in
            self?.setErrorLabelText(text: value ?? "")
        })
        viewModel?.isErrorTextHidden.bind({ [weak self] value in
            self?.setErrorLabelHidden(isHidden: value ?? true)
        })
    }

    private func setupLayout() {
        let attributedTitle = createAttributedTitle(title: R.string.localizable.signInBottomButtonTitle(),
                                                    subTitle: R.string.localizable.authLogInText())
        bottomButton.setAttributedTitle(attributedTitle, for: .normal)
        signInButton.setTitle(R.string.localizable.authSignInText(), for: .normal)
        topLabel.text = R.string.localizable.signInTopLabelText()
        emailTextField.placeholder = R.string.localizable.authEmailPlaceholder()
        passwordTextField.placeholder = R.string.localizable.authPasswordPlaceholder()
        repeatPasswordTextField.placeholder = R.string.localizable.authRepeatPpasswordPlaceholder()
    }

    @IBAction private func didTapSignInButton(_: Any) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let passwordRepeat = repeatPasswordTextField.text
        else {
            return
        }
        viewModel?.signIn(email: email, password: password, repeatPassword: passwordRepeat)
    }

    @IBAction private func didTapBottomButton(_: Any) {
        viewModel?.didTapSignInButton()
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