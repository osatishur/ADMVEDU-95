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
                self.view?.successRequest(title: R.string.localizable.success(),
                                          message: R.string.localizable.checkYourEmailForTheNextStep())
            case let .failure(error):
                let errorMessage = self.getAuthErrorText(error)
                self.view?.showAlert(title: R.string.localizable.error(), message: errorMessage)
            }
        }
    }

    private func getAuthErrorText(_ error: Error) -> String {
        let error = AuthErrorCode(rawValue: error._code)
        guard let text = error?.errorMessage else {
            return R.string.localizable.noInfo()
        }
        return text
    }

    func navigateToLogIn() {
        router?.popToLogIn()
    }
}
