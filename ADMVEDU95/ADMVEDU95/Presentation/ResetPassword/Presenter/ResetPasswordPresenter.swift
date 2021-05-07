//
//  ResetPasswordPresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 28.04.2021.
//

import Foundation

protocol ResetPasswordPresenterProtocol: AnyObject {
    func requestRecovery(email: String)
    func navigateToLogIn()
}

class ResetPasswordPresenter: ResetPasswordPresenterProtocol {
    weak var view: ResetPasswordViewProtocol?
    var router: AuthRouter?
    let firebaseService: FirebaseServiceProtocol!

    init(view: ResetPasswordViewProtocol, firebaseService: FirebaseServiceProtocol, router: AuthRouter) {
        self.view = view
        self.firebaseService = firebaseService
        self.router = router
    }

    func requestRecovery(email: String) {
        firebaseService.sendPasswordReset(email: email) { result in
            switch result {
            case .success:
                self.view?.successRequest(title: "Success".localized(), message: "Check your email for the next step".localized())
            case let .failure(error):
                self.view?.handleAuthError(error, alertTitle: "Error".localized())
            }
        }
    }

    func navigateToLogIn() {
        router?.popToLogIn()
    }
}
