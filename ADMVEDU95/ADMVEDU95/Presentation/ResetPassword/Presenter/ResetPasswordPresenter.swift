//
//  ResetPasswordPresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 28.04.2021.
//

import Foundation

protocol ResetPasswordViewProtocol: class {
    func successRequest()
    func handleAuthError(_ error: Error)
}

protocol ResetPasswordViewPresenterProtocol: class {
    init(view: ResetPasswordViewProtocol, firebaseService: FirebaseServiceProtocol, router: AuthFlowRouter)
    func requestRecovery(email: String)
    func navigateToLogIn()
}

class ResetPasswordPresenter: ResetPasswordViewPresenterProtocol {
    weak var view: ResetPasswordViewProtocol?
    var router: AuthFlowRouter?
    let firebaseService: FirebaseServiceProtocol!

    required init(view: ResetPasswordViewProtocol, firebaseService: FirebaseServiceProtocol, router: AuthFlowRouter) {
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
