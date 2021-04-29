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
    init(view: ResetPasswordViewProtocol, firebaseService: FirebaseServiceProtocol)
    func requestRecovery(email: String)
}

class ResetPasswordPresenter: ResetPasswordViewPresenterProtocol {
    weak var view: ResetPasswordViewProtocol?
    let firebaseService: FirebaseServiceProtocol!

    required init(view: ResetPasswordViewProtocol, firebaseService: FirebaseServiceProtocol) {
        self.view = view
        self.firebaseService = firebaseService
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
}
