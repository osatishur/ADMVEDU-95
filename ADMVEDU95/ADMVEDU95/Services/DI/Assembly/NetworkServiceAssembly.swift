//
//  NetworkServiceAssembly.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 26.05.2021.
//

import Foundation
import Swinject

class NetworkServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SearchServiceProtocol.self) { _ in
            SearchService()
        }.inObjectScope(.container)
    }
}
