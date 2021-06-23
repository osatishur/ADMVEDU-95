//
//  SignInPresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 28.04.2021.
//

import FirebaseAuth
import Foundation

protocol SignInViewModelProtocol: AnyObject {
    var errorText: Observable<String> { get set }
    var isErrorTextHidden: Observable<Bool> { get set }
    func signIn(email: String, password: String, repeatPassword: String)
    func didTapSignInButton()
    func navigateToHome()
}

class SignInViewModel: BaseAuthViewModel, SignInViewModelProtocol {
    private var router: AuthRouterProtocol?
    var errorText: Observable<String> = Observable(value: "")
    var isErrorTextHidden: Observable<Bool> = Observable(value: true)

    init(firebaseService: FirebaseServiceProtocol, router: AuthRouterProtocol) {
        super.init(firebaseService: firebaseService)
        self.router = router
    }

    func signIn(email: String, password: String, repeatPassword: String) {
        if password != repeatPassword {
            self.setErrorText(text: R.string.localizable.signInPasswordsMatchErrorText())
            self.setIsErrorTextHidden(isHidden: false)
        } else {
            createUser(email: email, password: password)
        }
    }

    private func createUser(email: String, password: String) {
        guard let firebaseService = firebaseService else {
            return
        }
        firebaseService.createUser(email: email, password: password) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(true):
                self.navigateToHome()
            case let .failure(error):
                let errorText = self.getAuthErrorText(error: error)
                self.setErrorText(text: errorText)
                self.setIsErrorTextHidden(isHidden: false)
            case .success(false):
                self.setErrorText(text: R.string.localizable.errorUnknownErrorText())
                self.setIsErrorTextHidden(isHidden: false)
            }
        }
    }

    func didTapSignInButton() {
        router?.popToLogIn()
    }

    func navigateToHome() {
        router?.navigateToHome()
    }

    func setErrorText(text: String) {
        self.errorText.value = text
    }

    func setIsErrorTextHidden(isHidden: Bool) {
        self.isErrorTextHidden.value = isHidden
    }
}
