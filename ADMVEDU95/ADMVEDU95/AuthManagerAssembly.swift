//
//  AuthManagerAssembly.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 26.05.2021.
//

import Foundation
import Swinject

class AuthServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(LocalAuthManager.self) { _ in
            DefaultLocalAuthManager(reason: R.string.localizable.default_auth_reason())
        }.inObjectScope(.container)

    }
}
