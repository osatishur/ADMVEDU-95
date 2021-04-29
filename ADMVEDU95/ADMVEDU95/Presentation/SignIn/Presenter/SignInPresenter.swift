//
//  SignInPresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 28.04.2021.
//

import Foundation
import FirebaseAuth

protocol SignInViewProtocol: class {
    func successSignIn()
    func handlePasswordMatchError()
    func handleSignInError(error: AuthErrorCode?)
    func handleFailedToSuccessError()
}

protocol SignInViewPresenterProtocol: class {
    init(view: SignInViewProtocol, firebaseService: FirebaseServiceProtocol)
    func signIn(email: String, password: String, repeatPassword: String)
}

class SignInPresenter: SignInViewPresenterProtocol {
    weak var view: SignInViewProtocol?
    let firebaseService: FirebaseServiceProtocol!

    required init(view: SignInViewProtocol, firebaseService: FirebaseServiceProtocol) {
        self.view = view
        self.firebaseService = firebaseService
    }
    
    func signIn(email: String, password: String, repeatPassword: String) {
        if password != repeatPassword {
            self.view?.handlePasswordMatchError()
        } else {
            createUser(email: email, password: password)
        }
    }
    
    private func createUser(email: String, password: String) {
        firebaseService.createUser(email: email, password: password) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(true):
                self.view?.successSignIn()
            case .failure(let error):
                let error = AuthErrorCode(rawValue: error._code)
                self.view?.handleSignInError(error: error)
            case .success(false):
                self.view?.handleFailedToSuccessError()
            }
        }
    }
}
