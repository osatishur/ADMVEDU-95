//
//  LogInPresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 28.04.2021.
//

import Foundation

protocol LogInViewProtocol: class {
    func successLogIn()
    func handleLogInError(error: Error)
    func handleFailedToSuccessError()
}

protocol LogInViewPresenterProtocol: class {
    init(view: LogInViewProtocol, firebaseService: FirebaseServiceProtocol, router: AuthFlowRouter)
    func logIn(email: String, password: String)
    func navigateToSignIn()
    func navigateToResetPassword()
}

class LogInPresenter: LogInViewPresenterProtocol {
    weak var view: LogInViewProtocol?
    var router: AuthFlowRouter?
    let firebaseService: FirebaseServiceProtocol!

    required init(view: LogInViewProtocol, firebaseService: FirebaseServiceProtocol, router: AuthFlowRouter) {
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
}
