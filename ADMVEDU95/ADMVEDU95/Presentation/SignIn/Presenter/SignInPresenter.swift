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
    func navigateToLogIn()
    func navigateToHome()
}

class SignInPresenter: SignInPresenterProtocol {
    weak var view: SignInViewProtocol?
    var router: AuthRouter?
    let firebaseService: FirebaseServiceProtocol!

    init(view: SignInViewProtocol, firebaseService: FirebaseServiceProtocol, router: AuthRouter) {
        self.view = view
        self.firebaseService = firebaseService
        self.router = router
    }

    func signIn(email: String, password: String, repeatPassword: String) {
        if password != repeatPassword {
            view?.handlePasswordMatchError(errorText: "Password doesn't match".localized())
        } else {
            createUser(email: email, password: password)
        }
    }

    private func createUser(email: String, password: String) {
        firebaseService.createUser(email: email, password: password) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(true):
                self.view?.successSignIn()
            case let .failure(error):
                let error = AuthErrorCode(rawValue: error._code)
                self.view?.handleSignInError(error: error)
            case .success(false):
                self.view?.handleFailedToSuccessError(errorText: "Unknown error occurred".localized())
            }
        }
    }

    func navigateToLogIn() {
        router?.popToLogIn()
    }

    func navigateToHome() {
        router?.navigateToHome()
    }
}
