//
//  LogInPresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 28.04.2021.
//

import Foundation
import FirebaseAuth

protocol LogInPresenterProtocol: AnyObject {
    func logIn(email: String, password: String)
    func navigateToSignIn()
    func navigateToResetPassword()
    func navigateToHome()
}

class LogInPresenter: LogInPresenterProtocol {
    weak var view: LogInViewProtocol?
    var router: AuthRouter?
    let firebaseService: FirebaseServiceProtocol!

    init(view: LogInViewProtocol, firebaseService: FirebaseServiceProtocol, router: AuthRouter) {
        self.view = view
        self.firebaseService = firebaseService
        self.router = router
    }
    
    func logIn(email: String, password: String) {
        firebaseService.logIn(email: email, pass: password) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(true):
                self.view?.successLogIn()
            case .failure(let error):
                self.view?.handleLogInError(error: error)
            case .success(false):
                self.view?.handleFailedToSuccessError(errorText: "Unknown error occurred".localized())
            }
        }
    }
    
    func navigateToResetPassword() {
        router?.showResetPassword()
    }
    
    func navigateToSignIn() {
        router?.showSignIn()
    }
    
    func navigateToHome() {
        router?.navigateToHome()
    }
}
