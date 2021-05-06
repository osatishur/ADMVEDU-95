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
                self.navigateToHome()
            case .failure(let error):
                let errorText = self.getAuthErrorText(error: error)
                self.view?.setErrorLabelText(text: errorText)
                self.view?.setErrorLabelHidden(isHidden: false)
            case .success(false):
                self.view?.setErrorLabelText(text: "Unknown error occurred".localized())
                self.view?.setErrorLabelHidden(isHidden: false)
            }
        }
    }
    
    private func getAuthErrorText(error: Error) -> String {
        let error = AuthErrorCode(rawValue: error._code)
        guard let text = error?.errorMessage else {
            return "no info".localized()
        }
        return text
    }
    
    func navigateToResetPassword() {
        router?.navigateToResetPassword()
    }
    
    func navigateToSignIn() {
        router?.navigateToSignIn()
    }
    
    func navigateToHome() {
        router?.navigateToHome()
    }
}
