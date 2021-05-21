//
//  ResetPasswordViewController.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 21.04.2021.
//

import FirebaseAuth
import UIKit

protocol ResetPasswordViewProtocol: AnyObject {
    func showAlert(title: String, message: String)
}

class ResetPasswordViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet private var topLabel: UILabel!
    @IBOutlet private var emailTextField: AuthTextField!
    @IBOutlet private var sendButton: AuthButton!

    var presenter: ResetPasswordPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
    }

    private func setupNavigationBar() {
        navigationItem.title = R.string.localizable.resetPasswordNavigationItemTitle()
    }

    private func setupViews() {
        topLabel.text = R.string.localizable.resetPasswordTopLabelText()
        sendButton.setTitle(R.string.localizable.resetPasswordSendButtonText(), for: .normal)
    }

    @IBAction private func didTapSendButton(_: Any) {
        guard let email = emailTextField.text else {
            return
        }
        presenter?.requestRecovery(email: email)
    }

    func textFieldShouldReturn(_: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}

extension ResetPasswordViewController: ResetPasswordViewProtocol {
    func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            self.showAlert(titleMessage: title, message: message)
        }
    }
}
