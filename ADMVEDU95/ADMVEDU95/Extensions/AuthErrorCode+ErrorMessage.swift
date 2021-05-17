//
//  AuthErrorCode+ErrorMessage.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 21.04.2021.
//

import Firebase
import UIKit

extension AuthErrorCode {
    var errorMessage: String {
        switch self {
        case .emailAlreadyInUse:
            return R.string.localizable.authErrorCodeEmailAlreadyInUseText()
        case .userNotFound:
            return R.string.localizable.authErrorCodeUserNotFoundText()
        case .userDisabled:
            return R.string.localizable.authErrorCodeUserDisabledText()
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            return R.string.localizable.authErrorCodeInvalidEmailText()
        case .networkError:
            return R.string.localizable.authErrorCodeNetworkErrorText()
        case .weakPassword:
            return R.string.localizable.authErrorCodeWeakPasswordText()
        case .wrongPassword:
            return R.string.localizable.authErrorCodeWrongPasswordText()
        default:
            return R.string.localizable.errorUnknownErrorText()
        }
    }
}
