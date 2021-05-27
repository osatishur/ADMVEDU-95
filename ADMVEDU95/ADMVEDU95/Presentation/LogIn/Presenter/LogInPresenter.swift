//
//  LogInPresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 28.04.2021.
//

import FirebaseAuth
import Foundation

protocol LogInPresenterProtocol: AnyObject {
    func logIn(email: String, password: String)
    func didTapOnSignInButton()
    func didTapOnResetPasswordButton()
    func navigateToHome()
}

class LogInPresenter: BaseAuthPresenter, LogInPresenterProtocol {
    private weak var view: LogInViewProtocol?
    private var router: AuthRouter?

    init(view: LogInViewProtocol, firebaseService: FirebaseServiceProtocol, router: AuthRouter) {
        super.init(firebaseService: firebaseService)
        self.view = view
        self.router = router
    }

    func logIn(email: String, password: String) {
        guard let firebaseService = firebaseService else {
            return
        }
        firebaseService.logIn(email: email, pass: password) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(true):
                self.navigateToHome()
            case let .failure(error):
                let errorText = self.getAuthErrorText(error: error)
                self.view?.setErrorLabelText(text: errorText)
                self.view?.setErrorLabelHidden(isHidden: false)
            case .success(false):
                self.view?.setErrorLabelText(text: R.string.localizable.errorUnknownErrorText())
                self.view?.setErrorLabelHidden(isHidden: false)
            }
        }
    }


    func navigateToResetPassword() {
        router?.navigateToResetPassword()
    }

    func didTapOnSignInButton() {
        router?.navigateToSignIn()
    }

    func navigateToHome() {
        router?.navigateToHome()
    }
}
