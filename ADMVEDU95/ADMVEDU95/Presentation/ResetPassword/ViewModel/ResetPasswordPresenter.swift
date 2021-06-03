//
//  ResetPasswordPresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 28.04.2021.
//

import FirebaseAuth
import Foundation

protocol ResetPasswordViewModelProtocol: AnyObject {
    var alertInfo: Observable<(title: String, message: String)> { get set }
    func requestRecovery(email: String)
    func navigateToLogIn()
}

class ResetPasswordViewModel: BaseAuthPresenter, ResetPasswordViewModelProtocol {
    private var router: AuthRouterProtocol?
    var alertInfo: Observable<(title: String, message: String)> = Observable(value: (title: "", message: ""))

    init(firebaseService: FirebaseServiceProtocol, router: AuthRouterProtocol) {
        super.init(firebaseService: firebaseService)
        self.router = router
    }

    func requestRecovery(email: String) {
        guard let firebaseService = firebaseService else {
            return
        }
        firebaseService.sendPasswordReset(email: email) { result in
            switch result {
            case .success:
                self.setAlertInfo(title: R.string.localizable.resetPassworSuccessAlertTitle(),
                                  message: R.string.localizable.resetPasswordSuccessAlertMessage())
                self.navigateToLogIn()
            case let .failure(error):
                let errorMessage = self.getAuthErrorText(error: error)
                self.setAlertInfo(title: R.string.localizable.alertErrorTitle(), message: errorMessage)
            }
        }
    }

    func navigateToLogIn() {
        router?.popToLogIn()
    }

    func setAlertInfo(title: String, message: String) {
        alertInfo.value = (title: title, message: message)
    }
}
