//
//  SignInPresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 28.04.2021.
//

import FirebaseAuth
import Foundation

protocol SignInPresenterProtocol: AnyObject {
    func signIn(email: String, password: String, repeatPassword: String)
    func didTapOnBottomButton()
    func navigateToHome()
}

class SignInPresenter: BaseAuthPresenter, SignInPresenterProtocol {
    private weak var view: SignInViewProtocol?
    private var router: AuthRouter?

    init(view: SignInViewProtocol, firebaseService: FirebaseServiceProtocol, router: AuthRouter) {
        super.init(firebaseService: firebaseService)
        self.view = view
        self.router = router
    }

    func signIn(email: String, password: String, repeatPassword: String) {
        if password != repeatPassword {
            view?.setErrorLabelText(text: R.string.localizable.signInPasswordsMatchErrorText())
            view?.setErrorLabelHidden(isHidden: false)
        } else {
            createUser(email: email, password: password)
        }
    }

    private func createUser(email: String, password: String) {
        guard let firebaseService = firebaseService else {
            return
        }
        firebaseService.createUser(email: email, password: password) { [weak self] result in
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

    func didTapSignInButton() 
        router?.popToLogIn()
    }

    func navigateToHome() {
        router?.navigateToHome()
    }
}
