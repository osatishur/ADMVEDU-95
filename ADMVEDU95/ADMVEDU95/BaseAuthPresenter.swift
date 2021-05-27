//
//  BasePresenter.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 20.05.2021.
//

import Foundation
import FirebaseAuth

class BaseAuthPresenter {
    var firebaseService: FirebaseServiceProtocol?

    init(firebaseService: FirebaseServiceProtocol) {
        self.firebaseService = firebaseService
    }

    func getAuthErrorText(error: Error) -> String {
        let error = AuthErrorCode(rawValue: error._code)
        guard let text = error?.errorMessage else {
            return R.string.localizable.noInfo()
        }
        return text
    }
}
