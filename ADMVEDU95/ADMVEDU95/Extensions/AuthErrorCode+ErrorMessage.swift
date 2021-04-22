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
            return "The email is already in use with another account".localized()
        case .userNotFound:
            return "Account not found for the specified user. Please check and try again".localized()
        case .userDisabled:
            return "Your account has been disabled. Please contact support.".localized()
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            return "Please enter a valid email".localized()
        case .networkError:
            return "Network error. Please try again.".localized()
        case .weakPassword:
            return "The password must be 6 characters long or more.".localized()
        case .wrongPassword:
            return "Your password is incorrect. Please try again or use 'Forgot password'".localized()
        default:
            return "Unknown error occurred".localized()
        }
    }
}
