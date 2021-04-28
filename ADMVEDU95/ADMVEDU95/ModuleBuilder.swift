//
//  ModuleBuilder.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 27.04.2021.
//

import UIKit

protocol Builder {
    static func createHomeModule() -> UIViewController
    static func createDetailModule(dataKind: ResponseDataKind) -> UIViewController
    static func createCategoryModule(categoryChosed: Category, delegate: CategoryDelegate) -> UIViewController
    static func createSignInModule() -> UIViewController
    static func createLogInModule() -> UIViewController
}

class ModuleBuilder: Builder {
    static func createHomeModule() -> UIViewController {
        let view = HomeViewController()
        let searchService = SearchService()
        let firebaseService = FirebaseService()
        let presenter = HomePresenter(view: view, searchService: searchService, firebaseService: firebaseService)
        view.presenter = presenter
        return view
    }
    
    static func createDetailModule(dataKind: ResponseDataKind) -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter(view: view, dataKind: dataKind)
        view.presenter = presenter
        return view
    }
    
    static func createCategoryModule(categoryChosed: Category, delegate: CategoryDelegate) -> UIViewController {
        let view = CategoryViewController()
        let presenter = CategoryPresenter(view: view, categoryChosed: categoryChosed, delegate: delegate)
        view.presenter = presenter
        return view
    }
    
    static func createSignInModule() -> UIViewController {
        let view = SignInViewController()
        let firebaseService = FirebaseService()
        let presenter = SignInPresenter(view: view, firebaseService: firebaseService)
        view.presenter = presenter
        return view
    }
    
    static func createLogInModule() -> UIViewController {
        let view = LoginViewController()
        let firebaseService = FirebaseService()
        let presenter = LogInPresenter(view: view, firebaseService: firebaseService)
        view.presenter = presenter
        return view
    }
    
    static func createResetPasswordModule() -> UIViewController {
        let view = ResetPasswordViewController()
        let firebaseService = FirebaseService()
        let presenter = ResetPasswordPresenter(view: view, firebaseService: firebaseService)
        view.presenter = presenter
        return view
    }
}
