//
//  ResetPasswordPresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 28.04.2021.
//

import Foundation

protocol ResetPasswordViewProtocol: AnyObject {
    func successRequest()
    func handleAuthError(_ error: Error)
}

protocol ResetPasswordPresenterProtocol: AnyObject {
    init(view: ResetPasswordViewProtocol, firebaseService: FirebaseServiceProtocol, router: AuthRouter)
    func requestRecovery(email: String)
    func navigateToLogIn()
}

class ResetPasswordPresenter: ResetPasswordPresenterProtocol {
    weak var view: ResetPasswordViewProtocol?
    var router: AuthRouter?
    let firebaseService: FirebaseServiceProtocol!

    required init(view: ResetPasswordViewProtocol, firebaseService: FirebaseServiceProtocol, router: AuthRouter) {
        self.view = view
        self.firebaseService = firebaseService
        self.router = router
    }
    
    func requestRecovery(email: String) {
        firebaseService.sendPasswordReset(email: email) { result in
            switch result {
            case .success:
                self.view?.successRequest()
            case .failure(let error):
                self.view?.handleAuthError(error)
            }
        }
    }
    
    func navigateToLogIn() {
        router?.popToLogIn()
    }
}
