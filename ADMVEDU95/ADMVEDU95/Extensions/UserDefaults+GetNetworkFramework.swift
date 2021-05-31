//
//  UserDefaults+GetNetworkFramework.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 31.05.2021.
//

import Foundation

enum Keys: String {
    case networkFrameworkKey = "networkOption"
}

extension Keys {
    var description: String {
        return self.rawValue
    }
}

extension UserDefaults {
    static func getNetworkFramework() -> NetworkFrameworkSelected {
        let userDefaults = self.standard
        if let networkServiceSelected = userDefaults.object(forKey: Keys.networkFrameworkKey.description) as? String {
            return NetworkFrameworkSelected(rawValue: networkServiceSelected) ?? .alamofire
        } else {
            userDefaults.setValue(NetworkFrameworkSelected.alamofire.rawValue, forKey: Keys.networkFrameworkKey.description)
            return .alamofire
        }
    }
    
    static func setNetworkFramework(framework: NetworkFrameworkSelected) {
        self.standard.setValue(framework.rawValue, forKey: Keys.networkFrameworkKey.description)
    }
}
