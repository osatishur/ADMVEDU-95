//
//  LogInPresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 28.04.2021.
//

import Foundation

protocol LogInViewProtocol: AnyObject {
    func successLogIn()
    func handleLogInError(error: Error)
    func handleFailedToSuccessError()
}

protocol LogInPresenterProtocol: AnyObject {
    init(view: LogInViewProtocol, firebaseService: FirebaseServiceProtocol, router: AuthRouter)
    func logIn(email: String, password: String)
    func navigateToSignIn()
    func navigateToResetPassword()
    func navigateToHome()
}

class LogInPresenter: LogInPresenterProtocol {
    weak var view: LogInViewProtocol?
    var router: AuthRouter?
    let firebaseService: FirebaseServiceProtocol!

    required init(view: LogInViewProtocol, firebaseService: FirebaseServiceProtocol, router: AuthRouter) {
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
                self.view?.handleFailedToSuccessError()
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
