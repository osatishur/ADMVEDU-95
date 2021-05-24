//
//  ResetPasswordPresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 28.04.2021.
//

import FirebaseAuth
import Foundation

protocol ResetPasswordPresenterProtocol: AnyObject {
    func requestRecovery(email: String)
    func navigateToLogIn()
}

class ResetPasswordPresenter: BaseAuthPresenter, ResetPasswordPresenterProtocol {
    private weak var view: ResetPasswordViewProtocol?
    private var router: AuthRouter?

    init(view: ResetPasswordViewProtocol, firebaseService: FirebaseServiceProtocol, router: AuthRouter) {
        super.init()
        self.view = view
        self.firebaseService = firebaseService
        self.router = router
    }

    func requestRecovery(email: String) {
        guard let firebaseService = firebaseService else {
            return
        }
        firebaseService.sendPasswordReset(email: email) { result in
            switch result {
            case .success:
                self.view?.showAlert(title: R.string.localizable.resetPassworSuccessAlertTitle(),
                                     message: R.string.localizable.resetPasswordSuccessAlertMessage())
                self.view?.successRequest()
            case let .failure(error):
                let errorMessage = self.getAuthErrorText(error: error)
                self.view?.showAlert(title: R.string.localizable.alertErrorTitle(),
                                     message: errorMessage)
            }
        }
    }

    func navigateToLogIn() {
        router?.popToLogIn()
    }
}
