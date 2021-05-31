//
//  Configurator.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 25.05.2021.
//

import Foundation
import Swinject

public class DependencyProvider {
    static let assembler: Assembler = {
        let container = Container()
        let assembler = Assembler([
            AuthServiceAssembly(),
            NetworkServiceAssembly(),
            PersistanceServiceAssembly(),
            ViewBuilderAssembly(),
            RouterAssembly()
        ], container: container)
        return assembler
    }()

    private init() {}
}
