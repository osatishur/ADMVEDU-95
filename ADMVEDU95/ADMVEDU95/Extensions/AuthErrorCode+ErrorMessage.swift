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
            return R.string.localizable.theEmailIsAlreadyInUseWithAnotherAccount()
        case .userNotFound:
            return R.string.localizable.accountNotFoundForTheSpecifiedUserPleaseCheckAndTryAgain()
        case .userDisabled:
            return R.string.localizable.yourAccountHasBeenDisabledPleaseContactSupport()
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            return R.string.localizable.pleaseEnterAValidEmail()
        case .networkError:
            return R.string.localizable.networkErrorPleaseTryAgain()
        case .weakPassword:
            return R.string.localizable.thePasswordMustBe6CharactersLongOrMore()
        case .wrongPassword:
            return R.string.localizable.yourPasswordIsIncorrectPleaseTryAgainOrUseForgotPassword()
        default:
            return R.string.localizable.unknownErrorOccurred()
        }
    }
}
