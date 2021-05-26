//
//  PersistanceServiceAssembly.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 26.05.2021.
//

import Foundation
import Swinject

class PersistanceServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(FileManager.self) { _ in
            return FileManager.default
        }.inObjectScope(.container)

        container.register(FileManagerServiceProtocol.self) { resolver in
            let fileManagerServie = FileManagerService()
            fileManagerServie.fileManager = resolver.resolve(FileManager.self)
            return fileManagerServie
        }.inObjectScope(.container)

        container.register(CoreDataServiceProtocol.self) { resolver in
            let coreDataService = CoreDataService()
            coreDataService.fileManagerService = resolver.resolve(FileManagerServiceProtocol.self)
            return coreDataService
        }.inObjectScope(.container)
    }
}
