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
        container.register(FirebaseServiceProtocol.self) { _ in
            FirebaseService()
        }.inObjectScope(.container)
    }
}
